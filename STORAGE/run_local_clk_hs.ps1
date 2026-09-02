# Compile / simulate tb_local_clk_hs, then open GTKWave
# Usage (from repo root):
#   .\STORAGE\run_local_clk_hs.ps1

$ErrorActionPreference = "Stop"
Set-Location (Split-Path $PSScriptRoot -Parent)

$Top      = "tb_local_clk_hs"
$OutDir   = "STORAGE"
$OutFile  = Join-Path $OutDir "$Top.out"
$VcdFile  = "tb_clk.vcd"
$FileList = "filelist.f"

Write-Host "==> Compiling with iverilog ..."
& iverilog -o $OutFile -s $Top -c $FileList
if ($LASTEXITCODE -ne 0) {
    Write-Error "iverilog failed (exit $LASTEXITCODE)"
    exit $LASTEXITCODE
}
Write-Host "    output: $OutFile"

Write-Host "==> Running simulation (vvp) ..."
& vvp -n $OutFile
if ($LASTEXITCODE -ne 0) {
    Write-Error "vvp failed (exit $LASTEXITCODE)"
    exit $LASTEXITCODE
}

if (-not (Test-Path $VcdFile)) {
    Write-Error "VCD not found: $VcdFile"
    exit 1
}
Write-Host "    vcd: $VcdFile"

Write-Host "==> Opening GTKWave ..."
Start-Process gtkwave -ArgumentList (Resolve-Path $VcdFile)
Write-Host "Done."
