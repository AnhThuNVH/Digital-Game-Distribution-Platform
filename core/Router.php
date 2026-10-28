<?php
// =============================================================================
// ROUTER - Simple URL router
// =============================================================================

class Router {
    protected $routes = [];
    protected $params = [];

    public function get(string $pattern, $handler) {
        $this->addRoute('GET', $pattern, $handler);
    }

    public function post(string $pattern, $handler) {
        $this->addRoute('POST', $pattern, $handler);
    }

    public function put(string $pattern, $handler) {
        $this->addRoute('PUT', $pattern, $handler);
    }

    public function delete(string $pattern, $handler) {
        $this->addRoute('DELETE', $pattern, $handler);
    }

    protected function addRoute(string $method, string $pattern, $handler) {
        $this->routes[] = [
            'method' => $method,
            'pattern' => $pattern,
            'handler' => $handler,
            'regex' => $this->patternToRegex($pattern),
        ];
    }

    protected function patternToRegex(string $pattern): string {
        $parts = preg_split('/\{([A-Za-z_][A-Za-z0-9_]*)\}/', $pattern, -1, PREG_SPLIT_DELIM_CAPTURE);
        $regex = '#^';
        foreach ($parts as $index => $part) {
            $regex .= $index % 2 === 1
                ? '(?<' . $part . '>[^/]+)'
                : preg_quote($part, '#');
        }
        return $regex . '$#';
    }

    public function dispatch(string $uri, string $method) {
        $uri = parse_url($uri, PHP_URL_PATH) ?: '/';
        $basePath = rtrim(APP_BASE_URL, '/');
        if ($basePath !== '' && ($uri === $basePath || strpos($uri, $basePath . '/') === 0)) {
            $uri = substr($uri, strlen($basePath)) ?: '/';
        }
        if ($uri !== '/' && substr($uri, -1) === '/') {
            $uri = rtrim($uri, '/');
        }

        foreach ($this->routes as $route) {
            if ($route['method'] !== strtoupper($method)) continue;
            if (preg_match($route['regex'], $uri, $matches)) {
                $params = [];
                foreach ($matches as $key => $val) {
                    if (!is_numeric($key)) {
                        $params[$key] = $val;
                    }
                }
                $this->params = $params;
                return [$route['handler'], $params];
            }
        }

        return null;
    }

    public function param(string $key, $default = null) {
        return $this->params[$key] ?? $default;
    }
}
