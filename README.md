# Athos5BD
Este é repositório base da API do 5semestre do curso de Banco de Dados.

## 🚀 Primeiros Passos

Após clonar este repositório, é necessário rodar um script de configuração inicial que prepara o ambiente de desenvolvimento.

Esse script irá:
- Atualizar e inicializar os **submódulos** (`docs`, `server`).
- Configurar o **template de commits**.
- Instalar o **hook de validação** de mensagens de commit.

Após execução do passo a passo a seguir, o projeto já estará devidamente configurado.  
Acesse o submódulo necessário e continue os trabalhos.

### Passo a passo

1. Clone o repositório:
```bash
    git clone https://github.com/AthosFatecSjc/Athos.git
    cd Athos
```

2. Dê permissão de execução para o script (se ainda não tiver):
```bash
    chmod +x getting-started.sh
```

3. Execute o script:  
Não se preocupe, o script irá tratar a questão do protocolo (SSH | HTTPS).
```bash
    ./getting-started.sh
```

4. Confirme que os submódulos foram baixados corretamente:
```bash
    git submodule status
```

