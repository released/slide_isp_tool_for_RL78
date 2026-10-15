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
    if ($pageText -match '(_Avery|(?<![A-Za-z])[A-Za-z]:[\\/]|\.\./\.\./python|SourceCode)') {
        throw "Private workspace path in public guide: $page"
    }
}
Write-Host 'PASS: linked evergreen navigation and no draft/release milestone labels.'
$ispText = [IO.File]::ReadAllText((Join-Path $projectRoot 'index.md'))
$bootText = [IO.File]::ReadAllText((Join-Path $webRoot 'slide_boot_loader_for_RL78\index.md'))
$resourcePattern = '(?s)<!-- PUBLIC_RESOURCES_BEGIN -->.*?<!-- PUBLIC_RESOURCES_END -->'
$ispBlocks = [regex]::Matches($ispText, $resourcePattern)
$bootBlocks = [regex]::Matches($bootText, $resourcePattern)
if ($ispBlocks.Count -ne 1 -or $bootBlocks.Count -ne 1 -or
    $ispBlocks[0].Value.Replace("`r`n","`n") -cne $bootBlocks[0].Value.Replace("`r`n","`n")) {
    throw 'Public download/workflow blocks are missing or differ.'
}
foreach ($anchor in @('tool-bridge-flow','f13-boot-flow','tool-operation','host-bridge-firmware','f13-device-update')) {
    if ([regex]::Matches($ispText, '<a id="' + $anchor + '"></a>').Count -ne 1 -or
        -not $ispBlocks[0].Value.Contains('https://released.github.io/slide_isp_tool_for_RL78/#' + $anchor)) {
        throw "Missing/duplicate public workflow anchor: $anchor"
    }
}
if ([regex]::Matches($bootText, '<a id="boot-app-porting"></a>').Count -ne 1) {
    throw 'Missing/duplicate public porting anchor.'
}
foreach ($download in @('simple_renesas_isp_tool/main/build/FirmwareUpgradeTool.exe',
    'simple_renesas_isp_tool/main/firmware/RL78_F24_Bridge_boot/DefaultBuild/RL78_F24_Bridge_boot.mot',
    'simple_renesas_isp_tool/main/firmware/RL78_F24_Bridge_app/DefaultBuild/RL78_F24_Bridge_app_bridge_update.bin',
    'RL78_F13_Boot_loader_CAN/main/DefaultBuild/boot0000_1FFF.hex',
    'RL78_F13_Boot_loader_CAN_app/main/boot_app.hex',
    'RL78_F13_Boot_loader_CAN_app/main/DefaultBuild/RL78_F13_Boot_loader_CAN_app_update.bin')) {
    if (-not $ispBlocks[0].Value.Contains('https://raw.githubusercontent.com/released/' + $download)) {
        throw "Missing public download: $download"
    }
}
Write-Host 'PASS: six workflow anchors, six download URLs and matching public resource blocks.'
$flashPattern = '(?s)<!-- FLASH_REFERENCE_BEGIN -->.*?<!-- FLASH_REFERENCE_END -->'
$flashBlocks = [regex]::Matches($bootText, $flashPattern)
if ($flashBlocks.Count -ne 1 -or
    [regex]::Matches($bootText, '<a id="flash-metadata-can-reference"></a>').Count -ne 1 -or
    -not $ispText.Contains('https://released.github.io/slide_boot_loader_for_RL78/#flash-metadata-can-reference') -or
    [regex]::Matches($flashBlocks[0].Value, '(?m)^\| 0x[0-9A-F]{2} \| 0x[0-9A-F]{5} \| [0-9A-F]{2} \|').Count -ne 256) {
    throw 'Missing/incomplete Flash reference anchor or 256 byte-address rows.'
}
Write-Host 'PASS: linked Flash/metadata/CAN reference and all256 byte-address rows.'
$walkPattern = '(?s)<!-- CAN_WALKTHROUGH_BEGIN -->.*?<!-- CAN_WALKTHROUGH_END -->'
$walkBlocks = [regex]::Matches($ispText, $walkPattern)
if ($walkBlocks.Count -ne 1 -or
    [regex]::Matches($ispText, '<a id="can-update-walkthrough"></a>').Count -ne 1 -or
    [regex]::Matches($walkBlocks[0].Value, '(?m)^```mermaid').Count -ne 9 -or
    [regex]::Matches($walkBlocks[0].Value, '(?m)^\|(?: --- \|){3,5}\r?$').Count -ne 15 -or
    -not $bootText.Contains('https://released.github.io/slide_isp_tool_for_RL78/#can-update-walkthrough')) {
    throw 'Missing/incomplete cross-layer CAN tutorial, tables, flows or navigation.'
}
Write-Host 'PASS: cross-layer CAN tutorial with15 tables/9 Mermaid diagrams and linked navigation.'
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
