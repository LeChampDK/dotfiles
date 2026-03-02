# Dotfiles

Cross-platform dotfiles for Linux, macOS, and Windows.

## Structure

```
.vimrc          ← Shared (all platforms)
.bashrc         ← Linux
.zshrc          ← macOS
windows/        ← PowerShell profile
.scripts/       ← Shared utility scripts
install.sh      ← Auto-detect OS and symlink
```

## Install

```bash
git clone https://github.com/LeChampDK/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The installer will:
1. Detect your OS
2. Symlink `.vimrc` (always)
3. Symlink the OS-specific shell config (`.bashrc` / `.zshrc` / PowerShell profile)
4. Back up any existing files to `~/.dotfiles-backups/<timestamp>/`

## Local overrides (not tracked)

Each shell sources a `.local` file at the end — use these for machine-specific config:

| Shell | Local override file |
|-------|-------------------|
| Bash | `~/.bashrc.local` |
| Zsh | `~/.zshrc.local` |
| PowerShell | `~/.ps_local.ps1` |

Also sourced (if present): `~/.bash_secrets`, `~/.zsh_secrets`, etc.

## Windows

On Windows, run from Git Bash or copy the PowerShell profile manually:

```powershell
Copy-Item .\windows\Microsoft.PowerShell_profile.ps1 $PROFILE
```

## Scripts

Put shared scripts in `.scripts/` — all platforms add `~/.scripts` to PATH.
