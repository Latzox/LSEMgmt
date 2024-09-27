function Test-InternetConnection {
    <#
    .SYNOPSIS
    A brief description of what the function does.

    .DESCRIPTION
    A detailed explanation of the function’s purpose and how it works.

    .PARAMETER Param1
    Description of the first parameter.

    .PARAMETER Param2
    Description of the second parameter.

    .INPUTS
    If applicable, describe the types of objects that can be piped into this function.

    .OUTPUTS
    Describe the types of objects that the function returns.

    .EXAMPLE
    Example usage of the function with an explanation of what it does.
    PS> Get-SampleFunction -Param1 "Value1" -Param2 "Value2"

    .NOTES
    Additional information such as author, version, and any other notes.

    .LINK
    Link to documentation or related functions if applicable.
    #>

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]$Param1,

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$Param2 = 10
    )

    Begin {
        Write-Verbose "Starting the function execution."

        # Global settings
        Set-StrictMode -Version Latest
        $ErrorActionPreference = 'Stop'

        function Test-InternetSpeed {
            try {
                # Measure start time
                $startTime = Get-Date
        
                # Create WebClient object
                $webClient = New-Object System.Net.WebClient
        
                # URL of the test file
                $fileURL = "http://speedtest.tele2.net/100MB.zip"
        
                # Get file size in bytes
                $webClient.OpenRead($fileURL) | Out-Null
                $fileSize = [int64]$webClient.ResponseHeaders["Content-Length"]
        
                # Download the file and save locally
                $tempFile = "testfile.zip"
                $webClient.DownloadFile($fileURL, $tempFile)
        
                # Measure end time
                $endTime = Get-Date
        
                # Calculate duration in seconds
                $duration = $endTime - $startTime
        
                # Calculate download speed in MB/s
                $speed = [math]::Round(($fileSize / 1MB) / $duration.TotalSeconds, 2)
        
                # Return the result as an object
                [pscustomobject]@{
                    StartTime         = $startTime
                    EndTime           = $endTime
                    Duration          = $duration.TotalSeconds
                    FileSizeMB        = [math]::Round($fileSize / 1MB, 2)
                    DownloadSpeedMBps = $speed
                }
            }
            catch {
                Write-Error "An error occurred during the download: $_"
            }
            finally {
                # Ensure the downloaded file is removed
                if (Test-Path $tempFile) {
                    Remove-Item $tempFile -ErrorAction SilentlyContinue
                }
            }
        }
        
        
    }

    Process {
        try {
            Write-Verbose "Starting to process."

            # Internet connection
            Test-Connection -Ping 8.8.8.8

            # Dns resolve
            Clear-DnsClientCache
            Resolve-DnsName -Name google.ch

            # Speed
            $speedTest = Test-InternetSpeed
            $downloadSpeed = $speedTest.DownloadSpeedMBps
            Write-Host "Current download speed is: $downloadSpeed"

            # Create output
            $output = @[PSCustomObject]@{
                Internet = Value
            }

        }
        catch {
            Write-Error "An error occurred: $_"
        }
    }

    End {
        Write-Verbose "Function execution completed."
    }
}
