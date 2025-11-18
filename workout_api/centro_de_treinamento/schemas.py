from typing import Annotated
from pydantic import Field
from workout_api.contrib.schema import BaseSchema


class CentroTreinamento(BaseSchema):
    nome: Annotated[str, Field(
        description="Nome do Centro de treinamento",
        example="CT King",
        max_length=20
    )]
    endenreco: Annotated[str, Field(
        description="Endenreço do Centro de treinamento",
        example="Rua X, Q02",
        max_length=60
    )]
    proprietario: Annotated[str, Field(
        description="Nome do Proprietario do treinamento",
        example="Marcos",
        max_length=30
    )]
