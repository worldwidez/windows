# Define the registry paths and value name
$registryPaths = @(
    "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters",
    "HKLM:\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters"
)
$valueName = "RequireSecuritySignature"

foreach ($path in $registryPaths) {
    # Check if the path exists
    if (Test-Path $path) {
        # Get the current value
        $currentValue = Get-ItemProperty -Path $path -Name $valueName

        # Check if SMB signing is disabled
        if ($currentValue.$valueName -eq 0) {
            Write-Host "Enabling SMB Signing at $path"
            Set-ItemProperty -Path $path -Name $valueName -Value 1
        } else {
            Write-Host "SMB Signing is already enabled at $path"
        }
    } else {
        Write-Host "Path not found: $path"
    }
}
