from fastapi import FastAPI
from workout_api.routers import api_router

# Instância da aplicação
app = FastAPI(title="WorkoutApi")
app.include_router(api_router)
