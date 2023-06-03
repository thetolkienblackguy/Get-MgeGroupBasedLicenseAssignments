# Get-MgeGroupBasedLicenseAssignments

Get-MgeGroupBasedLicenseAssignments is a PowerShell function designed to streamline the auditing process of group-based license assignments within Microsoft 365. This function utilizes the Microsoft Graph SDK, which represents a significant upgrade over the deprecated MSOnline PowerShell module.

## Description

Understanding group-based license assignments can be complex. This function simplifies this process by fetching all groups that have a license assigned to them. It uses server-side filtering to boost performance and utility, particularly for larger data sets.

## Installation

Clone this repository or download the PowerShell function file directly. Make sure you have the Microsoft Graph PowerShell SDK installed and configured with the necessary scopes to retrieve the information.

```powershell
Install-Module Microsoft.Graph
```

## Usage

You can use the function like this:

```powershell
Get-MgeGroupBasedLicenseAssignments
```

The function utilizes server-side filtering through Get-MgGroup and SKU id. The returned group objects include an extra property, "AssignedSku", that indicates the SKU assigned to them.

## Example

```powershell
Get-MgeGroupBasedLicenseAssignments
```

The output will be a list of group objects that have a license assigned to them, along with the SKU id of the assigned license.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)