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
            Write-Output $Property
            $this.$Property = $Properties.$Property
        }
    }
    [bool] IsAlreadyExists() {
        return Test-Path -Path $this.Link
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

$LinkPathItems = @(
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
    $LinkPathInstance.MakeLink($false)
}

if (Test-Path -LiteralPath "./Microsoft.PowerShell_profile.ps1") {
    if (Test-Path -LiteralPath $profile) {
        Remove-Item $profile
    }
    New-Item -Path ($profile -replace "\\[\w.]+$", "") -Name ((New-Object regex("[\w.]+$")).Matches($profile).Groups[0].Value) -Value (Convert-Path -LiteralPath "./Microsoft.PowerShell_profile.ps1") -ItemType SymbolicLink
}

if (-not(Get-Command rye -ErrorAction SilentlyContinue)) {
    Write-Output "Install rye"
    $ryeToolchain = Convert-Path -LiteralPath 'E:/Programs/rye'
    $ryeToolchainVersion = 'cpython@3.10.6'
    [environment]::setEnvironmentVariable('RYE_TOOLCHAIN', $ryeToolchain, 'User')
    [environment]::setEnvironmentVariable('RYE_TOOLCHAIN_VERSION', $ryeToolchainVersion, 'User')
    $env:RYE_TOOLCHAIN = $ryeToolchain
    $env:RYE_TOOLCHAIN_VERSION = $ryeToolchainVersion
    winget install -e --id rye.rye
}

if ((Get-Command rye -ErrorAction SilentlyContinue) -and -not (Test-Path -Path "$CompletionsDirectory\rye_completion.ps1")) {
    # Install rye-completion
    Write-Output "Install rye-completion"
    rye self completion -s powershell | Out-File -Encoding utf8 "$CompletionsDirectory\rye_completion.ps1"
}

if (-not (Get-Command nvm -ErrorAction SilentlyContinue)) {
    Write-Output "Install nvm"
    $nvmHome = Convert-Path -LiteralPath "E:\Programs\nvm"
    $nvmSymLink = Convert-Path -LiteralPath "E:\Programs\nvm4w\nodejs"
    [environment]::setEnvironmentVariable('NVM_HOME', $nvmHome, 'User')
    [environment]::setEnvironmentVariable('NVM_SYMLINK', $nvmSymLink, 'User')
    $env:NVM_HOME = $nvmHome
    $env:NVM_SYMLINK = $nvmSymLink
    winget install -e --id CoreyButler.NVMforWindows
}

if ((Get-Command nvm -ErrorAction SilentlyContinue) -and -not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Output "Install npm"
    nvm install lts
    nvm use lts
}

if ((Get-Command npm -ErrorAction SilentlyContinue) -and -not (Get-InstalledModule npm-completion -ErrorAction SilentlyContinue)) {
    Write-Output "Install npm-completion"
    Install-Module npm-completion -Scope CurrentUser
}

if (-not (Get-Command pnpm -ErrorAction SilentlyContinue)) {
    Write-Output "Install pnpm"

    $pnpmPath = Convert-Path -LiteralPath 'E:/Programs/pnpm'
    [environment]::setEnvironmentVariable('PNPM_HOME', $pnpmPath, 'User')
    $env:PNPM_HOME = $pnpmPath

    $currentPath = [environment]::getEnvironmentVariable('PATH', 'User')
    if (($currentPath -notlike "*$pnpmPath*") -and ($currentPath -notlike "*%PNPM_HOME%*")) {
        $updatedPath = "$currentPath;%PNPM_HOME%"
        [environment]::setEnvironmentVariable("PATH", $updatedPath, 'User')
    }
    if ($env:PATH -notlike "*$pnpmPath*") {
        $env:PATH = "$env:PATH;$pnpmPath"
    }

    winget install -e --id pnpm.pnpm --location E:/Programs/pnpm
}

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    # Scoopのインストール
    Write-Output "Install scoop"
    $scoopPath = Convert-Path -LiteralPath 'E:\Programs\scoop'
    [environment]::setEnvironmentVariable('SCOOP', $scoopPath, 'User')
    $env:SCOOP = $scoopPath
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

if (-not (Get-Command rustup -ErrorAction SilentlyContinue)) {
    $cargoHome = Convert-Path 'E:/Programs/cargo'
    $rustupHome = Convert-Path 'E:/Programs/rustup'
    [environment]::setEnvironmentVariable('CARGO_HOME', $cargoHome, 'User')
    [environment]::setEnvironmentVariable('RUSTUP_HOME', $rustupHome, 'User')
    $env:CARGO_HOME = $cargoHome
    $env:RUSTUP_HOME = $rustupHome
    winget install -e --id rustlang.rustup
}

if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    winget install -e --id Neovim.Neovim --override "/qf INSTALL_ROOT=E:/Programs/nvim"
    New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim -Value $env:USERPROFILE\dotfiles\nvim
}

if ((Get-Command nvim -ErrorAction SilentlyContinue) -and (Get-Command scoop -ErrorAction SilentlyContinue)) {
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

if ((Get-Command nvim -ErrorAction SilentlyContinue) -and (Get-Command pnpm -ErrorAction SilentlyContinue) -and ([string]::IsNullOrEmpty((pnpm list -g @fsouza/prettierd)))) {
    pnpm i -g @fsouza/prettierd
}

if ((Get-Command nvim -ErrorAction SilentlyContinue) -and -not ((Get-Command clang -ErrorAction SilentlyContinue) -or (Get-Command gcc -ErrorAction SilentlyContinue))) {
    $llvmPath = Convert-Path -LiteralPath 'E:/Programs/llvm'
    winget install -e --id llvm.llvm --location $llvmPath

    $currentLlvmHome = [environment]::getEnvironmentVariable('LLVM_HOME', 'User')
    if ($currentLlvmHome -ne $llvmPath) {
        [environment]::setEnvironmentVariable('LLVM_HOME', $llvmPath, 'User')
    }
    if ($env:LLVM_HOME -ne $llvmPath) {
        $env:LLVM_HOME = $llvmPath
    }
    $currentPath = [environment]::getEnvironmentVariable('PATH', 'User')
    if ($currentPath -notlike "*$llvmPath\bin*") {
        $updatedPath = "$currentPath;$llvmPath\bin"
        [environment]::setEnvironmentVariable("PATH", $updatedPath, 'User')
    }
    if ($env:PATH -notlike "*$llvmPath\bin*") {
        $env:PATH = "$env:PATH;$llvmPath\bin"
    }
    $currentLib = [environment]::getEnvironmentVariable('LIB', 'User')
    if ($currentLib -notlike "*$llvmPath\lib*") {
        $updatedLib = "$currentLib;$llvmPath\lib;$llvmPath\lib\clang\19\lib"
        [environment]::setEnvironmentVariable("LIB", $updatedLib, 'User')
    }
    if ($env:LIB -notlike "*$llvmPath\lib*") {
        $env:LIB = "$env:LIB;$llvmPath\lib"
    }
    $currentInclude = [environment]::getEnvironmentVariable('INCLUDE', 'User')
    if ($currentInclude -notlike "*$llvmPath\include*") {
        $updatedInclude = "$currentInclude;$llvmPath\include;$llvmPath\lib\clang\19\include;E:\Programs\llvm\lib\clang\19\include\llvm_libc_wrappers"
        [environment]::setEnvironmentVariable("INCLUDE", $updatedInclude, 'User')
    }
    if ($env:INCLUDE -notlike "*$llvmPath\include*") {
        $env:INCLUDE = "$env:INCLUDE;$llvmPath\include;$llvmPath\lib\clang\19\include;E:\Programs\llvm\lib\clang\19\include\llvm_libc_wrappers"
    }
    $currentcpath = [environment]::getEnvironmentVariable('CPATH', 'User')
    if ($currentcpath -notlike "*$llvmPath\include*") {
        $updatedcpath = "$currentcpath;$llvmPath\include;$llvmPath\lib\clang\19\include;E:\Programs\llvm\lib\clang\19\include\llvm_libc_wrappers"
        [environment]::setEnvironmentVariable("CPATH", $updatedcpath, 'User')
    }
    if ($env:CPATH -notlike "*$llvmPath\include*") {
        $env:CPATH = "$env:CPATH;$llvmPath\include;$llvmPath\lib\clang\19\include;E:\Programs\llvm\lib\clang\19\include\llvm_libc_wrappers"
    }
}

if (-not (Get-Command bat -ErrorAction SilentlyContinue)) {
    winget install -e --id sharkdp.bat --location "E:/Programs/bat"
}