# dotfiles

Personal shell environment for WSL/Linux VMs. Built on [oh-my-zsh](https://ohmyz.sh) with a modular topic-based structure.

---

## Fresh VM setup

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/geekosphere-net/dotfiles/master/configure.sh)"
```

This single command will:
1. Install core apt packages (`zsh`, `vim`, `git`, `curl`, `wget`, `figlet`, `unzip`, etc.)
2. Install oh-my-zsh + custom plugins (autosuggestions, syntax-highlighting, completions)
3. Install dircolors solarized dark
4. Clone this repo to `~/.dotfiles`
5. Create all symlinks (`~/.zshrc`, `~/.vimrc`, `~/.tmux.conf`, etc.)
6. Install vim plugins (pathogen + solarized theme)
7. Set zsh as the default shell

Log out and back in after running for zsh to take effect.

---

## VM-local configuration

Two files are loaded by `.zshrc` but are **never committed** to this repo — create them manually on each VM as needed:

**`~/.zshrc.local.pre`** — loaded before oh-my-zsh. Use for PATH or env vars that plugins may depend on.
```zsh
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
```

**`~/.zshrc.local.post`** — loaded last. Use for machine-specific overrides and secrets (API keys, tokens).
```zsh
export SOME_API_KEY=...
eval "$(some-tool shellenv)"
```

---

## Optional tool installs

Run individually as needed — these are **not** run by `configure.sh`:

| Script | What it installs |
|---|---|
| `~/.dotfiles/aws/install.sh` | AWS CLI v2 (official curl installer, arch-aware) |
| `~/.dotfiles/nvm/install.sh` | nvm — Node Version Manager (latest version) |
| `~/.dotfiles/git/install.sh` | git-flow AVH edition |
| `~/.dotfiles/yq/install.sh` | yq — mikefarah/yq YAML processor binary |
| `~/.dotfiles/ibmcloud/install.sh` | IBM Cloud CLI (`ibmcloud`) |

Or run all of them at once:
```bash
~/.dotfiles/script/install
```

> Note: `script/install` runs **every** `install.sh` in the repo including bind. Run individually if you only want specific tools.

---

## How it works

### Symlinks

`script/bootstrap` finds every `*.symlink` file and links it to `~/.<name>`:

| Repo file | Symlink created |
|---|---|
| `zsh/zshrc.symlink` | `~/.zshrc` |
| `zsh/zlogout.symlink` | `~/.zlogout` |
| `vim/vimrc.symlink` | `~/.vimrc` |
| `tmux/tmux.conf.symlink` | `~/.tmux.conf` |
| `git/gitconfig.local.symlink` | `~/.gitconfig.local` |
| `ssh.symlink/` | `~/.ssh/` |

### Zsh loading order

`.zshrc` sources all `*.zsh` files under `~/.dotfiles/` in three passes:

1. `path.zsh` files — extend `$PATH`
2. Everything else — aliases, config, functions
3. `completion.zsh` files — loaded last, after oh-my-zsh initializes completions

### Topic structure

Each tool gets its own directory. Drop files in with these names and they're auto-loaded:

| Filename | Purpose |
|---|---|
| `path.zsh` | PATH extensions, loaded first |
| `config.zsh` | Exports, options, settings |
| `alias.zsh` | Aliases and functions |
| `completion.zsh` | Completion scripts, loaded last |
| `install.sh` | Install script for the tool |
| `*.symlink` | Symlinked to `~/.<name>` by bootstrap |

---

## Plugins

Oh-my-zsh plugins enabled:

| Plugin | Type | Notes |
|---|---|---|
| `git` | bundled | Git aliases and prompt info |
| `git-flow-avh` | bundled | git-flow AVH edition support |
| `helm` | bundled | Helm completions |
| `docker` | bundled | Docker completions |
| `kubectl` | bundled | kubectl completions + aliases |
| `aws` | bundled | AWS CLI v2 completions |
| `gcloud` | bundled | gcloud completions |
| `golang` | bundled | Go environment helpers |
| `zsh-autosuggestions` | custom | Fish-style inline suggestions |
| `zsh-syntax-highlighting` | custom | Command syntax colouring |
| `zsh-completions` | custom | Extended completion library |
| `zsh-navigation-tools` | bundled | History and directory navigation |

Custom plugins are cloned to `~/.oh-my-zsh/custom/plugins/` by `configure.sh`.

---

## Theme

Uses the **fishy** oh-my-zsh theme with a custom prompt overlay:
- `PROMPT` — current directory (last few segments, truncated) with exit status colour
- `RPROMPT` — git branch + status

---

## WSL notes

- `BROWSER` should be set to `wslview` in `~/.zshrc.local.pre`
- WSL lib path (`/usr/lib/wsl/lib`) should be prepended in `~/.zshrc.local.post`
- VMware shared folder symlinks (`/mnt/c`, `/mnt/d`) are created automatically by `configure.sh` if detected
