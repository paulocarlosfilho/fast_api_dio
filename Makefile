run:
	@uvicorn workout_api.main:app --reload

create-migration:
	@PYTHONPATH=$PYUTHONPATH:$(pwd) alembic revision --autogenerate -m $(d)

run-migration:
	@PYTHONPATH=$PYUTHONPATH:$(pwd) alembic upgrade head