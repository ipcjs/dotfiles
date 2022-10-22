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

New-Alias open ii
New-Alias l ls
