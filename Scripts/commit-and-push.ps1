param(
  [string]$CommitMessage = "chore: automated commit",
  [string]$NewBranch
)

$ErrorActionPreference = "Stop"

function Invoke-Git {
  param([Parameter(Mandatory)][string[]]$Args)
  if (-not $Args -or $Args.Count -eq 0) { throw "Invoke-Git called with no args." }
  $cmd = "git " + ($Args -join ' ')
  Write-Host ">>> $cmd"
  $out = & git @Args 2>&1
  $code = $LASTEXITCODE
  if ($out) { Write-Host ($out -join "`n") }
  if ($code -ne 0) { throw "$cmd failed (exit $code)" }
}

Write-Host "BUILD_SOURCEBRANCH       = '$env:BUILD_SOURCEBRANCH'"
Write-Host "BUILD_SOURCEBRANCHNAME   = '$env:BUILD_SOURCEBRANCHNAME'"
Write-Host "SYSTEM_PULLREQUEST_TARGETBRANCH = '$env:SYSTEM_PULLREQUEST_TARGETBRANCH'"
Write-Host "BUILD_REPOSITORY_URI     = '$env:BUILD_REPOSITORY_URI'"
Write-Host "BUILD_SOURCESDIRECTORY   = '$env:BUILD_SOURCESDIRECTORY'"

# Identity & repo safety
Invoke-Git @("config","--global","user.name", "$env:BUILD_REQUESTEDFOR")
Invoke-Git @("config","--global","user.email","$env:BUILD_REQUESTEDFOREMAIL")
Invoke-Git @("config","--global","--add","safe.directory","$env:BUILD_SOURCESDIRECTORY")

# Resolve branch to use
$branch = $null
if ($PSBoundParameters.ContainsKey('NewBranch') -and $NewBranch) {
  # Sanitize the provided branch name (no spaces/illegal chars)
  $branch = $NewBranch.Trim()
  $branch = $branch -replace "\s+","-"
  $branch = $branch -replace "[^A-Za-z0-9._/-]","-"
  $branch = $branch.Trim("-")
  if (-not $branch) { throw "NewBranch argument is empty after sanitization." }
  Write-Host "Will create/use branch from argument: '$branch'"
  # Create/overwrite local branch from current HEAD (pipeline starts in detached HEAD)
  Invoke-Git @("checkout","-B",$branch)
} else {
  # Fallback: use the build’s branch
  if ($env:BUILD_SOURCEBRANCH -like "refs/heads/*") {
    $branch = $env:BUILD_SOURCEBRANCH -replace "^refs/heads/",""
  } elseif ($env:SYSTEM_PULLREQUEST_TARGETBRANCH) {
    $branch = $env:SYSTEM_PULLREQUEST_TARGETBRANCH -replace "^refs/heads/",""
  } else {
    $branch = $env:BUILD_SOURCEBRANCHNAME
    if ($branch -eq "merge") { $branch = $null }
  }
  if (-not $branch) { throw "Could not determine target branch (and -NewBranch not provided)." }

  Write-Host "Using existing branch: '$branch'"
  # Try to base local branch on remote if it exists
  & git fetch origin "+refs/heads/$branch:refs/remotes/origin/$branch" 2>$null
  & git rev-parse --verify "refs/remotes/origin/$branch" *> $null
  if ($LASTEXITCODE -eq 0) {
    Invoke-Git @("checkout","-B",$branch,"origin/$branch")
  } else {
    Invoke-Git @("checkout","-B",$branch)
  }
}

# Show a quick status
Invoke-Git @("status","-sb")

# Stage & commit (only if changes)
& git add -A
& git diff --cached --quiet
$hasChanges = ($LASTEXITCODE -ne 0)
if (-not $hasChanges) {
  Write-Host "Nothing to commit."
  exit 0
}

Invoke-Git @("commit","-m",$CommitMessage)

# Push current HEAD to the branch name (set upstream)
Invoke-Git @("push","-u","origin","HEAD:$branch")

Write-Host "✅ Pushed commit to origin/$branch"
