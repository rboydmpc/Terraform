<#param(
    [Parameter(Mandatory)]
    [string]$hostname
)
#>


### Variables
$configJson = '<%=spec.encodeAsJson().toString()%>'
$configJson = $configJson | convertfrom-json -Depth 10
$configJson
$username = "aXBtYWRtaW4=" #Base64
$password = "UEBzc3cwcmQh" #Base64
$hostname = $configJson.instance.hostName
$configJson.instance.hostName
$configJson.instance.name
$configJson.customOptions.name
$URL = 'https://ipam.boyd.local/'
$EIPHeader = @{
    "x-ipm-username" = "$username"
    "x-ipm-password" = "$password"
    "cache-control"  = "no-cache"
    }
#$tags = $tags | convertfrom-json

$ContentType = 'application/json'
#$pool = $configJson.networkInterfaces.network.pool.id
$tempName = get-random







#### Get the subnet id #####    
    $getsubnets = Invoke-RestMethod  -Uri "$URL/rest/ip_block_subnet_list?WHERE=is_terminal=%271%27%20and%20subnet_ip_free_size>=%271%27" -Method Get -Headers $EIPHeader -ContentType "application/json" -SkipCertificateCheck
    $siteid = $getsubnets[0].site_id | where{$_ -ne ""}
    $subnetid = $getsubnets[0].subnet_id | where{$_ -ne ""}
    $subnetname = $getsubnets[0].subnet_name | where{$_ -ne ""}
    $siteid


##Get IP from subnet
#https://ipam.boyd.local/rpc/ip_find_free_address?parent_subnet_id=9&max_find=1

$GetIP = Invoke-RestMethod  -Uri "$URL/rpc/ip_find_free_address?parent_subnet_id=$subnetid&max_find=1" -Method Get -Headers $EIPHeader -ContentType "application/json" -SkipCertificateCheck
$IP = $GetIP.hostaddr
$IP


### Add IP address
    $addip = Invoke-RestMethod  -Uri "$URL/rest/ip_add?hostaddr=$IP&name=$hostname&site_id=$siteid" -Method Put -Headers $EIPHeader -SkipCertificateCheck
    #$addip
    #$hostname
    Write-Host "----------------------------------" -ForegroundColor Green
    Write-Host "IP Address $IP Successfully Added with hostname $hostname in subnet $subnetname" -ForegroundColor Green
    Write-Host "----------------------------------" -ForegroundColor Green




# Update JSON

$networkJson = $configJson.networkInterfaces

$networkJson | Add-Member NoteProperty -Name ipAddress -Value $IP -f
$networkJson | Add-Member NoteProperty -Name ipMode -Value 'static' -f
$networkJson | Add-Member NoteProperty -Name replaceHostRecord -Value $false -f
$configJson.networkInterfaces = $networkJson
#$configJson.metadata = New-Object pscustomobject
#$configJson.metadata = $tags

#################################################################################
### Export

$configJson = $configJson | ConvertTo-Json -Depth 10

$spec = @"
{
    "spec": $configJson
}
"@

$spec