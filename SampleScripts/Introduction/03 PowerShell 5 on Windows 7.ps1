$labSources = Get-LabSourcesLocation

New-LabDefinition -Name 'dotnet452' -DefaultVirtualizationEngine HyperV
Add-LabMachineDefinition -Name Client7 -Memory 1GB -OperatingSystem 'Windows 7 PROFESSIONAL' -ToolsPath $labSources\Tools
Install-Lab

Install-LabSoftwarePackage -Path $labSources\SoftwarePackages\NDP452-KB2901907-x86-x64-AllOS-ENU.exe -CommandLine '/q /log c:\dotnet452.txt' -ComputerName Client7 -AsScheduledJob -UseShellExecute
Restart-LabVM -ComputerName Client7 -Wait

Install-LabSoftwarePackage -Path $labSources\V5\Win7AndW2K8R2-KB3134760-x64.msu -ComputerName Client7
Restart-LabVM -ComputerName Client7 -Wait

Install-LabSoftwarePackage -Path $labSources\SoftwarePackages\Notepad++.exe -ComputerName Client7 -CommandLine /S

Copy-LabFileItem -Path 'C:\Program Files\WindowsPowerShell\Modules\NTFSSecurity' -DestinationFolder 'C:\Program Files\WindowsPowerShell\Modules' -ComputerName Client7

Checkpoint-LabVM -All -SnapshotName 1

Show-LabDeploymentSummary -Detailed
