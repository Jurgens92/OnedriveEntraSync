# Prompt for Tenant ID
$tenantID = Read-Host "Enter your Tenant ID"

# Create an empty array to store SharePoint sites
$sharepointSites = @()

# Prompt for SharePoint sites until user is done
do {
    $site = Read-Host "Enter SharePoint site URL (or press Enter to finish)"
    if ($site -ne "") {
        $sharepointSites += $site
    }
} while ($site -ne "")

# OneDrive configuration
$registryPath = "HKCU:\SOFTWARE\Microsoft\OneDrive"

# Force AutoMount
New-ItemProperty -Path $registryPath -Name "EnableADAL" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path $registryPath -Name "SilentAccountConfig" -Value 1 -PropertyType DWORD -Force

# Configure Known Folder Move
$registryPath = "HKCU:\SOFTWARE\Microsoft\OneDrive\Tenants\$tenantID"
New-ItemProperty -Path $registryPath -Name "KfmSilentOptIn" -Value "$tenantID" -PropertyType String -Force

# Configure folders to sync
$registryPath = "HKCU:\SOFTWARE\Microsoft\OneDrive\Tenants\$tenantID\KfmSilentOptInWithNotification"
New-ItemProperty -Path $registryPath -Name "Desktop" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path $registryPath -Name "Documents" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path $registryPath -Name "Pictures" -Value 1 -PropertyType DWORD -Force

# Start OneDrive process
Start-Process "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe" -ArgumentList "/background"

# Wait for OneDrive to initialize
Start-Sleep -Seconds 30

# Sync each SharePoint site's Documents library
foreach ($site in $sharepointSites) {
    $documentsURL = "$site/Documents"
    Write-Host "Syncing Documents library from: $documentsURL"
    Start-Process "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe" -ArgumentList "/sharepoint:$documentsURL"
    Start-Sleep -Seconds 10  # Wait between each sync request
}

Write-Host "Configuration complete. Please check OneDrive client to confirm sync status."
