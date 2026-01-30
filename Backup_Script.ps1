$db1 = 'S2_DB' 
$db2 = 'S2_Physio'
$db3 = 'S2_Physio'
$db4 = 'S2_prudl'
$db5 = 'S2MvcDb'
$db6 = 'S2Mvc2'
$db7 = 'WebsitePanel'
$dt = Get-Date -Format yyyyMMdd

New-Item -ItemType directory -Path D:\DB_Backup\SFTP\$($dt)

Backup-SqlDatabase -ServerInstance SERVER\SQLEXPRESS -Database $db1 -BackupFile D:\DB_Backup\SFTP\$($dt)\$($dt)_$($db1).bak 
Backup-SqlDatabase -ServerInstance SERVER\SQLEXPRESS -Database $db2 -BackupFile D:\DB_Backup\SFTP\$($dt)\$($dt)_$($db2).bak
Backup-SqlDatabase -ServerInstance SERVER\SQLEXPRESS -Database $db3 -BackupFile D:\DB_Backup\SFTP\$($dt)\$($dt)_$($db3).bak
Backup-SqlDatabase -ServerInstance SERVER\SQLEXPRESS -Database $db4 -BackupFile D:\DB_Backup\SFTP\$($dt)\$($dt)_$($db4).bak
Backup-SqlDatabase -ServerInstance SERVER\SQLEXPRESS -Database $db5 -BackupFile D:\DB_Backup\SFTP\$($dt)\$($dt)_$($db5).bak
Backup-SqlDatabase -ServerInstance SERVER\SQLEXPRESS -Database $db6 -BackupFile D:\DB_Backup\SFTP\$($dt)\$($dt)_$($db6).bak
Backup-SqlDatabase -ServerInstance SERVER\SQLEXPRESS -Database $db7 -BackupFile D:\DB_Backup\SFTP\$($dt)\$($dt)_$($db7).bak


Set-Location 'C:\Program Files\7-Zip'
.\7z a -tzip D:\DB_Backup\SFTP\$($dt).zip D:\DB_Backup\SFTP\$($dt)\*.*

Remove-Item D:\DB_Backup\SFTP\$($dt) -Force -Recurse -ErrorAction SilentlyContinue

E:\Stand_Alone\winscp\winscp.com /script=D:\Scripts\SFTP_SWSHHR_Script\SFTP.txt  

Move-Item D:\DB_Backup\SFTP\$($dt).zip D:\DB_Backup\

Rename-Item D:\Scripts\Logs\SFTP_SWHR\SWHHR.log D:\Scripts\Logs\SFTP_SWHHR\$($dt)_SWHHR.log

D:\Scripts\sendEmail\sendEmail.exe -f xxx@xxx.com.sg -t xxx@xxx.com.sg -cc xxx@xxx.com.sg -u SFTP SW to HR $($dt) -m Backup Log transfer from $($dt) -a D:\Scripts\Logs\SFTP\$($dt)_SW.log -s mail.xxx.com.sg -xu xxx@xxx.com.sg -xp xxx -o tls=yes
