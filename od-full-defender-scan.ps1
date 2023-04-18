# Start a full scan using Windows Defender
# Never test in production

$defenderPath = "C:\Program Files\Windows Defender"
$defenderExe = "$defenderPath\MpCmdRun.exe"
$scanType = "0"
$scanParameters = "/ScanType:$scanType"

Start-Process -FilePath $defenderExe -ArgumentList $scanParameters -Wait

# Check the status of the scan

while (1) {
    $status = Get-MpComputerStatus
    if ($status.AntivirusSignatureStatus -ne "Up to date" -or $status.AntivirusScanStatus -ne "Idle") {
        Write-Host "Scan is in progress..."
    } else {
        Write-Host "Scan is complete."
        break
    }
    Start-Sleep -Seconds 5
}
