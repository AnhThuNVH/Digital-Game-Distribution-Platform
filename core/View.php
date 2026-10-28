<?php
// =============================================================================
// VIEW - Simple PHP template renderer
// =============================================================================

class View {
    protected $viewDir;
    protected $layoutDir;

    public function __construct() {
        $this->viewDir = VIEWS_DIR;
        $this->layoutDir = VIEWS_DIR;
    }

    public function render(string $template, array $data = [], ?string $layout = null): string {
        extract($data, EXTR_SKIP);

        ob_start();
        $templatePath = $this->viewDir . '/' . $template . '.php';
        if (!is_file($templatePath)) {
            throw new RuntimeException('Template not found: ' . $template);
        }
        include $templatePath;
        $content = ob_get_clean();

        if ($layout === null) {
            return $content;
        }

        // Wrap in layout if provided
        $layoutPath = $this->layoutDir . '/' . $layout . '.php';
        if (!file_exists($layoutPath)) {
            throw new RuntimeException('Layout not found: ' . $layout);
        }

        // Set $content for the layout to use
        ob_start();
        $layoutContent = $content;
        include $layoutPath;
        return ob_get_clean();
    }
}
