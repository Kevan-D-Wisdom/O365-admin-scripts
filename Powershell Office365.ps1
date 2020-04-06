#Enter Office 365 Password
$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session

#

#Password Never Expiers
Get-MSOLUser -UserPrincipalName alias | Select PasswordNeverExpires

Set-MsolUser -UserPrincipalName macmini2@uncommon.london -PasswordNeverExpires $true

#Add Mailbox Permission
Add-MailboxPermission dsei -User victoria.mackarness -AccessRights FullAccess

#Add Calendar Permision
Add-MailboxFolderPermission -Identity smallmeetingroom:\calendar -user sophie.emmings -AccessRights Editor

#Check Calendar Permision
Get-MailboxFolderPermission UncommonUsageTracking:\calendar

#Remove Mailbox Permission
Remove-MailboxPermission -Identity Dhulse -user access@stlukes.co.uk -AccessRights FullAccess -InheritanceType All

#Remote singed requre admin login 
Set-ExecutionPolicy RemoteSigned 

#Everyone access to all permissions 
Get-Mailbox | foreach{ Add-MailboxFolderPermission $($_.UserPrincipalName+":\calendar") -User clare -AccessRights Editor }

#Public folder
Add-PublicFolderClientPermission -Identity "\Uncommon Global\Uncommon Global Address Book" -User Mike -AccessRights Editor

#Remove Public Folder permissions
Remove-PublicFolderClientPermission -Identity "\Uncommon Global\Uncommon Global Address Book" -User Mike -Confirm

#Removeing Everyone access calendar
Get-Mailbox | foreach{ Remove-MailboxFolderPermission -Identity meetingroom1:\calendar -User $($_.UserPrincipalName) }


#Everyone access to one calendar
Get-Mailbox | foreach{ Remov-MailboxFolderPermission -Identity meetingroom2:\calendar -User $($_.UserPrincipalName) -AccessRights Editor }

#teams meeting login 
Set-ExecutionPolicy RemoteSigned 

 
Import-Module SkypeOnlineConnector 
 

$session = New-CsOnlineSession -OverrideAdminDomain "dovetailit.onmicrosoft.com" -verbose
  
   
#MeetingRoom 

Get-calendarprocessing calendar@whatever.org  | fl
set-calendarprocessing calendar@whatever.org  -DeleteNonCalendarItems $False




Import-PSSession $session




Set-CalendarProcessing -Identity Grooverider -AddOrganizerToSubject $false -OrganizerInfo $true -DeleteAttachments $true -DeleteComments $false -DeleteSubject $false -RemovePrivateProperty $false

Get-CalendarProcessing -Identity Grooverider | Format-List identity,deletesubject,addorganizertosubject,DeleteComments,RemovePrivateProperty