from fastapi import APIRouter
from oct2py import Oct2Py
from oct2py import octave
from services import octaveService
# Inicializar a sessão Octave

router = APIRouter()

@router.get("/generate-graphs")
def generate_graphs():
    octaveService.generateGraphs()
    return ({'ok': 'deu certo!!'})