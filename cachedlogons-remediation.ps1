# PowerShell script to set cachedlogonscount to 0

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

# Define the name of the registry property
$propertyName = "cachedlogonscount"

# Define the new value for the property
$newValue = 0

# Check if the registry path exists
if (Test-Path $registryPath) {
    # Get the current value of the property
    $currentValue = Get-ItemProperty -Path $registryPath -Name $propertyName

    # Check if the current value is different from the new value
    if ($currentValue.$propertyName -ne $newValue) {
        # Set the new value
        Set-ItemProperty -Path $registryPath -Name $propertyName -Value $newValue
        Write-Host "The value of '$propertyName' has been changed to $newValue."
    } else {
        Write-Host "The value of '$propertyName' is already set to $newValue."
    }
} else {
    Write-Error "Registry path '$registryPath' not found."
}

# End of script
