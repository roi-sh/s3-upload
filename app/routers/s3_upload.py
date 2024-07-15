from uuid import uuid4
import magic
from pathlib import Path

import logging
from fastapi import APIRouter, UploadFile, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

from utilities.s3_upload_utilities import BytesConvertor, FileType
from utilities.s3_connections import S3Connection

router = APIRouter()

# add the static file
router.mount(
    "/static",
    StaticFiles(directory=Path(__file__).parent.parent.absolute() / "static"),
    name="static",
)

templates = Jinja2Templates(directory="templates")

bucket = S3Connection.S3.Bucket(S3Connection.AWS_BUCKET)


async def s3_upload(contents: bytes, Key: str):
    logging.info(f'uploading {Key} to s3')
    bucket.put_object(Key=Key, Body=contents)


@router.post('/upload', tags=["upload"])
async def upload(request: Request, file: UploadFile = None):  # | None = None
    if not file:
        message = "no file found"
        return templates.TemplateResponse(
            "main.html", {"request": request, "message": message}
        )
    contents = await file.read()
    size = len(contents)

    if not BytesConvertor.MIN_MB < size <= BytesConvertor.MAX_MB * BytesConvertor.MB:
        message = "supported file size is 0 - 1 MB"
        return templates.TemplateResponse(
            "main.html", {"request": request, "message": message}
        )
    file_type = magic.from_buffer(buffer=contents, mime=True)
    if file_type not in FileType.SUPPORTED_FILE_TYPES:
        message = f"Unsupported file type {file_type}. Supported types are {FileType.SUPPORTED_FILE_TYPES}"
        return templates.TemplateResponse(
            "main.html", {"request": request, "message": message}
        )

    await s3_upload(contents=contents, Key=f'{uuid4()}.{FileType.SUPPORTED_FILE_TYPES[file_type]}')
    return templates.TemplateResponse(
        "main.html", {"request": request}
    )
