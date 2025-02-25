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
    # Use Neovim
    #@{
    #    Link   = "$Env:USERPROFILE\.vimrc";
    #    Target = "$Env:USERPROFILE\dotfiles\.vimrc"
    #},
    @{
        Link   = "$Env:USERPROFILE\.gitconfig"
        Target = "$Env:USERPROFILE\dotfiles\.gitconfig-win"
    }#,
    # Notepad++は使わない
    #@{
    #    Link   = "$Env:APPDATA\Notepad++\config.xml"
    #    Target = "$ENV:USERPROFILE\dotfiles\Notepad++\config.xml";
    #},
    # Commitizenは必要になったら
    #@{
    #    Link   = "$ENV:USERPROFILE\.czrc"
    #    Target = "$ENV:USERPROFILE\dotfiles\.czrc";
    #}
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
    # Use VSCode's sync setting
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

if (Get-Command rye -ErrorAction SilentlyContinue -eq $null) {
    Write-Output "Install rye"
    [environment]::setEnvironmentVariable('RYE_TOOLCHAIN', 'E:/Programs/rye', 'User')
    [environment]::setEnvironmentVariable('RYE_TOOLCHAIN_VERSION', 'cpython@3.10.6', 'User')
    winget install -e --id rye.rye
}

if (Get-Command rye -ErrorAction SilentlyContinue -and -not (Test-Path -Path "$CompletionsDirectory\rye_completion.ps1")) {
    # Install rye-completion
    Write-Output "Install rye-completion"
    rye self completion -s powershell | Out-File -Encoding utf8 "$CompletionsDirectory\rye_completion.ps1"
}

if (Get-Command nvm -ErrorAction SilentlyContinue -eq $null) {
    Write-Output "Install nvm"
    [environment]::setEnvironmentVariable('NVM_HOME', 'E:/Programs/nvm', 'User')
    [environment]::setEnvironmentVariable('NVM_HOME', 'E:/Programs/nvm4w/nodejs', 'User')
    winget install -e --id CoreyButler.NVMforWindows
}

if (Get-Command nvm -ErrorAction SilentlyContinue -and -not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Output "Install npm"
    nvm install lts
    nvm use lts
}

if (Get-Command npm -ErrorAction SilentlyContinue -and -not (Get-InstalledModule npm-completion -ErrorAction SilentlyContinue)) {
    Write-Output "Install npm-completion"
    Install-Module npm-completion -Scope CurrentUser
}

if (Get-Command pnpm -ErrorAction SilentlyContinue -eq $null) {
    Write-Output "Install pnpm"
    [environment]::setEnvironmentVariable('PNPM_HOME', 'E:/Programs/pnpm', 'User')
    winget install -e --id pnpm.pnpm --location E:/Programs/pnpm
}

if (Get-Command scoop -ErrorAction SilentlyContinue -eq $null) {
    # Scoopのインストール
    Write-Output "Install scoop" 
    [environment]::setEnvironmentVariable('SCOOP', 'E:/Programs/scoop', 'User')
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

if (Get-Command rustup -ErrorAction SilentlyContinue -eq $null) {
    [environment]::setEnvironmentVariable('CARGO_HOME', 'E:/Programs/cargo', 'User')
    [environment]::setEnvironmentVariable('RUSTUP_HOME', 'E:/Programs/rustup', 'User')
    winget install -e --id rustlang.rustup
}

if (Get-Command nvim -ErrorAction SilentlyContinue -eq $null) {
    winget install -e --id Neovim.Neovim --override "/qf INSTALL_ROOT=E:/Programs/nvim"
    New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim -Value $env:USERPROFILE\dotfiles\nvim
}

if (Get-Command nvim -ErrorAction SilentlyContinue -and (Get-Command scoop -ErrorAction SilentlyContinue)) {
    if (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe") {
        $output = &"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
        if ($output) {
            scoop install lua-language-server
        }
        else {
            write-host "Visual Studio is not installed."
        }
    }
    else {
        write-host "Visual Studio is not installed."
    }
}

if (Get-Command nvim -ErrorAction SilentlyContinue -and (Get-Command pnpm -ErrorAction SilentlyContinue) -and ([string]::IsNullOrEmpty((pnpm list -g @fsouza/prettierd)))) {
    pnpm i -g @fsouza/prettierd
}
