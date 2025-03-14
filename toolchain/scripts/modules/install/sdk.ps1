Import-Module "$($Config.project.neocorePath)\toolchain\scripts\modules\install\component.ps1"
Import-Module "$($Config.project.neocorePath)\toolchain\scripts\modules\build\neocore-lib.ps1"

function Install-GCC {
  Param(
    [Parameter(Mandatory=$true)][String] $URL,
    [Parameter(Mandatory=$true)][String] $Destination
  )

  $downloadPath = $(Resolve-Path $buildConfig.pathSpool)
  if (-not $(Test-Path -Path $Destination)) {
    New-Item -Path $Destination -ItemType Directory -Force
    Install-Component -URL $URL -PathDownload $downloadPath -PathInstall $Destination
  }
}

function Install-SDK {
  $installPath = $(Resolve-Path $buildConfig.pathNeocore)
  $downloadPath = $(Resolve-Path $buildConfig.pathSpool)
  $buildConfig
  Install-Component -URL "$($buildConfig.baseURL)/neocore-bin.zip" -PathDownload $downloadPath -PathInstall $installPath
  Install-Component -URL "$($buildConfig.baseURL)/msys2-runtime.zip" -PathDownload $downloadPath -PathInstall "$installPath\bin"
  Install-Component -URL "$($buildConfig.baseURL)/find-command.zip" -PathDownload $downloadPath -PathInstall "$installPath\bin"
  Install-Component -URL "$($buildConfig.baseURL)/tr-command.zip" -PathDownload $downloadPath -PathInstall "$installPath\bin"
  Install-Component -URL "$($buildConfig.baseURL)/DATimage.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\tools"
  Install-Component -URL "$($buildConfig.baseURL)/NGFX_SoundBuilder_210808.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\tools"
  Install-Component -URL "$($buildConfig.baseURL)/animator.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\tools"
  Install-Component -URL "$($buildConfig.baseURL)/framer.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\tools"
  Install-Component -URL "$($buildConfig.baseURL)/NeoTools.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\bin"
  Install-Component -URL "$($buildConfig.baseURL)/buildchar.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\bin"
  Install-Component -URL "$($buildConfig.baseURL)/charSplit.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\bin"
  Install-Component -URL "$($buildConfig.baseURL)/chdman.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\bin"
  Install-Component -URL "$($buildConfig.baseURL)/neodev-sdk.zip" -PathDownload $downloadPath -PathInstall $installPath
  Install-Component -URL "$($buildConfig.baseURL)/neodev-lib.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\lib"
  Install-Component -URL "$($buildConfig.baseURL)/libDATlib.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\lib"
  Install-Component -URL "$($buildConfig.baseURL)/neodev-header.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\include"
  Install-Component -URL "$($buildConfig.baseURL)/DATlib-header.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\include"
  Install-Component -URL "$($buildConfig.baseURL)/system.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\system"

  Install-GCC -URL "$($buildConfig.baseURL)/gcc-2.95.2.zip" -Destination "$($installPath)\gcc\gcc-2.95.2"
  #Install-Component -URL "$($buildConfig.baseURL)/MinGW-m68k-elf-13.1.0.zip" -PathDownload $downloadPath -PathInstall "$($installPath)\gcc"

  Build-NeocoreLib
  $manifestFile = "$($Config.project.neocorePath)\manifest.xml"
  Copy-Item -Path $manifestFile $installPath -Force -ErrorAction Stop
  Copy-Item -Path "$($Config.project.neocorePath)\manifest.xml" $buildConfig.pathNeocore -Force -ErrorAction Stop
}
