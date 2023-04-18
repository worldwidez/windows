# DisableAutoPlay.ps1
#
# This script disables AutoPlay for all drives on a Windows system.
# AutoPlay settings are stored in the Windows Registry, so this script
# modifies the registry to disable AutoPlay.
#
# Always Test in Pre-Prod 
#
# Make sure to run this script in an elevated PowerShell session (Run as Administrator).

# Function to check if running as Administrator
function IsAdmin() {
    # Get current user identity
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    # Create a Windows principal object for the current user
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal $currentUser
    # Define the Administrator role
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

    # Check if the current user is in the Administrator role
    return $currentPrincipal.IsInRole($adminRole)
}

# Ensure the script is running as Administrator
if (-not (IsAdmin)) {
    Write-Host "Please run this script as an Administrator." -ForegroundColor Red
    Exit
}

# Disable AutoPlay for all drives
# Define the registry path for the Explorer policies
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
# Define the registry name for the AutoPlay setting
$registryName = "NoDriveTypeAutoRun"
# Define the registry value to disable AutoPlay for all drives (0xFF)
$registryValue = 0xFF

# Check if the registry path exists, and create it if necessary
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value to disable AutoPlay for all drives
Set-ItemProperty -Path $registryPath -Name $registryName -Value $registryValue -Force

# Output a message to inform the user that AutoPlay has been disabled
Write-Host "AutoPlay has been disabled for all drives." -ForegroundColor Green
