from uuid import uuid4
from fastapi import APIRouter, Body, HTTPException, status
from sqlalchemy.future import select
from workout_api.categorias.models import CategoriaModel
from workout_api.contrib.repository.dependencies import DatabaseDependency
from workout_api.categorias.schemas import CategoriaIn, CategoriaOut

router = APIRouter()


@router.post(
    '/',
    summary='Criar uma nova Categoria',
    status_code=status.HTTP_201_CREATED,
    response_model=CategoriaOut
)
async def post(
    db_session: DatabaseDependency,
    categoria_in: CategoriaIn = Body(...)
) -> CategoriaOut:
    query = select(CategoriaModel).filter(
        CategoriaModel.nome == categoria_in.nome)
    result = await db_session.execute(query)
    categoria_existente = result.scalars().first()
    if categoria_existente:
        raise HTTPException(
            status_code=status.HTTP_303_SEE_OTHER,
            detail=f'Já existe uma categoria cadastrada com o nome: {
                categoria_in.nome}'
        )
    categoria_out = CategoriaOut(id=uuid4(), **categoria_in.model_dump())
    categoria_model = CategoriaModel(**categoria_out.model_dump())
    db_session.add(categoria_model)
    await db_session.commit()

    return CategoriaOut.model_validate(categoria_model)


@router.get(
    '/',
    summary='Consultar todas as Categorias',
    status_code=status.HTTP_200_OK,
    response_model=list[CategoriaOut]
)
async def query(
    db_session: DatabaseDependency,
) -> list[CategoriaOut]:
    categorias: lista[CategoriaOut] = (
    await db_session.execute(select(CategoriaModel))).scalars().all()
    return categorias
