New-Item -ItemType SymbolicLink -Path $env:LOCALAPPDATA\nvim -Value $env:USERPROFILE\dotfiles\nvim
npm i -g typescript typescript-language-server @fsouza/prettierd
cargo install stylua
scoop install lua-language-server
