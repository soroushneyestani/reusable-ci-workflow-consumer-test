[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidatePattern('\A(?:v0\.1\.0|[0-9A-Fa-f]{40})\z')]
    [string]$Ref
)

$ErrorActionPreference = 'Stop'
$encoding = [System.Text.UTF8Encoding]::new($false, $true)
$revision = $Ref.ToLowerInvariant()
$expectedCalls = @{ go = 2; java = 1 }
$updates = foreach ($language in $expectedCalls.Keys) {
    $path = Join-Path $PSScriptRoot ".github/workflows/$language-consumer.yml"
    $source = [System.IO.File]::ReadAllText($path, $encoding)
    $target = [regex]::Escape("soroushneyestani/reusable-ci-workflow-toolkit/.github/workflows/reusable-$language.yml")
    $pattern = [regex]::new("(?m)^([ \t]+uses: $target@)(?:v0\.1\.0|[0-9a-f]{40})(\r?)$")
    if ($pattern.Matches($source).Count -ne $expectedCalls[$language]) {
        throw "Expected $($expectedCalls[$language]) calls to the public $language workflow."
    }

    @{
        Path = $path
        Text = $pattern.Replace($source, ('${1}' + $revision + '${2}'))
    }
}

foreach ($update in $updates) {
    [System.IO.File]::WriteAllText($update.Path, $update.Text, $encoding)
}
