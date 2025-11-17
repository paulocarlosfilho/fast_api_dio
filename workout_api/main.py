from fastapi import FastAPI

# Instância da aplicação
app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "FastAPI Workout API"}