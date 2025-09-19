####### Vamos trabalhar em cima deste #######
MAIN_REPO_ROOT=$(git rev-parse --show-toplevel)
GIT_DIR=$(git rev-parse --git-dir)

# Acessa branch de desenvolvimento
git checkout develop &&

# Identifica qual protocolo de conexão o usuário está utilizando
# Também configura os submodulos para seguirem o mesmo
REMOTE_URL=$(git config --get remote.origin.url)
if [[ "$REMOTE_URL" == git@* ]]; then
    echo "Using SSH, rewriting submodules..."
    git submodule set-url docs git@github.com:AthosFatecSjc/docs.git
    git submodule set-url server git@github.com:AthosFatecSjc/server.git
else
    echo "Using HTTPS, rewriting submodules..."
    git submodule set-url docs https://github.com/AthosFatecSjc/docs.git
    git submodule set-url server https://github.com/AthosFatecSjc/server.git
fi

# Inicia/ atualiza os submodulos
git submodule sync --recursive &&
git submodule update --init --recursive &&

# Cria a pasta hooks e baixa o commit-msg
(
    mkdir -p $GIT_DIR/hooks &&
    curl -Lo "$GIT_DIR/hooks/commit-msg" \
        https://raw.githubusercontent.com/AthosFatecSjc/docs/f4bc403336967deb19f887badd4eb69127e61bec/template/hooks/commit-msg
) &&

# Cria a pasta template e baixa o template de commit
(
    mkdir -p $GIT_DIR/template &&
    curl -Lo "$GIT_DIR/template/.commit-template.txt" \
        https://raw.githubusercontent.com/AthosFatecSjc/docs/f4bc403336967deb19f887badd4eb69127e61bec/template/.commit-template.txt
) &&

# Configura o template de commit, o commit-msg e os hooks no repositório principal
(
    git config commit.template "$MAIN_REPO_ROOT/$GIT_DIR/template/.commit-template.txt" &&
    chmod +x "$MAIN_REPO_ROOT/$GIT_DIR/hooks/commit-msg" &&
    git config core.hooksPath "$MAIN_REPO_ROOT/$GIT_DIR/hooks" 
) &&

# Configura o template de commit, o commit-msg e os hooks nos submodulos
git submodule foreach "
(
    git config commit.template '$MAIN_REPO_ROOT/$GIT_DIR/template/.commit-template.txt' &&
    chmod +x '$MAIN_REPO_ROOT/$GIT_DIR/hooks/commit-msg' &&
    git config core.hooksPath '$MAIN_REPO_ROOT/$GIT_DIR/hooks'
)"
