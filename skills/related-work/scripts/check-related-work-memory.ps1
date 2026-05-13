param(
    [Parameter(Mandatory=$true)]
    [string]$Path
)

if (-not (Test-Path -LiteralPath $Path)) {
    Write-Output "MISSING_FILE: $Path"
    exit 1
}

$text = Get-Content -LiteralPath $Path -Raw
$checks = @(
    @{ Key = "Paper Context"; Pattern = "##\s+Paper\s+Context" },
    @{ Key = "Related Work Corpus"; Pattern = "##\s+Related\s+Work\s+Corpus" },
    @{ Key = "Two-Level Taxonomy"; Pattern = "##\s+Two-Level\s+Taxonomy" },
    @{ Key = "N-Level Comparisons"; Pattern = "##\s+N-Level\s+Comparisons" },
    @{ Key = "Closely Related Work"; Pattern = "##\s+Closely\s+Related\s+Work" },
    @{ Key = "Confirmed Logic"; Pattern = "##\s+Confirmed\s+Logic" },
    @{ Key = "Open Questions"; Pattern = "##\s+Open\s+Questions" }
)

$missing = @()
foreach ($check in $checks) {
    if ($text -notmatch $check.Pattern) {
        $missing += $check.Key
    }
}

$needsVerification = ([regex]::Matches($text, "Needs verification", "IgnoreCase")).Count
$todoCount = ([regex]::Matches($text, "\bTODO\b|\[ \]", "IgnoreCase")).Count
$corpusMarkers = ([regex]::Matches($text, "\[[^\]]+\]|\([A-Za-z][A-Za-z\-]+(?:\s+et\s+al\.)?,?\s+\d{4}[a-z]?\)|\b\d{4}[a-z]?\b")).Count
$hasTaxonomyHint = $text -match "(?i)n\+m|two-level|two layer|first-layer|second-layer|taxonomy|family|families|subfamil"
$hasComparisonHint = $text -match "(?i)compared with|in contrast|unlike|better suited|lack(s)? a mechanism|limitation|difference|whereas"

$isReady = (
    $missing.Count -eq 0 -and
    $needsVerification -eq 0 -and
    $todoCount -eq 0 -and
    $corpusMarkers -gt 0 -and
    $hasTaxonomyHint -and
    $hasComparisonHint
)

if ($missing.Count -eq 0) {
    Write-Output "STRUCTURE_OK"
} else {
    Write-Output "MISSING_SECTIONS:"
    foreach ($item in $missing) {
        Write-Output "- $item"
    }
}

Write-Output "CORPUS_MARKER_COUNT: $corpusMarkers"
Write-Output "HAS_TAXONOMY_HINT: $hasTaxonomyHint"
Write-Output "HAS_COMPARISON_HINT: $hasComparisonHint"
Write-Output "NEEDS_VERIFICATION_COUNT: $needsVerification"
Write-Output "TODO_COUNT: $todoCount"
Write-Output "READY_TO_DRAFT: $isReady"

if (-not $isReady) {
    if ($corpusMarkers -eq 0) {
        Write-Output "NEXT_ACTION: related-work.md contains no detectable papers. Ask the user to write papers into related-work.md or paste them in chat so they can be added to related-work.md before drafting."
    } elseif (-not $hasTaxonomyHint) {
        Write-Output "NEXT_ACTION: Ask one focused question about the two-level n+m taxonomy."
    } elseif (-not $hasComparisonHint) {
        Write-Output "NEXT_ACTION: Ask one focused question about first-layer comparison against the user's method."
    } else {
        Write-Output "NEXT_ACTION: Ask one focused question about the highest-priority missing related-work logic before drafting."
    }
}
