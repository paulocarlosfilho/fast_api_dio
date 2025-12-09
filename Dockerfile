# Use a imagem oficial Python
FROM python:3.12-slim

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia e instala as dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação
COPY . .

# Comando para rodar a aplicação (isso será sobrescrito pelo docker-compose)
CMD uvicorn workout_api.main:app --host 0.0.0.0 --port 8000