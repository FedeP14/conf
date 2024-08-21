# ██████  ███    ██     ███████ ████████  █████  ██████  ████████ 
#██    ██ ████   ██     ██         ██    ██   ██ ██   ██    ██    
#██    ██ ██ ██  ██     ███████    ██    ███████ ██████     ██    
#██    ██ ██  ██ ██          ██    ██    ██   ██ ██   ██    ██    
# ██████  ██   ████     ███████    ██    ██   ██ ██   ██    ██    
                                                                 
                                                            
# opt out telemetry (Only as admin)
if ([bool]([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem) {
    [System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'true', [System.EnvironmentVariableTarget]::Machine)
}

# import oh-my-posh theme
oh-my-posh init pwsh --config 'C:\Users\Federico\AppData\Local\Programs\oh-my-posh\themes\hul10.omp.json' | Invoke-Expression

# Zoxide
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})


# █████  ██      ██  █████  ███████ 
#██   ██ ██      ██ ██   ██ ██      
#███████ ██      ██ ███████ ███████ 
#██   ██ ██      ██ ██   ██      ██ 
#██   ██ ███████ ██ ██   ██ ███████ 
                                   
                                   
function reload-profile {
    & $profile
}

function winutil {
	iwr -useb https://christitus.com/win | iex
}

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function lazyg {
    git add .
    git commit -m "$args"
    git push
}

# Quick Access to System Information
function sysinfo { Get-ComputerInfo }

# Networking Utilities
function flushdns {
	Clear-DnsClientCache
	Write-Host "DNS has been flushed"
}

function Show-Help {
    @"
PowerShell Profile Help
=======================

Edit-Profile - Opens the current user's profile for editing using the configured editor.

winutil - Runs the WinUtil script from Chris Titus Tech.

reload-profile - Reloads the current user's PowerShell profile.

grep <regex> [dir] - Searches for a regex pattern in files within the specified directory or from the pipeline input.

pkill <name> - Kills processes by name.

mkcd <dir> - Creates and changes to a new directory.

ep - Opens the profile for editing.

k9 <name> - Kills a process by name.

la - Lists all files in the current directory with detailed formatting.

ll - Lists all files, including hidden, in the current directory with detailed formatting.

gs - Shortcut for 'git status'.

ga - Shortcut for 'git add .'.

gc <message> - Shortcut for 'git commit -m'.

gp - Shortcut for 'git push'.

gcom <message> - Adds all changes and commits with the specified message.

lazyg <message> - Adds all changes, commits with the specified message, and pushes to the remote repository.

flushdns - Clears the DNS cache.

pst - Retrieves text from the clipboard.

Use 'Show-Help' to display this help message.
"@
}
Write-Host "Use 'Show-Help' to display help"


