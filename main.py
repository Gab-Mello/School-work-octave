from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from controllers import octaveController
import uvicorn

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")
app.include_router(octaveController.router)

from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
