Function Get-MgeGroupBasedLicenseAssignments {
    <#
        .DESCRIPTION
        This function gets all groups that have a license assigned to them.

        .SYNOPSIS
        This function gets all groups that have a license assigned to them.

        .PARAMETER SubscribedSkus
        This is the subscribed skus object. If you don't pass this in, the function will query the subscribed skus object.

        .EXAMPLE
        Get-MgeGroupBasedLicenseAssignments

        .INPUTS
        Object

        .OUTPUTS
        Object

        .NOTES
        Author: Gabe Delaney | thetolkeinblackguy@phzconsulting.com
        Version: 0.0.1
        Date: 01/28/2023
        Name: Get-MgeGroupBasedLicenseAssignments

        Version History:
        0.0.1 - 01/28/2023 - Initial release - Alpha

    #>
    [CmdletBinding()]
    param (      
        [Parameter(Mandatory=$false)]
        [object]$SubscribedSkus = (Get-MgSubscribedSku),
        [Parameter(Mandatory=$false)]
        [array]$Properties

    )
    Begin {
        $default_properties = @(
            "DisplayName",
            "Id",
            "OnPremisesSyncEnabled"
            
        )
        $all_properties = ($default_properties + $properties) | Sort-Object -Unique 

        # Set the default parameters
        $PSDefaultParameterValues = @{}
        $PSDefaultParameterValues["Get-MgGroup:Select"] = $all_properties
        $PSDefaultParameterValues["Get-MgGroup:All"] = $true
        $PSDefaultParameterValues["Select-Object:Property"] = $all_properties
        $PSDefaultParameterValues["Add-Member:MemberType"] = "NoteProperty"
        $PSDefaultParameterValues["Add-Member:Force"] = $true

        # Get the subscribed skus
        $object = [system.collections.generic.list[pscustomobject]]::new()
    } Process {
        Foreach ($sku in $subscribedSkus) {
            $sku_id = $sku.SkuId
            $sku_part_number = $sku.SkuPartNumber

            # Get all groups that have a license assigned to them
            $licensed_groups = Get-MgGroup -Filter "assignedLicenses/any(s:s/skuId eq $sku_id)" | Select-Object

            # If there are no groups with a license assigned to them, continue
            If (!$licensed_groups) {
                Continue
            
            }

            # Add the sku id to the object
            $licensed_groups | Add-Member -Name "AssignedSku" -Value $sku_id
            $licensed_groups | Add-Member -Name "SkuPartNumber" -Value $sku_part_number
            Foreach ($g in $licensed_groups) {
                # Add the group to the object
                [void]$object.Add($g)
            
            }
        }
    } End {
        Return $object 

    }
}