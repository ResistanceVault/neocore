# Neocore
# David Vandensteen
# MIT

param (
  [Parameter(Mandatory=$true)][String] $ConfigFile,
  [String] $Rule = "default"
)

function Main {
  param (
    [Parameter(Mandatory=$true)][String] $Rule,
    [Parameter(Mandatory=$true)][String] $BaseURL,
    [Parameter(Mandatory=$true)][xml] $Config
  )

  Import-Module "$($Config.project.neocorePath)\toolchain\scripts\modules\import\neocore\modules.ps1"

  Assert-Project -Config $Config

  Write-Host ""
  Write-Host "Name : $($Config.project.name)"
  Write-Host "Version : $($Config.project.version)"
  Write-Host "Makefile : $($Config.project.makefile)"
  Write-Host "Rule : $($Rule)"
  Write-Host "--------------------------------------------"
  Write-Host ""

  [xml]$Manifest = (Get-Content -Path "$($Config.project.neocorePath)\manifest.xml")

  if (Test-Path -Path "$($Config.project.buildPath)\manifest.xml") {
    Assert-Manifest `
      -ManifestSource "$($Config.project.neocorePath)\manifest.xml" `
      -ManifestCache "$($Config.project.buildPath)\manifest.xml"
  }

  Assert-Rule -Rule $Rule
  Stop-Emulators

  if ($Rule -eq "clean:build") { MakCleanBuild}

  if ((Test-Path -Path "$($Config.project.buildPath)\spool") -eq $false) {
    New-Item -Path "$($Config.project.buildPath)\spool" -ItemType Directory -Force
  }

  Start-Transcript -Path "$($Config.project.buildPath)\mak.log" -Force

  $gccPath = "..\..\build\gcc\gcc-2.95.2"
  Write-Host $gccPath

  if ($Config.project.compiler.path) { $gccPath = $Config.project.compiler.path }

  Set-EnvPath -GCCPath $gccPath -Bin "$($Config.project.buildPath)\bin"
  $env:NEODEV = "$($Config.project.buildPath)\neodev-sdk"

  if ((Test-Path -Path "$($Config.project.buildPath)\neodev-sdk\m68k\bin") -eq $false) { Install-SDK }
  if ((Test-Path -Path "$($Config.project.buildPath)\bin") -eq $false) { Install-SDK }
  if ((Test-Path -Path "$($Config.project.buildPath)\neodev-sdk") -eq $false) { Install-SDK }

  if ($Rule -notmatch "^only:") { MakClean }

  if ((Test-Path -Path "$($Config.project.buildPath)\$($Config.project.name)") -eq $false) {
    New-Item -Path "$($Config.project.buildPath)\$($Config.project.name)" -ItemType Directory -Force
  }

  if ($Rule -eq "clean") { exit 0 }

  if ($Rule -eq "animator") { Start-Animator }
  if ($Rule -eq "framer") { Start-Framer }
  if ($Rule -eq "lib") { Build-NeocoreLib }
  if ($Rule -eq "sprite") { Build-Sprite }

  if (($Rule -eq "make") -or ($Rule -eq "") -or (!$Rule) -or ($Rule -eq "default") ) {
    MakDefault
  }
  if ($Rule -eq "iso") {
    MakISO
  }
  if ($Rule -eq "run:raine" -or $Rule -eq "raine" -or $Rule -like "run:raine:*") {
    MakRunRaine
  }
  if ($Rule -like "run:mame*" -or $Rule -eq "mame" -or $Rule -eq "run") {
    MakRunMame
  }
  if ($Rule -eq "serve:raine") {
    MakServeRaine
  }
  if ($Rule -eq "serve:mame" -or $Rule -eq "serve") {
    MakServeMame
  }

  if ($Rule -eq "dist:iso" -or $Rule -eq "dist:raine") {
    MakDistISO
  }

  if ($Rule -eq "dist:mame" -or $Rule -eq "dist:chd") {
    MakDistMame
  }

  if ($Rule -eq "dist:exe") {
    MakDistExe
  }

  if ($Rule -eq "--version") {
    Show-Version
  }

  if ($Rule -eq "only:sprite") { Build-Sprite }
  if ($Rule -eq "only:program") { Build-Program }
  if ($Rule -eq "only:iso") { Build-ISO }
  if ($Rule -eq "only:mame") { Build-Mame }
  if ($Rule -eq "only:run") { Start-Mame }
  if ($Rule -eq "only:run:mame") { Start-Mame }
  if ($Rule -eq "only:run:raine") { Start-Mame }
}

if ((Test-Path -Path $ConfigFile) -eq $false) {
  Write-Host "Config $ConfigFile not found" -ForegroundColor Red
  exit 1
}

Write-Host "informations" -ForegroundColor Blue
Write-Host "Config file : $ConfigFile"

[xml]$config = (Get-Content -Path $ConfigFile)

Main -Config $config -BaseURL "http://azertyvortex.free.fr/download" -Rule $Rule
