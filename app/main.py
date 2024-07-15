from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from pathlib import Path

from routers import s3_upload, album

app = FastAPI()

app.mount(
    "/static",
    StaticFiles(directory=Path(__file__).parent.parent.absolute() / "s3-upload/static"),
    name="static",
)

templates = Jinja2Templates(directory="templates")


@app.get('/', response_class=HTMLResponse, tags=["login_page"])
async def root(request: Request):
    return templates.TemplateResponse(
        "main.html", {"request": request}
    )

app.include_router(s3_upload.router)
app.include_router(album.router)

# run uvicorn main:app --reload --port=8000 --host=0.0.0.0
# if __name__ == '__main__':
#     uvicorn.run(app='main:app', reload=True, host="localhost")
