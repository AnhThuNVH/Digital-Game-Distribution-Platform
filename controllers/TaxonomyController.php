<?php
// =============================================================================
// TAXONOMY CONTROLLER - /admin/taxonomy. Tables: the_loai, nhan, nen_tang.
// Genres, tags and platforms used by the store filters and the project editor.
// =============================================================================

class TaxonomyController extends Controller {
    public function index(array $params = []) {
        $this->requireRole('admin');
        $key = (string)($_GET['kind'] ?? 'genre');
        $k = TaxonomyModel::kind($key) ?? TaxonomyModel::kind($key = 'genre');
        $editId = (int)($_GET['edit'] ?? 0);
        $editing = null;
        if ($editId) {
            $editing = TaxonomyModel::findIn($k, $editId);
            if (!$editing) {
                $this->notFound('Không tìm thấy mục phân loại.');
            }
        }
        $this->render('admin/taxonomy', [
            'pageTitle' => 'Danh mục: ' . $k['label'],
            'kindKey' => $key,
            'kind' => $k,
            'items' => TaxonomyModel::listKind($k),
            'counts' => TaxonomyModel::counts(),
            'editing' => $editing,
        ]);
    }

    public function store(array $params = []) {
        $this->requireRole('admin');
        [$key, $k] = $this->kindFrom($params);
        [$row, $errors] = TaxonomyModel::fromForm($k, $_POST);
        if ($errors) {
            $this->fail(implode(' ', $errors), '/admin/taxonomy?kind=' . $key . '#form');
        }
        $id = TaxonomyModel::insertIn($k, $row);
        audit('taxonomy.create', $k['table'], $id, $row);
        flash('success', 'Đã thêm ' . $k['one'] . ' "' . $row[$k['name']] . '".');
        $this->redirect('/admin/taxonomy?kind=' . $key);
    }

    public function update(array $params = []) {
        $this->requireRole('admin');
        [$key, $k] = $this->kindFrom($params);
        $item = $this->item($k, $params);
        $id = (int)$item['ma'];
        [$row, $errors] = TaxonomyModel::fromForm($k, $_POST, $id);
        if ($errors) {
            $this->fail(implode(' ', $errors), '/admin/taxonomy?kind=' . $key . '&edit=' . $id . '#form');
        }
        TaxonomyModel::updateIn($k, $id, $row);
        $before = array_intersect_key($item, $row);
        audit('taxonomy.update', $k['table'], $id, ['before' => $before, 'after' => $row]);
        flash('success', 'Đã lưu ' . $k['one'] . ' "' . $row[$k['name']] . '".');
        $this->redirect('/admin/taxonomy?kind=' . $key);
    }

    public function delete(array $params = []) {
        $this->requireRole('admin');
        [$key, $k] = $this->kindFrom($params);
        $item = $this->item($k, $params);
        $id = (int)$item['ma'];
        if (!TaxonomyModel::deleteIn($k, $id)) {
            flash('error', 'Không xóa được "' . $item[$k['name']] . '" vì đang gắn với ' . fmt_int(TaxonomyModel::gameCount($k, $id)) . ' trò chơi.');
            $this->redirect('/admin/taxonomy?kind=' . $key);
        }
        audit('taxonomy.delete', $k['table'], $id, ['name' => $item[$k['name']], 'key' => $item[$k['slug']]]);
        flash('success', 'Đã xóa ' . $k['one'] . ' "' . $item[$k['name']] . '".');
        $this->redirect('/admin/taxonomy?kind=' . $key);
    }

    private function kindFrom(array $params): array {
        $key = (string)($params['kind'] ?? '');
        $k = TaxonomyModel::kind($key);
        if (!$k) {
            $this->notFound('Không có loại danh mục này.');
        }
        return [$key, $k];
    }

    private function item(array $k, array $params): array {
        $item = TaxonomyModel::findIn($k, (int)($params['id'] ?? 0));
        if (!$item) {
            $this->notFound('Không tìm thấy mục phân loại.');
        }
        return $item;
    }
}
