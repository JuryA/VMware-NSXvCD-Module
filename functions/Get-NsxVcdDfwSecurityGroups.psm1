Function Get-NsxVcdDfwSecurityGroups {
    <#
    .DESCRIPTION
        Returnes the Security Groups of the OrgVdc DFW.

    .NOTES
        File Name  : Get-NsxVcdDfwSecurityGroups.ps1
        Author     : Markus Kraus
        Version    : 1.0
        State      : Ready

    .LINK
        https://mycloudrevolution.com/

    .EXAMPLE
       Get-NsxVcdDfwSecurityGroups -OrgId OrgVdcId

    .EXAMPLE
       Get-NsxVcdDfwSecurityGroups -OrgId OrgVdcId -OutputXML

    .EXAMPLE
       Get-NsxVcdDfwSecurityGroups -OrgVdcId OrgVdcId | select objectId, name, @{N='type'; E= {$_.type.typeName}}

    .PARAMETER OrgVdcId
        Id of the OrgVdcId

    .PARAMETER OutputXML
        Output the result as XML

    #>
    Param (
        [Parameter(Mandatory=$True, ValueFromPipeline=$False, HelpMessage="Id of the OrgVdc")]
        [ValidateNotNullorEmpty()]
            [String] $OrgVdcId,
        [Parameter(Mandatory=$False, ValueFromPipeline=$False, HelpMessage="Display Rules as XML")]
        [ValidateNotNullorEmpty()]
            [Switch] $OutputXML
    )
    Process {

        [xml]$DfwSecurityGroups = Invoke-NsxVcdApiCall -Uri "/network/services/securitygroup/scope/$OrgVdcId" -Method "Get"


        if ($OutputXML) {
            $DfwSecurityGroups | Format-XML
        }
        else {
            $DfwSecurityGroups.list.securitygroup
        }
    }
}
