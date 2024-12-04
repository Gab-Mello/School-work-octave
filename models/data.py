from pydantic import BaseModel

class Data(BaseModel):
    I_SC: float
    V_dc: float
