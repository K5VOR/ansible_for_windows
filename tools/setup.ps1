function Set-AnsibleDockerEnv
{
    $path = "$env:path;$PWD\bin"
    $env:ANSIBLE_DOCKER_HOST = $pwd
    $env:Path = $path
    [System.Environment]::SetEnvironmentVariable('ANSIBLE_DOCKER_HOST', $PWD, [System.EnvironmentVariableTarget]::User)
    [System.Environment]::SetEnvironmentVariable('PATH', "$env:path;$PWD\bin", [System.EnvironmentVariableTarget]::User)
}

function Get-Docker {
    Import-Module BitsTransfer
    $url = "https://download.docker.com/win/stable/Docker%20Desktop%20Installer.exe"
    $output ="$env:USERPROFILE\downloads\docker.exe"

    Start-BitsTransfer -Source $url -Destination $output
    Start-Process -FilePath "$output" -Verb RunAS -Wait
    if ((Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain) {
        Start-Process powershell "Add-LocalGroupMember -Group 'docker-users' -Member '$env:USERDOMAIN\$env:username'" -Verb runas -Wait
    } else {
        Start-Process powershell "Add-LocalGroupMember -Group 'docker-users' -Member '$env:username'" -Verb runas -Wait
    }


}

if ($env:ansible_docker_host -eq $null) {
    if ($(Get-Process 'com.docker.proxy' -ErrorAction SilentlyContinue) -eq $null) {
        if ($args[0] -eq "install") {
            Get-Docker
            Set-AnsibleDockerEnv
        } else {
            Write-Host "Docker is not currently running. Please start the process, or install before continuing."
            Write-Host "If you would like this script to install Docker, please run it with install added to the end ex. 'setup install'"
        }
    } else {
       Set-AnsibleDockerEnv
    }
} else {
    Write-Host "Setup already ran successfully."
}


