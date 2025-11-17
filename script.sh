#!/bin/bash

PACKAGE_DIR="workout_api"
APP_MODULE="${PACKAGE_DIR}.main:app"

echo "--- 1. PREPARAÇÃO E LIMPEZA INICIAL ---"
# 1.1 Limpa o ambiente virtual anterior (se existir)
poetry env remove --all 2>/dev/null

# 1.2 Remove o arquivo de configuração antigo se existir
rm -f pyproject.toml

# 1.3 Cria a estrutura de diretórios e arquivos de código
mkdir -p "$PACKAGE_DIR"
touch "$PACKAGE_DIR/__init__.py"
touch README.md

# 1.4 Adiciona o código básico no main.py
cat <<EOF > "$PACKAGE_DIR/main.py"
from fastapi import FastAPI

# Instância da aplicação
app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "FastAPI Workout API"}
EOF


echo "--- 2. INICIALIZAÇÃO POETRY (CRIA pyproject.toml) ---"
# 2.1 Força a criação do pyproject.toml com as respostas mínimas via comandos
# Aceita padrões, define autor e define a versão Python correta (>3.12)
poetry init 

echo "--- 3. INSTALANDO E CONFIGURANDO DEPENDÊNCIAS ---"
# 3.1 Adiciona e instala todas as dependências (FastAPI, Uvicorn, etc.)
# O 'add' garante que o ambiente virtual seja criado e populado.
poetry add fastapi uvicorn pydantic sqlalchemy || {
    echo "🚨 Erro ao adicionar dependências. O ambiente pode estar incompleto."
}

# 3.2 Força a instalação sem o root (para evitar o erro "No file/folder found for package")
poetry install --no-root


echo "--- 4. INICIANDO O SERVIDOR UVICORN ---"
echo "Acessando o módulo: $APP_MODULE"
echo "Servidor rodando em http://127.0.0.1:8000 (Ctrl+C para sair)"

# 4.1 Inicia o servidor Uvicorn no ambiente virtual
poetry run uvicorn workout_api.main:app --reload


#Ele ja instalado. Depois de ja ter feito tudo:
#Flake8 Black, import cost
uvicorn workout_api.main:app --reload