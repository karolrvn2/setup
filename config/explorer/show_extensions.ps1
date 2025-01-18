# PowerShell script to show all file extensions

# Function to set a registry value
function Set-RegistryValue {
    param (
        [string]$Path,
        [string]$Name,
        [string]$Value,
        [string]$Type = "DWORD"
    )

    try {
        if (!(Test-Path $Path)) {
            New-Item -Path $Path -Force | Out-Null
        }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
        Write-Output "Successfully set $Name to $Value in $Path."
    } catch {
        Write-Error "Failed to set $Name. Error: $_"
    }
}

# Define the registry path and value
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$registryName = "HideFileExt"
$registryValue = 0

# Set the registry value to show all file extensions
Set-RegistryValue -Path $registryPath -Name $registryName -Value $registryValue

# Refresh Explorer to apply the changes
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Output "All file extensions are now set to be visible."



