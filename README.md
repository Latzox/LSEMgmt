# LSEMgmt

**LSEMgmt** is a PowerShell module designed to help with daily system management tasks, including logging, file downloads, disk usage checks, network diagnostics, and more.

## Features
- `Compare-FileHash`: Check the integrity of a file.

## Installation

To install this module you have to clone the repository and import the module. The module gets publish into a private registry at the moment.

## Usage
Here are some usage examples:

#### Check the integrity of a file.
```PowerShell
Compare-FileHash -Algorithm SHA256 -File1 "C:\file1.txt" -File2 "C:\file2.txt"
Compare-FileHash -Algorithm SHA256 -File1 "C:\file1.txt" -Checksum "ABC123"
```
