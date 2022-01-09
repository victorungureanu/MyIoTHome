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
Write-Host $pi__address
# copy the docker-compose.yml file to the pi using scp

# run a docker-compose down && docker-compose up -d on the raspberry pi

Write-Host "Finished running the deploy.ps1 file ..."