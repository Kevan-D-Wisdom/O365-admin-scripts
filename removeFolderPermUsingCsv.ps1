#log in to O365 tenant
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
#import the O365 powersell commandlets
Import-PSSession $Session

#get all permissions on the user calendar and export to csv file
Get-MailboxFolderPermission -Identity user@example.com:\Calendar:\Calendar |Export-Csv C:\AzureADUserList\user_perm_before.csv


#import csv file
$csv = Import-Csv C:\AzureADUserList\user_perm_before.csv

#access each row from the User column and remove thier permission from the calendar
$csv.User| ForEach-Object{ 
Remove-MailboxFolderPermission -Identity user@example.com:\Calendar -User $csv.User}

#get all permissions on the user calendar and export to csv file
Get-MailboxFolderPermission -Identity user@example.com:\Calendar:\Calendar |Export-Csv C:\AzureADUserList\user_perm_after.csv