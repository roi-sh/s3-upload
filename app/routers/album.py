from pathlib import Path
from fastapi import APIRouter, Request
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from utilities.s3_connections import S3Connection

router = APIRouter()

# add the static file
router.mount(
    "/static",
    StaticFiles(directory=Path(__file__).parent.parent.absolute() / "static"),
    name="static",
)

templates = Jinja2Templates(directory="templates")


@router.get('/album', response_class=HTMLResponse, tags=["album"])
async def album(request: Request):  # | None = None
    bucket = S3Connection.S3.Bucket(S3Connection.AWS_BUCKET)
    list_of_url = []
    for obj in bucket.objects.all():
        print(obj)
        url = bucket.meta.client.generate_presigned_url(
            'get_object',
            Params={'Bucket': S3Connection.AWS_BUCKET, 'Key': obj.key},
            ExpiresIn=36
        )
        print(url)
        list_of_url.append(url)
    return templates.TemplateResponse(
        "album.html", {"request": request, "list_of_url": list_of_url}
    )
