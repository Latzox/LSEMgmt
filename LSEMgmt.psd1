@{
    RootModule        = 'LSEMgmt.psm1'
    ModuleVersion     = '1.0.2'
    GUID              = '515510cf-264e-4cd1-b3d8-a5bb164d668c'
    Author            = 'Marco Platzer'
    CompanyName       = 'SWISSPERFORM'
    Copyright         = '(c) Marco Platzer. All rights reserved.'
    Description       = 'A PowerShell module for local system environment management and monitoring tasks.'
    PowerShellVersion = '7.1'
    FunctionsToExport = 'Compare-FileHash'
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{
            Tags = 'System Management', 'Automation', 'PowerShell', 'Monitoring'
        }
    }
}

