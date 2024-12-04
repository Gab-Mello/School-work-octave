from pydantic import BaseModel

class Data(BaseModel):
    I_SC: float
    V_dc: float
    R_sh: float
    T: float
    J_0: float
