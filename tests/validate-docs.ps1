$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
foreach ($name in @('agents', 'docs/product-design', 'docs/technical-plan')) {
    $englishName = if ($name -eq 'agents') { 'AGENTS.md' } else { "$name.md" }
    $english = Join-Path $root $englishName
    $chinese = Join-Path $root "$name.zh.md"
    foreach ($path in @($english, $chinese)) {
        if (-not (Test-Path -LiteralPath $path)) { throw "Missing document: $path" }
    }
    $en = Get-Content -LiteralPath $english -Raw -Encoding utf8
    $zh = Get-Content -LiteralPath $chinese -Raw -Encoding utf8
    if ($en -match '[\u3400-\u9FFF]') { throw "Chinese text in English document: $english" }
    if ($zh -notmatch '[\u3400-\u9FFF]') { throw "Missing Chinese text: $chinese" }
    foreach ($pattern in @('(?m)^## ', '(?m)^\|', '(?m)^- ', '(?m)^\d+\. ')) {
        if ([regex]::Matches($en, $pattern).Count -ne [regex]::Matches($zh, $pattern).Count) {
            throw "Document structure mismatch: $name ($pattern)"
        }
    }
}
$entry = Get-Content -LiteralPath (Join-Path $root 'AGENTS.md') -Raw -Encoding utf8
if ($entry -notmatch 'agents\.zh\.md') { throw 'Missing Chinese rules link' }
if (-not $entry.Contains('update all corresponding language versions in the same commit')) {
    throw 'Missing English documentation synchronization rule'
}
$chineseRules = Get-Content -LiteralPath (Join-Path $root 'agents.zh.md') -Raw -Encoding utf8
if ($chineseRules -notmatch '\u5728\u540c\u4e00\u500b commit \u4e2d\u540c\u6b65\u66f4\u65b0\u6240\u6709\u5c0d\u61c9\u8a9e\u8a00\u7248\u672c') {
    throw 'Missing Chinese documentation synchronization rule'
}
Write-Output 'Documentation validation passed.'
