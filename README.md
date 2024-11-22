# Configure-OneDriveEntraSync

A PowerShell script to automate OneDrive Known Folder Move (KFM) and SharePoint site synchronization for Windows 10/11 devices joined to Entra ID (Azure AD).

## System Requirements
* Windows 10 or Windows 11
* Entra ID (Azure AD) joined device
* OneDrive client installed
* PowerShell 5.1 or higher

## Account Requirements
* User must be signed into Windows with Entra ID account
* User needs permissions to modify registry
* Access rights to target SharePoint sites
* OneDrive license assigned

## Information Needed
* Entra ID Tenant ID
* SharePoint site URLs for synchronization

## Verify execution policy:
```powershell
Get-ExecutionPolicy
# If restricted, run:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Verify OneDrive installation:
```powershell
Test-Path "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe"
```

## Installation

Download the script:
```powershell
# Clone repository or download directly
git clone https://github.com/Jurgens92/OnedriveEntraSync.git
```

## Basic Usage

# When Prompted:

Enter your Tenant ID

Enter SharePoint site URLs one at a time

Press Enter (blank) when finished entering sites

# Example Input

Enter your Tenant ID: 12345678-1234-1234-1234-123456789012

Enter SharePoint site URL (or press Enter to finish): https://contoso.sharepoint.com/sites/Marketing

Enter SharePoint site URL (or press Enter to finish): https://contoso.sharepoint.com/sites/HR

Enter SharePoint site URL (or press Enter to finish): [Enter]


