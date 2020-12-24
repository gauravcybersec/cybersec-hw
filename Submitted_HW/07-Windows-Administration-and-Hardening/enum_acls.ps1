write-output "Running script to display ACLs!"
$directory = Get-ChildItem -Path . -Exclude enum_acls.ps1
foreach ($item in $directory){
write-output @(Get-Acl $item.Name)
}
