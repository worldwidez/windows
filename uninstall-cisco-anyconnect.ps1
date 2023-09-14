$applicationname = "Cisco AnyConnect"
$applicationlist = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall  |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -match "$applicationname" } | 
            Select-Object -Property Displayname, UninstallString
 
ForEach ($instance in $applicationlist)
{
	If ($instance.UninstallString)
	{
		$uninst = $instance.UninstallString
        $uninst = $uninst.Replace('Program Files (x86)', 'PROGRA~2')
        $uninst = $uninst.Replace('Cisco AnyConnect Secure Mobility Client', 'CISCOA~2')
		$uninst = $uninst.Replace('/I', '/X ')
		& cmd -ArgumentList "/c $uninst /quiet /norestart REBOOT=ReallySuppress"
	}
}
Close
