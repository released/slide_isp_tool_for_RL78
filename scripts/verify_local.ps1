param([string]$PreviewBase = '', [string]$ToolRoot = '')
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$webRoot = Split-Path -Parent $projectRoot
$sources = @((Join-Path $projectRoot 'index.md'),
    (Join-Path $projectRoot 'SCREENSHOT_CHECKLIST.md'),
    (Join-Path $projectRoot 'index.html'),
    (Join-Path $webRoot 'slide_boot_loader_for_RL78\index.md'),
    (Join-Path $webRoot 'released.github.io\README.md'))
$checked = 0
foreach ($source in $sources) {
    $text = Get-Content -LiteralPath $source -Raw -Encoding UTF8
    if ($source.EndsWith('.md') -and ([regex]::Matches($text, '(?m)^```').Count % 2) -ne 0) {
        throw "Unbalanced fences: $source"
    }
    $refs = @([regex]::Matches($text, '\]\(([^)]+)\)') | ForEach-Object { $_.Groups[1].Value.Split(' ')[0] })
    $refs += @([regex]::Matches($text, '(?:src|href)="([^"]+)"') | ForEach-Object { $_.Groups[1].Value })
    foreach ($reference in $refs) {
        if ($reference -match '^(https?:|mailto:|#)') { continue }
        $relative = $reference.Split('#')[0]
        if ($relative.StartsWith('/')) {
            $resolved = Join-Path $webRoot $relative.TrimStart('/')
        } else { $resolved = Join-Path (Split-Path -Parent $source) $relative }
        if (-not (Test-Path -LiteralPath $resolved)) { throw "Missing local reference $reference in $source" }
        $checked++
    }
}
Write-Host "PASS: $checked local image/page/resource references; Markdown fences balanced."
$navigation = Get-Content -LiteralPath (Join-Path $webRoot 'released.github.io\README.md') -Raw -Encoding UTF8
$ispEntry = [regex]::Match($navigation, '(?m)^\| \[RL78 ISP Tool\]\(https://released\.github\.io/slide_isp_tool_for_RL78/[^\r\n]*')
if (-not $ispEntry.Success) { throw 'Missing linked RL78 ISP Tool navigation entry.' }
if ($ispEntry.Value -match '(\d+\.\d+\.\d+|Tool\d{4}|\u5de5\u7a0b\u7b2c\u4e00\u7248|19244|10963|301\u5340\u584a)') {
    throw 'Navigation must describe functions, not pin a release or benchmark.'
}
foreach ($page in @('slide_isp_tool_for_RL78\index.md', 'slide_boot_loader_for_RL78\index.md',
        'slide_isp_tool_for_RL78\README.md', 'slide_boot_loader_for_RL78\README.md',
        'released.github.io\README.md')) {
    $pageText = Get-Content -LiteralPath (Join-Path $webRoot $page) -Raw -Encoding UTF8
    # ASCII escapes keep Windows PowerShell 5 source decoding unambiguous.
    $draftPattern = '(\u5c1a\u672a\u767c\u5e03|\u672a\u767c\u5e03|\u5c1a\u672a\u516c\u958b\u767c\u5e03|\u672c\u6a5f\u7a3f|\u672c\u6a5f\u7de8\u8f2f\u7a3f|\u672c\u6a5f\u88fd\u4f5c\u7a3f|\u5de5\u7a0b\u7b2c\u4e00\u7248)'
    if ($pageText -match $draftPattern) {
        throw "Draft/release milestone wording in public guide: $page"
    }
}
Write-Host 'PASS: linked evergreen navigation and no draft/release milestone labels.'
if ($ToolRoot) {
    $identity = Get-Content -LiteralPath (Join-Path $ToolRoot 'src\build_info.generated.h') -Raw -Encoding UTF8
    $guide = Get-Content -LiteralPath (Join-Path $projectRoot 'index.md') -Raw -Encoding UTF8
    if ($identity -notmatch 'FIRMWARE_UPGRADE_TOOL_VERSION' -or $guide -notmatch 'FirmwareUpgradeTool') {
        throw 'Tool/web product identity missing.'
    }
    Write-Host 'PASS: Tool/web product identity; public guide intentionally has no build-version pin.'
}
if ($PreviewBase) {
    $routes = @('/slide_isp_tool_for_RL78/', '/slide_isp_tool_for_RL78/index.md',
        '/slide_isp_tool_for_RL78/img/benchmark_pcan.jpg',
        '/slide_isp_tool_for_RL78/img/benchmark_mcu_log.jpg',
        '/slide_boot_loader_for_RL78/', '/notices_can/assets/style.css', '/notices_can/assets/app.js')
    foreach ($route in $routes) {
        $response = Invoke-WebRequest -UseBasicParsing ($PreviewBase.TrimEnd('/') + $route)
        if ($response.StatusCode -ne 200) { throw "HTTP failure: $route" }
    }
    Write-Host "PASS: $($routes.Count) local preview HTTP routes. Browser/DPI checks are separate, NOT RUN."
}
