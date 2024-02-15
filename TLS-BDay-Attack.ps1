 # Define the registry key path
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168"

# Define the name of the value to check/add
$valueName = "Enabled"

# Check if the registry key exists
if (!(Test-Path -Path $registryPath)) {
    # If the registry key doesn't exist, create it
    New-Item -Path $registryPath -Force | Out-Null
}

# Check if the value exists
if (!(Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue)) {
    # If the value doesn't exist, create it with a value of 0
    New-ItemProperty -Path $registryPath -Name $valueName -Value 0 -PropertyType DWORD -Force | Out-Null
}
