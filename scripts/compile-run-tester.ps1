# todo (minor) - test errorlevel break
param (
  [string] $op
)

function compileProject($name) {
  pushd ..\projects\$name
  .\mak.bat clean
  if ($LASTEXITCODE -ne 0) { Write-Host "break"; Write-Host $env:error; break }
  .\mak.bat
  if ($LASTEXITCODE -ne 0) { break }
  popd
}

function runProject($name) {
  pushd ..\projects\$name
  .\mak.bat run
  if ($LASTEXITCODE -ne 0) { break }
  sleep 10
  popd
}

function compileProjects {
  compileProject "bullet"
  compileProject "collide"
  compileProject "collide-complex"
  compileProject "collide-multiple"
  compileProject "fixed-value"
  compileProject "hello"
  compileProject 'joypad'
  compileProject "shrunk"
  compileProject "shrunk-centroid"
  # compileProject "shrunk-physic" 1 --todo
  compileProject "sprite"
  compileProject "test_animated_sprite"
  compileProject "test_animated_sprite_physic"
  compileProject "test_image"
  compileProject "test_image_physic"
  compileProject "test_same_palette"
  compileProject "test_scroller"
}

function runProjects {
  runProject "collide"
  runProject "collide-complex"
  runProject "collide-multiple"
  runProject "fixed-value"
  runProject "hello"
  runProject 'joypad'
  runProject "shrunk"
  runProject "shrunk-centroid"
  # runProject "shrunk-physic" --todo
  runProject "sprite"
  runProject "test_animated_sprite"
  runProject "test_animated_sprite_physic"
  runProject "test_image"
  runProject "test_image_physic"
  runProject "test_same_palette"
  runProject "test_scroller"
}

function _main {
  write-host $op
  if ($op -eq "compile") { compileProjects }
  if ($op -eq "run") { runProjects }
}

_main $op