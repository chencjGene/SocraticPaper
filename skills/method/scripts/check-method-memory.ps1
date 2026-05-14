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
    @{ Key = "Problem Formulation"; Pattern = "##\s+Problem\s+Formulation" },
    @{ Key = "Problem Statement"; Pattern = "###\s+Problem\s+Statement" },
    @{ Key = "Model Input"; Pattern = "###\s+Model\s+Input" },
    @{ Key = "Model Output"; Pattern = "###\s+Model\s+Output" },
    @{ Key = "Prerequisites"; Pattern = "##\s+Prerequisites" },
    @{ Key = "Preliminary Material"; Pattern = "###\s+Preliminary\s+Material" },
    @{ Key = "Reference Papers"; Pattern = "###\s+Reference\s+Papers" },
    @{ Key = "Preliminary / Background"; Pattern = "##\s+Preliminary\s*/\s*Background" },
    @{ Key = "Background Decision"; Pattern = "###\s+Background\s+Decision" },
    @{ Key = "Method Overview / Framework"; Pattern = "##\s+Method\s+Overview\s*/\s*Framework" },
    @{ Key = "Major Modules"; Pattern = "###\s+Major\s+Modules" },
    @{ Key = "Module Dependency Overview"; Pattern = "###\s+Module\s+Dependency\s+Overview" },
    @{ Key = "First-Layer Chain"; Pattern = "##\s+First-Layer\s+Chain" },
    @{ Key = "Module Plans"; Pattern = "##\s+Module\s+Plans" },
    @{ Key = "Second-Layer Chains"; Pattern = "##\s+Second-Layer\s+Chains" },
    @{ Key = "Sub-Module Descriptions"; Pattern = "##\s+Sub-Module\s+Descriptions" },
    @{ Key = "Formula-Level Specifications"; Pattern = "##\s+Formula-Level\s+Specifications" },
    @{ Key = "Mathematical Symbol Table"; Pattern = "##\s+Mathematical\s+Symbol\s+Table" },
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

$needsVerification = ([regex]::Matches($text, "Needs verification", "IgnoreCase")).Count
$todoCount = ([regex]::Matches($text, "\bTODO\b|\[ \]", "IgnoreCase")).Count
$hasChainHint = $text -match "->"
$hasProblemHint = $text -match "(?i)problem|task|input|output"
$hasInputOutputHint = $text -match "(?i)model\s+input|input\s*:|input\s*->" -and $text -match "(?i)model\s+output|output\s*:|->\s*output"
$hasOverviewHint = $text -match "(?i)overview|framework|major\s+modules|module\s+depend"
$hasModulePlanHint = $text -match "(?i)design motivation|basic idea|step\s*1|technical challenge|contribution"
$hasFirstLayerHint = $text -match "(?i)input\s*->\s*module|module\s+\d+|first-layer"
$hasSecondLayerHint = $text -match "(?i)sub-module|second-layer"
$hasFormulaHint = $text -match "\$[^$]+\$|\\\(|\\\[|\\begin\{equation\}|arg\s*min|arg\s*max|:=|="
$hasSymbolTableRows = ([regex]::Matches($text, "^\|\s*[^|\r\n]+\s*\|\s*[^|\r\n]+\s*\|\s*[^|\r\n]+\s*\|\s*[^|\r\n]+\s*\|\s*[^|\r\n]+\s*\|\s*[^|\r\n]+\s*\|", "Multiline")).Count -gt 2
$hasConflict = $text -match "(?i)\bConflict\b|symbol conflict|notation conflict|duplicate symbol"

$isReady = (
    $missing.Count -eq 0 -and
    $needsVerification -eq 0 -and
    $todoCount -eq 0 -and
    $hasProblemHint -and
    $hasInputOutputHint -and
    $hasOverviewHint -and
    $hasModulePlanHint -and
    $hasChainHint -and
    $hasFirstLayerHint -and
    $hasSecondLayerHint -and
    $hasFormulaHint -and
    $hasSymbolTableRows -and
    -not $hasConflict
)

if ($missing.Count -eq 0) {
    Write-Output "STRUCTURE_OK"
} else {
    Write-Output "MISSING_SECTIONS:"
    foreach ($item in $missing) {
        Write-Output "- $item"
    }
}

Write-Output "HAS_CHAIN_HINT: $hasChainHint"
Write-Output "HAS_PROBLEM_HINT: $hasProblemHint"
Write-Output "HAS_INPUT_OUTPUT_HINT: $hasInputOutputHint"
Write-Output "HAS_OVERVIEW_HINT: $hasOverviewHint"
Write-Output "HAS_MODULE_PLAN_HINT: $hasModulePlanHint"
Write-Output "HAS_FIRST_LAYER_HINT: $hasFirstLayerHint"
Write-Output "HAS_SECOND_LAYER_HINT: $hasSecondLayerHint"
Write-Output "HAS_FORMULA_HINT: $hasFormulaHint"
Write-Output "HAS_SYMBOL_TABLE_ROWS: $hasSymbolTableRows"
Write-Output "HAS_SYMBOL_CONFLICT_HINT: $hasConflict"
Write-Output "NEEDS_VERIFICATION_COUNT: $needsVerification"
Write-Output "TODO_COUNT: $todoCount"
Write-Output "READY_TO_DRAFT: $isReady"

if (-not $isReady) {
    if (-not $hasProblemHint -or -not $hasInputOutputHint) {
        Write-Output "NEXT_ACTION: Ask for the problem formulation, including model input and model output."
    } elseif (-not $hasOverviewHint) {
        Write-Output "NEXT_ACTION: Ask for the method overview/framework, including major modules and dependencies."
    } elseif (-not $hasModulePlanHint) {
        Write-Output "NEXT_ACTION: Ask for the highest-priority module plan: name, design motivation, basic idea, and detailed steps."
    } elseif (-not $hasFirstLayerHint) {
        Write-Output "NEXT_ACTION: Ask for the first-layer chain from input through modules and intermediate states to output."
    } elseif (-not $hasSecondLayerHint) {
        Write-Output "NEXT_ACTION: Ask for the second-layer sub-module chain of the highest-priority module."
    } elseif (-not $hasFormulaHint) {
        Write-Output "NEXT_ACTION: Ask for the exact formula-level transformation for the highest-priority sub-module."
    } elseif (-not $hasSymbolTableRows) {
        Write-Output "NEXT_ACTION: Fill or repair the mathematical symbol table before drafting."
    } elseif ($hasConflict) {
        Write-Output "NEXT_ACTION: Resolve symbol conflicts before drafting."
    } else {
        Write-Output "NEXT_ACTION: Ask one focused question about the highest-priority missing method logic before drafting."
    }
}
