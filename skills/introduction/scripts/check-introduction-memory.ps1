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
    @{ Key = "Background & Problem"; Pattern = "##\s+Background\s+&\s+Problem" },
    @{ Key = "Existing Methods & Limitations"; Pattern = "##\s+Existing\s+Methods\s+&\s+Limitations" },
    @{ Key = "Our Core Idea"; Pattern = "##\s+Our\s+Core\s+Idea" },
    @{ Key = "Technical Challenges"; Pattern = "##\s+Technical\s+Challenges" },
    @{ Key = "Our Method"; Pattern = "##\s+Our\s+Method" },
    @{ Key = "Summary Contributions"; Pattern = "##\s+Summary\s+Contributions" },
    @{ Key = "Transition Sentences"; Pattern = "##\s+Transition\s+Sentences" },
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
$isReady = ($missing.Count -eq 0 -and $needsVerification -eq 0 -and $todoCount -eq 0)

if ($missing.Count -eq 0) {
    Write-Output "STRUCTURE_OK"
} else {
    Write-Output "MISSING_SECTIONS:"
    foreach ($item in $missing) {
        Write-Output "- $item"
    }
}

Write-Output "NEEDS_VERIFICATION_COUNT: $needsVerification"
Write-Output "TODO_COUNT: $todoCount"
Write-Output "READY_TO_DRAFT: $isReady"

if (-not $isReady) {
    Write-Output "NEXT_ACTION: Ask one focused question about the highest-priority missing logic before drafting."
}
