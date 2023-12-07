# PowerShell script to restrict anonymous access to named pipes and shares

# Define the registry path and value
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\LSA"
$valueName = "RestrictAnonymous"
$newValue = 1

# Check if the registry key exists
if (Test-Path $registryPath) {
    # Set the new value
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $newValue
    Write-Host "Registry value updated: RestrictAnonymous set to $newValue"
} else {
    Write-Host "Registry path not found: $registryPath"
}

# Refresh policy to apply changes
gpupdate /force
