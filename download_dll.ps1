# setup download url link and file name
$url = "https://github.com/SnowLeopardEngine/SPhysX-Cross/releases/download/PhysXGpu/PhysXGpu_64.dll"
$dllFileName = "PhysXGpu_64.dll"

# if dll not exist.
if (-not (Test-Path -Path dllFileName)) {
    Write-Host "Start downloading PhysXGpu_64.dll"
    # download the file
    Invoke-WebRequest -Uri $url -OutFile $dllFileName
    Write-Host "Finished downloading PhysXGpu_64.dll"
}