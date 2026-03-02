# Dotfiles

Cross-platform dotfiles for Linux, macOS, and Windows.

## Quick Start

```bash
git clone https://github.com/LeChampDK/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer will:
1. Check for required dependencies (git, vim, gh, curl) — offers to install if missing
2. Detect your OS (Linux / macOS / Windows)
3. Symlink `.vimrc` (all platforms)
4. Symlink the OS-specific shell config (`.bashrc` / `.zshrc` / PowerShell profile)
5. Symlink `.scripts/` for shared utility scripts
6. Back up any existing files to `~/.dotfiles-backups/<timestamp>/`

## Structure

```
.vimrc                              ← Shared (all platforms)
.bashrc                             ← Linux
.zshrc                              ← macOS
windows/Microsoft.PowerShell_profile.ps1  ← Windows
.scripts/
├── gc                              ← Git commit + push
├── make-pr                         ← Create PR with branch selection
├── gitmaster-script                ← Search + clone/navigate repos
├── rider-script                    ← Open JetBrains Rider with .sln
└── shared-methods                  ← Shell functions (gm, gnb, gps, gpr)
install.sh                          ← Auto-detect OS, install deps, symlink
```

## Shell Functions & Aliases

Loaded via `shared-methods` (sourced automatically):

| Command | Description |
|---------|-------------|
| `gc "message"` | Add all, commit, push (warns on main branches) |
| `gm <search>` | Search GitHub repos, clone/navigate (`-p` for personal, `-l` for local) |
| `gnb <branch>` | Create new branch + push with tracking |
| `gps "title"` | Push + create PR (auto-detects target branch) |
| `gpr <branch> "message"` | New branch + commit + push + PR (combines gnb + gc + gps) |

## Local Overrides (not tracked)

For machine-specific config that shouldn't be in git:

| Shell | Local override file |
|-------|-------------------|
| Bash | `~/.bashrc.local` |
| Zsh | `~/.zshrc.local` |
| PowerShell | `~/.ps_local.ps1` |

Also sourced if present: `~/.bash_secrets`, `~/.zsh_secrets`, `~/.bash_aliases`, etc.

## Environment Variables

For `gm` (gitmaster) work mode:

| Variable | Description |
|----------|-------------|
| `ORG_NAME` | GitHub org name (work repos) |
| `DEFAULT_REPO_DIR` | Local directory for work repos |
| `PERSONAL_REPO_DIR` | Local directory for personal repos (default: `~/repos`) |

Set these in your `.bash_secrets` / `.zsh_secrets`.

## Windows

On Windows, run `install.sh` from Git Bash. Or copy the PowerShell profile manually:

```powershell
Copy-Item .\windows\Microsoft.PowerShell_profile.ps1 $PROFILE
```
