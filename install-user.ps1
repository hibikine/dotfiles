$install_location = "E:/Programs"

# posh-gitがインストールされているかを確認
$module = Get-Module -ListAvailable -Name posh-git

# posh-gitがインストールされていない場合にインストールする
if (-not $module) {
    Write-Host "posh-git is not installed. Installing posh-git..."
    Install-Module -Name posh-git -Scope CurrentUser -Force
} else {
    Write-Host "posh-git is already installed."
}

$module = Get-Module -ListAvailable -Name PSFzf

if (-not $module) {
    Write-Host "PSFzf is not installed. Installing PSFzf..."
    Install-Module -Name PSFzf -Scope CurrentUser -Force
} else {
    Write-Host "PSFzf is already installed."
}

$module = Get-Module -ListAvailable -Name ZLocation

if (-not $module) {
    Write-Host "ZLocation is not installed. Installing ZLocation..."
    Install-Module -Name ZLocation -Scope CurrentUser -Force
} else {
    Write-Host "ZLocation is already installed."
}

$module = Get-Module -ListAvailable -Name npm-completion

if (-not $module) {
    Write-Host "npm-completion is not installed. Installing npm-completion..."
    Install-Module -Name npm-completion -Scope CurrentUser -Force
} else {
    Write-Host "npm-completion is already installed."
}

$fzfPath = Get-Command fzf -ErrorAction SilentlyContinue
if (-not $fzfPath) {
    Write-Host "Install fzf"
    winget install -e --id junegunn.fzf --location "$install_location\fzf"
} else {
    Write-Host "fzf is already installed."
}

if ((Get-Command nvim -ErrorAction SilentlyContinue) -and (Get-Command scoop -ErrorAction SilentlyContinue)) {
    if (Test-Path "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe") {
        $output = &"C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe" -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
        if ($output) {
            # scoopでlua-language-serverがインストールされているかをチェック
            $luaLanguageServer = scoop list | Select-String -Pattern "lua-language-server"
            if (-not $luaLanguageServer) {
                Write-Host "lua-language-server is not installed. Installing lua-language-server..."
                scoop install lua-language-server
            } else {
                Write-Host "lua-language-server is already installed."
            }
        }
        else {
            write-host "Visual Studio is not installed."
        }
    }
    else {
        write-host "Visual Studio is not installed."
    }
}

