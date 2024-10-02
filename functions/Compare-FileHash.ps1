function Compare-FileHash {
    <#
    .SYNOPSIS
    Compares file hashes or a file hash with a checksum.

    .DESCRIPTION
    This function compares the hash of a file with another file or a provided checksum.

    .PARAMETER Algorithm
    The hashing algorithm to use (MD5, SHA1, SHA256, SHA384, SHA512).

    .PARAMETER File1
    The path of the first file to compare.

    .PARAMETER Checksum
    The checksum to compare with the hash of File1.

    .PARAMETER File2
    The path of the second file to compare with File1.

    .INPUTS
    None. You cannot pipe objects to this function.

    .OUTPUTS
    PSCustomObject with comparison results.

    .EXAMPLE
    Compare-FileHash -Algorithm SHA256 -File1 "C:\file1.txt" -Checksum "ABC123"

    .EXAMPLE
    Compare-FileHash -Algorithm SHA256 -File1 "C:\file1.txt" -File2 "C:\file2.txt"

    .NOTES
    Author: https://github.com/Latzox
    Version: 1.0.0

    .LINK
    https://github.com/Latzox/LSEMgmt
    #>

    [CmdletBinding(DefaultParameterSetName = 'FileComparison')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateSet("MD5", "SHA1", "SHA256", "SHA384", "SHA512")]
        [string]$Algorithm,

        [Parameter(Mandatory = $true)]
        [ValidateScript({Test-Path $_})]
        [string]$File1,

        [Parameter(Mandatory = $true, ParameterSetName = 'ChecksumComparison')]
        [string]$Checksum,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'FileComparison')]
        [ValidateScript({Test-Path $_})]
        [string]$File2
    )

    Begin {
        Write-Verbose "Starting the function execution."
        Set-StrictMode -Version Latest
        $ErrorActionPreference = 'Stop'
    }

    Process {
        try {
            Write-Verbose "Starting to process."

            $Result = [PSCustomObject]@{
                Algorithm = $Algorithm
                File1 = $File1
                File2 = $null
                Checksum = $null
                Match = $false
            }

            switch ($PSCmdlet.ParameterSetName) {
                'ChecksumComparison' {
                    Write-Verbose "Comparing $File1 with checksum $Checksum."
                    $Hash1 = (Get-FileHash -Algorithm $Algorithm -Path $File1).Hash

                    $Result.Checksum = $Checksum
                    $Result.Match = ($Hash1 -eq $Checksum)

                }
                'FileComparison' {
                    Write-Verbose "Comparing $File1 with $File2."
                    $Hash1 = (Get-FileHash -Algorithm $Algorithm -Path $File1).Hash
                    $Hash2 = (Get-FileHash -Algorithm $Algorithm -Path $File2).Hash

                    $Result.File2 = $File2
                    $Result.Match = ($Hash1 -eq $Hash2)
                }
            }

            return $Result
        }
        catch {
            Write-Error "An error occurred: $_"
        }
    }

    End {
        Write-Verbose "Function execution completed."
    }
}
