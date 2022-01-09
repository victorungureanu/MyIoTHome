#TODO: move to some shared module
function Get-Config {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [Alias("file")]
    [string] $ConfigFile
  )

  foreach ($i in $(Get-Content $ConfigFile)) {
    Set-Variable -Name $i.split("=")[0] -Value $i.split("=", 2)[1] -Scope Script #TODO: will this work if I move the cmdlet to its own module (i.e. different script?)
  }
}

Write-Host "Running the deploy.ps1 file ..."
# load some configuration
Get-Config -file ".\config\pi.config" #TODO: path should be relative to script path regardless of current directory
# - ip address of the raspberry pi
# - ssh user and password. TODO: use ssh key
# - local and remote paths?
Write-Host "$($pi__sshUser)@$($pi__address):$($pi__homeFolder)"
# copy the docker-compose.yml, env files and volumes to the pi using scp
& ssh -i $pi__sshItentityFile "$($pi__sshUser)@$($pi__address)" "mkdir -p $($pi__homeFolder)/config/containers && mkdir -p $($pi__homeFolder)/volumes"
& scp -i $pi__sshItentityFile .\docker-compose.yml "$($pi__sshUser)@$($pi__address):$($pi__homeFolder)/"
& scp -i $pi__sshItentityFile .\config\containers\*.env "$($pi__sshUser)@$($pi__address):$($pi__homeFolder)/config/containers/"
& scp -i $pi__sshItentityFile -r .\volumes\* "$($pi__sshUser)@$($pi__address):$($pi__homeFolder)/volumes/"

# run a docker-compose down && docker-compose up -d on the raspberry pi
& ssh -i $pi__sshItentityFile "$($pi__sshUser)@$($pi__address)" "cd $($pi__homeFolder) && docker-compose down && docker-compose up -d"

# run docker exec mosquitto mosquitto_passwd -b /mosquitto/pwfile/pwfile $MOSQUITTO__MQTTUSERNAME $MOSQUITTO__MQTTPASSWORD
#& ssh -i $pi__sshItentityFile "$($pi__sshUser)@$($pi__address)" "docker exec mosquitto mosquitto_passwd -b /mosquitto/pwfile/pwfile $MOSQUITTO__MQTTUSERNAME $MOSQUITTO__MQTTPASSWORD"

Write-Host "Finished running the deploy.ps1 file ..."