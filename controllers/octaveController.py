from fastapi import APIRouter
from oct2py import Oct2Py
from oct2py import octave
from services import octaveService
from models.data import Data

router = APIRouter()

@router.post("/generate-graphs")
def generate_graphs(data: Data):
    octaveService.generateGraphs(data)
    return ({'ok': 'it works!!'})