param(
    [Parameter(Mandatory=$true)]
    [string]$Path,

    [string]$RelatedWorkPath = "related-work.md"
)

if (-not (Test-Path -LiteralPath $Path)) {
    Write-Output "MISSING_FILE: $Path"
    exit 1
}

$text = Get-Content -LiteralPath $Path -Raw
$checks = @(
    @{ Key = "Paper Context"; Pattern = "##\s+Paper\s+Context" },
    @{ Key = "Related-Work Prerequisite"; Pattern = "##\s+Related-Work\s+Prerequisite" },
    @{ Key = "Experimental Settings"; Pattern = "##\s+Experimental\s+Settings" },
    @{ Key = "Datasets"; Pattern = "###\s+Datasets" },
    @{ Key = "Baselines"; Pattern = "###\s+Baselines" },
    @{ Key = "Evaluation Metrics"; Pattern = "###\s+Evaluation\s+Metrics" },
    @{ Key = "Implementation Details"; Pattern = "###\s+Implementation\s+Details" },
    @{ Key = "Coverage Check Against Related Work"; Pattern = "##\s+Coverage\s+Check\s+Against\s+Related\s+Work" },
    @{ Key = "Dataset Coverage"; Pattern = "###\s+Dataset\s+Coverage" },
    @{ Key = "Baseline Coverage"; Pattern = "###\s+Baseline\s+Coverage" },
    @{ Key = "Metric Coverage"; Pattern = "###\s+Metric\s+Coverage" },
    @{ Key = "Main Results"; Pattern = "##\s+Main\s+Results" },
    @{ Key = "Result Table Or Link"; Pattern = "###\s+Result\s+Table\s+Or\s+Link" },
    @{ Key = "Per-Dataset Results"; Pattern = "###\s+Per-Dataset\s+Results" },
    @{ Key = "Average Improvement"; Pattern = "###\s+Average\s+Improvement" },
    @{ Key = "Comparison With Existing Improvement Scale"; Pattern = "###\s+Comparison\s+With\s+Existing\s+Improvement\s+Scale" },
    @{ Key = "Ablation / Evaluation Study"; Pattern = "##\s+Ablation\s*/\s*Evaluation\s+Study" },
    @{ Key = "Case Study"; Pattern = "##\s+Case\s+Study" },
    @{ Key = "Field Experiment"; Pattern = "##\s+Field\s+Experiment" },
    @{ Key = "Logic Checks"; Pattern = "##\s+Logic\s+Checks" },
    @{ Key = "Confirmed Logic"; Pattern = "##\s+Confirmed\s+Logic" },
    @{ Key = "Open Questions"; Pattern = "##\s+Open\s+Questions" }
)

$missing = @()
foreach ($check in $checks) {
    if ($text -notmatch $check.Pattern) {
        $missing += $check.Key
    }
}

$root = Split-Path -Parent (Resolve-Path -LiteralPath $Path)
if ([System.IO.Path]::IsPathRooted($RelatedWorkPath)) {
    $resolvedRelatedWorkPath = $RelatedWorkPath
} else {
    $resolvedRelatedWorkPath = Join-Path $root $RelatedWorkPath
}

$hasRelatedWorkFile = Test-Path -LiteralPath $resolvedRelatedWorkPath
$relatedWorkText = ""
if ($hasRelatedWorkFile) {
    $relatedWorkText = Get-Content -LiteralPath $resolvedRelatedWorkPath -Raw
}

$hasRelatedWorkCorpus = $hasRelatedWorkFile -and
    $relatedWorkText -match "##\s+Related\s+Work\s+Corpus" -and
    ([regex]::Matches($relatedWorkText, "\[[^\]]+\]|\([A-Za-z][A-Za-z\-]+(?:\s+et\s+al\.)?,?\s+\d{4}[a-z]?\)|\b\d{4}[a-z]?\b")).Count -gt 0

$needsVerification = ([regex]::Matches($text, "Needs verification", "IgnoreCase")).Count
$todoCount = ([regex]::Matches($text, "\bTODO\b|\[ \]", "IgnoreCase")).Count
$contentOnly = (($text -split "\r?\n") | Where-Object { $_ -notmatch "^\s*#{1,6}\s+" }) -join "`n"
$hasDatasetHint = $contentOnly -match "(?i)dataset|benchmark|corpus|split|train|test|validation"
$hasBaselineHint = $contentOnly -match "(?i)baseline|compared\s+method|state-of-the-art|SOTA|prior\s+work"
$hasMetricHint = $contentOnly -match "(?i)metric|accuracy|precision|recall|F1|AUC|MAE|RMSE|BLEU|ROUGE|NDCG|higher|lower"
$hasImplementationHint = $contentOnly -match "(?i)implementation|hyperparameter|setting|prompt|model|hardware|seed|repeat|run|code"
$hasCoverageHint = $contentOnly -match "(?i)coverage|missing|excluded|closest|related\s+work|incomparable|unavailable|out\s+of\s+scope"
$hasMainResultHint = $contentOnly -match "(?i)main\s+result|result\s+table|table|link|score|performance|\|"
$hasImprovementHint = $contentOnly -match "(?i)improvement|gain|average|relative|absolute|strongest|best\s+baseline|spread|\+|-|%"
$hasAblationHint = $contentOnly -match "(?i)ablation|remove|replace|component|module|sensitivity|robustness|diagnostic|user\s+study|evaluation\s+study"

$isReady = (
    $missing.Count -eq 0 -and
    $hasRelatedWorkCorpus -and
    $needsVerification -eq 0 -and
    $todoCount -eq 0 -and
    $hasDatasetHint -and
    $hasBaselineHint -and
    $hasMetricHint -and
    $hasImplementationHint -and
    $hasCoverageHint -and
    $hasMainResultHint -and
    $hasImprovementHint -and
    $hasAblationHint
)

if ($missing.Count -eq 0) {
    Write-Output "STRUCTURE_OK"
} else {
    Write-Output "MISSING_SECTIONS:"
    foreach ($item in $missing) {
        Write-Output "- $item"
    }
}

Write-Output "HAS_RELATED_WORK_FILE: $hasRelatedWorkFile"
Write-Output "HAS_RELATED_WORK_CORPUS: $hasRelatedWorkCorpus"
Write-Output "HAS_DATASET_HINT: $hasDatasetHint"
Write-Output "HAS_BASELINE_HINT: $hasBaselineHint"
Write-Output "HAS_METRIC_HINT: $hasMetricHint"
Write-Output "HAS_IMPLEMENTATION_HINT: $hasImplementationHint"
Write-Output "HAS_COVERAGE_HINT: $hasCoverageHint"
Write-Output "HAS_MAIN_RESULT_HINT: $hasMainResultHint"
Write-Output "HAS_IMPROVEMENT_HINT: $hasImprovementHint"
Write-Output "HAS_ABLATION_HINT: $hasAblationHint"
Write-Output "NEEDS_VERIFICATION_COUNT: $needsVerification"
Write-Output "TODO_COUNT: $todoCount"
Write-Output "READY_TO_DRAFT: $isReady"

if (-not $isReady) {
    if (-not $hasRelatedWorkFile) {
        Write-Output "NEXT_ACTION: Ask the user to provide related-work.md before judging Evaluation coverage."
    } elseif (-not $hasRelatedWorkCorpus) {
        Write-Output "NEXT_ACTION: Ask the user to provide a usable related-work corpus in related-work.md."
    } elseif (-not $hasDatasetHint) {
        Write-Output "NEXT_ACTION: Ask for the datasets, including task setting and split if available."
    } elseif (-not $hasBaselineHint) {
        Write-Output "NEXT_ACTION: Ask for baselines and compare them against the closest works in related-work.md."
    } elseif (-not $hasMetricHint) {
        Write-Output "NEXT_ACTION: Ask for evaluation metrics and whether each metric is higher-is-better or lower-is-better."
    } elseif (-not $hasImplementationHint) {
        Write-Output "NEXT_ACTION: Ask for implementation details needed for fair comparison."
    } elseif (-not $hasCoverageHint) {
        Write-Output "NEXT_ACTION: Ask whether datasets, baselines, and metrics cover the related-work corpus."
    } elseif (-not $hasMainResultHint) {
        Write-Output "NEXT_ACTION: Ask for the main-results table or a link to it."
    } elseif (-not $hasImprovementHint) {
        Write-Output "NEXT_ACTION: Compute or ask for average improvement against the strongest comparable baselines."
    } elseif (-not $hasAblationHint) {
        Write-Output "NEXT_ACTION: Ask for ablation or evaluation study evidence for the core innovation."
    } else {
        Write-Output "NEXT_ACTION: Ask one focused question about the highest-priority missing Evaluation evidence."
    }
}
