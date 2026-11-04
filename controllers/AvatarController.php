<?php
// =============================================================================
// AVATAR CONTROLLER - default account avatar: initials on a neutral disc
// =============================================================================

class AvatarController extends Controller {
    public function show(array $params) {
        $userId = (int)($params['id'] ?? 0);
        $user = $userId > 0 ? UserModel::find($userId) : null;
        if (!$user) {
            http_response_code(404);
            exit;
        }
        $words = preg_split('/\s+/u', trim((string)$user['ten_hien_thi']), -1, PREG_SPLIT_NO_EMPTY) ?: [];
        $initials = '';
        foreach (array_slice($words, 0, 2) as $word) {
            $initials .= mb_strtoupper(mb_substr($word, 0, 1));
        }
        $initials = $initials !== '' ? $initials : '?';
        // Greys only: the accent hue is reserved for data.
        $tones = ['#2a2a2a', '#333333', '#3d3d3d', '#262626'];
        $fill = $tones[hexdec(substr(hash('sha256', (string)$user['ma']), 0, 2)) % count($tones)];
        header('Content-Type: image/svg+xml; charset=utf-8');
        header('Cache-Control: public, max-age=86400');
        echo '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256" role="img">'
            . '<rect width="256" height="256" rx="128" fill="' . $fill . '"/>'
            . '<text x="50%" y="53%" dominant-baseline="middle" text-anchor="middle" fill="#ffffff" '
            . 'font-family="Inter,Segoe UI,Arial,sans-serif" font-size="96" font-weight="500">'
            . htmlspecialchars($initials, ENT_QUOTES | ENT_XML1, 'UTF-8') . '</text></svg>';
        exit;
    }
}
