# https://stackoverflow.com/questions/9738535/powershell-test-for-noninteractive-mode
function IsNonInteractiveShell {
    # Test each Arg for match of abbreviated '-NonInteractive' command.
    $NonInteractive = [Environment]::GetCommandLineArgs() | Where-Object{ $_ -like '-NonI*' }

    if ([Environment]::UserInteractive -and -not $NonInteractive) {
        # We are in an interactive shell.
        return $false
    }

    return $true
}

if (IsNonInteractiveShell) {
    return
}

# Load starship
Invoke-Expression (&starship init powershell)

# Autocomplte by history
Set-PSReadLineOption -PredictionSource History
# Use Emacs style to edit
Set-PSReadLineOption -EditMode Emacs
# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Autocompletion for arrow keys
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineOption -Colors @{
    InlinePrediction = "#888888"
}

New-Alias open ii
New-Alias l ls
