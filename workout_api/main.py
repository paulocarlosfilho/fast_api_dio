from fastapi import FastAPI


# Instância da aplicação
app = FastAPI(title = "WorkoutApi")


if __name__ == 'main':
    import uvicorn

    uvicorn.run('main:app', host='0.0.0.0', port=8000, log_level='info', reload=True)