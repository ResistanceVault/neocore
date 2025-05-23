function Watch-Folder {
  param (
   [Parameter(Mandatory=$true)][String] $Path
  )
  if ((Test-Path -Path $Path) -eq $false) { Write-Host "error - $Path not found" -ForegroundColor Red; exit 1 }
  Write-Host "Waiting for changes in $Path" -ForegroundColor Yellow

  $sizeLast = (Get-ChildItem -Path $Path | Measure-Object -Sum Length | Select-Object Count, Sum).Sum
  $sizeCurrent = $sizeLast
  Write-Host $sizeCurrent
  While ($sizeLast -like $sizeCurrent) {
    Start-Sleep -Seconds 5
    $sizeCurrent = (Get-ChildItem -Path $Path | Measure-Object -Sum Length | Select-Object Count, Sum).Sum
  }
}