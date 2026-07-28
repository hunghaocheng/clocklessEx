# Compile / simulate tb_coreprocess, then open GTKWave
# Usage (from repo root):
#   .\run_sim.ps1

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$Top     = "tb_coreprocess"
$OutDir  = "COREPROCESS"
$OutFile = Join-Path $OutDir "$Top.out"
$VcdFile = Join-Path $OutDir "tb_core.vcd"

# Sources required by the current testbench (avoid WIP modules in root filelist.f)
$Sources = @(
    "StandardCell/st_latch.v"
    "StandardCell/st_8_latch.v"
    "StandardCell/st_event_register.v"
    "COREPROCESS/tb_coreprocess.v"
)

Write-Host "==> Compiling with iverilog ..."
& iverilog -o $OutFile -s $Top @Sources
if ($LASTEXITCODE -ne 0) {
    Write-Error "iverilog failed (exit $LASTEXITCODE)"
    exit $LASTEXITCODE
}
Write-Host "    output: $OutFile"

Write-Host "==> Running simulation (vvp) ..."
Push-Location $OutDir
try {
    & vvp "$Top.out"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "vvp failed (exit $LASTEXITCODE)"
        exit $LASTEXITCODE
    }
} finally {
    Pop-Location
}

if (-not (Test-Path $VcdFile)) {
    Write-Error "VCD not found: $VcdFile (check `$dumpfile in testbench)"
    exit 1
}
Write-Host "    vcd: $VcdFile"

Write-Host "==> Opening GTKWave ..."
Start-Process gtkwave -ArgumentList (Resolve-Path $VcdFile)
Write-Host "Done."
