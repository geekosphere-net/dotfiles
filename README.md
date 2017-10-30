# geekosphere does dotfiles - modeled from jldean & holman's repo

### WSL Configuration
Run the following to configure WSL from scratch...
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jldeen/dotfiles/wsl/configure.sh)"
```
### WSL Emulator Install
Run the following command from an Administrator PowerShell prompt...
```
Set-ExecutionPolicy Bypass; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jldeen/dotfiles/wsl/wslterm.ps1'))
```
