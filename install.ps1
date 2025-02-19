# Make SymbolicLink

# @see https://qiita.com/sakekasunuts/items/63a4023887348722b416
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) {
    Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit
}

class LinkPath {
    [string] $Target
    [string] $Link
    LinkPath([hashtable]$Properties) {
        foreach ($Property in $Properties.Keys) {
            echo $Property
            $this.$Property = $Properties.$Property
        }
    }
    [bool] IsAlreadyExists() {
        return Test-Path -Path $this.Link
    }
    [void] MakeLink() {
        $this.MakeLink($false)
    }
    [void] MakeLink([bool]$Force ) {
        if ($this.IsAlreadyExists()) {
            if ($Force) {
                (Get-Item $this.Link).Delete()
            }
            else {
                Write-Host "Link $($this.Link) alread exists."
                return
            }
        }
        Write-Host $this.Link
        Write-Host $this.Target
        New-Item -ItemType SymbolicLink -Path $this.Link -Value $this.Target
    }
}

$LinkPathItems = (
    @{
        Link   = "$Env:USERPROFILE\.vimrc";
        Target = "$Env:USERPROFILE\dotfiles\.vimrc"
    },
    @{
        Link     = "$Env:USERPROFILE\.gitconfig"
        Target = "$Env:USERPROFILE\dotfiles\.gitconfig-win"
    },
    @{
        Link   = "$Env:APPDATA\Notepad++\config.xml"
        Target = "$ENV:USERPROFILE\dotfiles\Notepad++\config.xml";
    },
    @{
        Link   = "$ENV:USERPROFILE\.czrc"
        Target = "$ENV:USERPROFILE\dotfiles\.czrc";
    }
)

$CompletionsDotfilesPath = "$Env:USERPROFILE\dotfiles\Powershell-Completions"
$CompletionFiles = Get-Childitem $CompletionsDotfilesPath
$CompletionsDirectory = "$Env:USERPROFILE\Documents\Powershell\Completions"

if (-not (Test-Path -Path $CompletionsDirectory)) {
    New-Item -Path $CompletionsDirectory -ItemType Directory
}

foreach ($CompletionFile in $CompletionFiles) {
    $LinkPathItems += @{
        Link   = "$CompletionsDirectory\$($CompletionFile.Name)"
        Target = "$CompletionsDotfilesPath\$($CompletionFile.Name)"
    }
}

if (Test-Path -Path "$Env:USERPROFILE\dotfiles\dotfiles-priv") {
    # $LinkPathItems += @{
    #     Link   = "$Env:APPDATA\Code\User\settings.json"
    #     Target = "$Env:USERPROFILE\dotfiles\dotfiles-priv\vscode/ms-settings.json"
    # }
    # $LinkPathItems += @{
    #     Link   = "$Env:APPDATA\Code\User\keybindings.json"
    #     Target = "$Env:USERPROFILE\dotfiles\dotfiles-priv\vscode/ms-keybindings.json"
    # }
    $LinkPathItems += @{
        Link   = "$Env:APPDATA\Code\User\snippets";
        Target = "$Env:USERPROFILE\dotfiles\dotfiles-priv\vscode\snippets"
    }
    $LinkPathItems += @{
        Link   = "$Env:LOCALAPPDATA\nvim";
        Target = "$Env:USERPROFILE\dotfiles\nvim"
    }
}

foreach ($LinkPathItem in $LinkPathItems) {
    $LinkPathInstance = New-Object LinkPath($LinkPathItem)
    $LinkPathInstance.MakeLink()
}

if (Test-Path $profile) {
    Remove-Item $profile
}
New-Item -Path ($profile -replace "\\[\w\d.]+$", "") -Name ((New-Object regex("[\w\d.]+$")).Matches($profile).Groups[0].Value) -Value (Convert-Path .\Microsoft.PowerShell_profile.ps1) -ItemType SymbolicLink

if (Get-Command rye) {
    rye self completion -s powershell | Out-File -Encoding utf8 "$CompletionsDirectory\rye_completion.ps1"
}

if (Get-Command npm) {
    Install-Module npm-completion -Scope CurrentUser
}
