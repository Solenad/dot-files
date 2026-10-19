# OpenSpec Init with Stabilize Workflow
# Usage: openspec-init [project-path]
# Load with: . $PROFILE

function openspec-init {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, Position=0)]
        [string]$ProjectPath = "."
    )

    $FullPath = Resolve-Path $ProjectPath -ErrorAction Stop
    $OriginalLocation = Get-Location

    try {
        Set-Location $FullPath

        # Initialize OpenSpec
        openspec init

        if ($LASTEXITCODE -ne 0) {
            throw "openspec init failed"
        }

        # Update config.yaml to use stabilize-workflow schema
        $ConfigPath = Join-Path $FullPath "openspec\config.yaml"
        if (Test-Path $ConfigPath) {
            $content = Get-Content $ConfigPath -Raw
            if ($content -match "^schema:") {
                $content = $content -replace "^schema:.*", "schema: stabilize-workflow"
            } else {
                $content = "schema: stabilize-workflow`n$content"
            }
            Set-Content $ConfigPath $content -NoNewline
        }

        # Copy opsx-stabilize skill
        $GlobalSkill = Join-Path $env:LOCALAPPDATA "openspec\skill-templates\opsx-stabilize"
        $ProjectSkill = Join-Path $FullPath ".opencode\skills\openspec-opsx-stabilize"

        if (Test-Path $GlobalSkill) {
            if (!(Test-Path (Join-Path $FullPath ".opencode\skills"))) {
                New-Item -ItemType Directory -Path (Join-Path $FullPath ".opencode\skills") -Force | Out-Null
            }
            Copy-Item $GlobalSkill $ProjectSkill -Recurse -Force
        }

        # Copy opsx-stabilize command
        $GlobalCommand = Join-Path $env:LOCALAPPDATA "openspec\command-templates\opsx-stabilize.md"
        $ProjectCommandDir = Join-Path $FullPath ".opencode\command"

        if (Test-Path $GlobalCommand) {
            if (!(Test-Path $ProjectCommandDir)) {
                New-Item -ItemType Directory -Path $ProjectCommandDir -Force | Out-Null
            }
            Copy-Item $GlobalCommand (Join-Path $ProjectCommandDir "opsx-stabilize.md") -Force
        }

    } catch {
        Write-Error "Failed: $_"
        return $false
    } finally {
        Set-Location $OriginalLocation
    }

    return $true
}

# Function is automatically available in global scope when script is dot-sourced
