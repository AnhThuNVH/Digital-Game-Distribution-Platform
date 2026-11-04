<?php
// =============================================================================
// BASE MODEL - PDO wrapper with CRUD helpers
// Every value goes through a bound parameter. Identifiers (table, column,
// ORDER BY) can't be bound, so they are checked against a strict pattern.
// =============================================================================

class Model {
    protected static $db = null;
    protected static $table = '';
    protected static $pk = 'ma';

    public static function db(): PDO {
        if (self::$db === null) {
            try {
                $dsn = 'mysql:host=' . DB_HOST . ';port=' . DB_PORT . ';dbname=' . DB_NAME . ';charset=utf8mb4';
                self::$db = new PDO($dsn, DB_USER, DB_PASS, [
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES   => false,
                ]);
                self::$db->exec("SET time_zone = '" . (new DateTime('now', new DateTimeZone(APP_TIMEZONE)))->format('P') . "'");
            } catch (PDOException $e) {
                http_response_code(500);
                error_log('Database connection failed: ' . $e->getMessage());
                die('Không kết nối được cơ sở dữ liệu. Hãy bật MySQL trong XAMPP và kiểm tra config/config.php.');
            }
        }
        return self::$db;
    }

    /** Guard an SQL identifier (column or table name). */
    protected static function ident(string $name): string {
        if (!preg_match('/^[a-z_][a-z0-9_]{0,63}$/', $name)) {
            throw new InvalidArgumentException('Invalid SQL identifier.');
        }
        return $name;
    }

    /** Guard an ORDER BY clause: "col [ASC|DESC], col2 ..." only. */
    protected static function orderClause(string $orderBy): string {
        $parts = [];
        foreach (explode(',', $orderBy) as $part) {
            if (!preg_match('/^\s*([a-z_][a-z0-9_]*)(?:\s+(ASC|DESC))?\s*$/i', $part, $m)) {
                throw new InvalidArgumentException('Invalid ORDER BY clause.');
            }
            $parts[] = $m[1] . (isset($m[2]) ? ' ' . strtoupper($m[2]) : '');
        }
        return implode(', ', $parts);
    }

    public static function all(string $orderBy = '', int $limit = 0): array {
        $sql = 'SELECT * FROM ' . static::$table;
        if ($orderBy !== '') $sql .= ' ORDER BY ' . self::orderClause($orderBy);
        if ($limit > 0) $sql .= ' LIMIT ' . $limit;
        return self::query($sql);
    }

    public static function find(mixed $id): ?array {
        return self::one('SELECT * FROM ' . static::$table . ' WHERE ' . static::$pk . ' = :id LIMIT 1', [':id' => $id]);
    }

    public static function findBy(string $column, mixed $value): ?array {
        return self::one('SELECT * FROM ' . static::$table . ' WHERE ' . self::ident($column) . ' = :v LIMIT 1', [':v' => $value]);
    }

    public static function findAllBy(string $column, mixed $value): array {
        return self::query('SELECT * FROM ' . static::$table . ' WHERE ' . self::ident($column) . ' = :v', [':v' => $value]);
    }

    public static function insert(array $data): int {
        $stmt = static::prepareInsert($data);
        $stmt->execute(self::bindKeys($data));
        return (int)self::db()->lastInsertId();
    }

    public static function insertRow(array $data): bool {
        $stmt = static::prepareInsert($data);
        return $stmt->execute(self::bindKeys($data));
    }

    protected static function prepareInsert(array $data): PDOStatement {
        $cols = array_map([self::class, 'ident'], array_keys($data));
        $sql = 'INSERT INTO ' . static::$table . ' (' . implode(', ', $cols) . ') VALUES (:' . implode(', :', $cols) . ')';
        return self::db()->prepare($sql);
    }

    private static function bindKeys(array $data): array {
        $bound = [];
        foreach ($data as $key => $value) {
            $bound[':' . $key] = $value;
        }
        return $bound;
    }

    public static function update(mixed $id, array $data): bool {
        if (empty($data)) return false;
        $sets = [];
        foreach (array_keys($data) as $col) {
            $sets[] = self::ident($col) . ' = :' . $col;
        }
        $sql = 'UPDATE ' . static::$table . ' SET ' . implode(', ', $sets) . ' WHERE ' . static::$pk . ' = :pk_id';
        $params = self::bindKeys($data);
        $params[':pk_id'] = $id;
        return self::db()->prepare($sql)->execute($params);
    }

    public static function delete(mixed $id): bool {
        return self::db()->prepare('DELETE FROM ' . static::$table . ' WHERE ' . static::$pk . ' = :id')->execute([':id' => $id]);
    }

    /** $where is written by the caller with placeholders only — never user text. */
    public static function count(string $where = '', array $params = []): int {
        $sql = 'SELECT COUNT(*) FROM ' . static::$table;
        if ($where) $sql .= ' WHERE ' . $where;
        return (int)self::scalar($sql, $params);
    }

    public static function query(string $sql, array $params = []): array {
        $stmt = self::db()->prepare($sql);
        self::bindAll($stmt, $params);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public static function one(string $sql, array $params = []): ?array {
        $stmt = self::db()->prepare($sql);
        self::bindAll($stmt, $params);
        $stmt->execute();
        $row = $stmt->fetch();
        return $row ?: null;
    }

    public static function scalar(string $sql, array $params = []) {
        $stmt = self::db()->prepare($sql);
        self::bindAll($stmt, $params);
        $stmt->execute();
        $value = $stmt->fetchColumn();
        return $value === false ? null : $value;
    }

    public static function column(string $sql, array $params = []): array {
        $stmt = self::db()->prepare($sql);
        self::bindAll($stmt, $params);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_COLUMN);
    }

    /** Run a write statement; returns affected rows. */
    public static function run(string $sql, array $params = []): int {
        $stmt = self::db()->prepare($sql);
        self::bindAll($stmt, $params);
        $stmt->execute();
        return $stmt->rowCount();
    }

    public static function lastId(): int {
        return (int)self::db()->lastInsertId();
    }

    /** Run $fn inside a transaction; nested calls join the outer one. */
    public static function transaction(callable $fn) {
        $db = self::db();
        if ($db->inTransaction()) {
            return $fn($db);
        }
        $db->beginTransaction();
        try {
            $result = $fn($db);
            $db->commit();
            return $result;
        } catch (Throwable $error) {
            if ($db->inTransaction()) {
                $db->rollBack();
            }
            throw $error;
        }
    }

    /** Ints bind as PARAM_INT so LIMIT/OFFSET placeholders work with native prepares. */
    private static function bindAll(PDOStatement $stmt, array $params): void {
        foreach ($params as $key => $value) {
            $name = is_int($key) ? $key + 1 : (str_starts_with($key, ':') ? $key : ':' . $key);
            if (is_int($value)) {
                $stmt->bindValue($name, $value, PDO::PARAM_INT);
            } elseif (is_bool($value)) {
                $stmt->bindValue($name, $value ? 1 : 0, PDO::PARAM_INT);
            } elseif ($value === null) {
                $stmt->bindValue($name, null, PDO::PARAM_NULL);
            } else {
                $stmt->bindValue($name, (string)$value, PDO::PARAM_STR);
            }
        }
    }
}
