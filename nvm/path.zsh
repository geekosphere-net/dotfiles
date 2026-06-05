: ${NVM_DIR:="$HOME/.nvm"}

# Lazy-load nvm — initializes on first use to avoid ~300ms startup cost.
# Switch to fnm (brew install fnm) if you need .nvmrc auto-switching.
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    nvm()  { unfunction nvm node npm npx; source "$NVM_DIR/nvm.sh"; nvm "$@"; }
    node() { unfunction nvm node npm npx; source "$NVM_DIR/nvm.sh"; node "$@"; }
    npm()  { unfunction nvm node npm npx; source "$NVM_DIR/nvm.sh"; npm "$@"; }
    npx()  { unfunction nvm node npm npx; source "$NVM_DIR/nvm.sh"; npx "$@"; }
fi
