# LSEMgmt

**LSEMgmt** is a PowerShell module designed to help with daily system management tasks, including logging, file downloads, disk usage checks, network diagnostics, and more.

## Features
- `Write-Log`: Write structured logs to a file or console.
- `Invoke-FileDownload`: Download files from a specified URL with System.WebClient
- `Get-DiskUsage`: Analyze disk usage across directories.
- `Test-InternetConnection`: Quickly check if the internet connection is up and running.
- `Invoke-ApiRequest`: Automate REST API calls.
- `Invoke-SQLQuery`: Quickly execute SQL queries on your databases.
- `Set-EnvironmentVariable`: Easily manage environment variables.
- `Get-NetworkInfo`: Retrieve network details.
- `Test-PortAvailability`: Check if a specific port is open.
- `Get-OSDetails`: Get details about the operating system.

## Installation

To install this module from the PowerShell Gallery:

```PowerShell
Install-Module -Name LSEMgmt -Repository PSGallery
```

## Usage
Here are some usage examples:

#### Write environment variables
```PowerShell
Set-EnvironmentVariable -Name "MyVar" -Value "MyValue" -Scope User
```

#### List folders and files with high storage usage
```PowerShell
Get-DiskUsage -Path C:\Project\ -TopFiles 10
```

#### Invoke sql quieries on a database
```PowerShell
Invoke-SQLQuery -Query "SELECT * FROM Users" -Server "localhost" -Database "DB"
```
