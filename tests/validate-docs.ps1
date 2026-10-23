$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
foreach ($name in @('agents', 'docs/product-design')) {
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
Write-Output 'Documentation validation passed.'
