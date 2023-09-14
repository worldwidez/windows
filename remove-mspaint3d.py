# This script will uninstall Microsoft Paint 3D from a Windows machine.
# WARNING: Run this script with administrative privileges.
# Compatible with: Windows 10, Windows 11

# Check if the script is being run as an administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if ($isAdmin -eq $false) {
    Write-Host "Please run this script as an Administrator."
    exit
}

# Get the package name for Microsoft Paint 3D
$packageName = Get-WindowsPackage -Online | Where-Object {$_.PackageName -like "*Paint3D*"}

if ($packageName) {
    # Uninstall Microsoft Paint 3D
    Remove-WindowsPackage -Online -PackageName $packageName.PackageName
    Write-Host "Microsoft Paint 3D has been uninstalled."
} else {
    Write-Host "Microsoft Paint 3D is not installed on this system."
}
