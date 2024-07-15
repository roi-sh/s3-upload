import boto3
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    AWS_BUCKET: str
    AWS_ACCESS_KEY_ID: str
    AWS_SECRET_ACCESS_KEY: str
    REGION_NAME: str


settings = Settings()


class S3Connection:
    AWS_BUCKET = settings.AWS_BUCKET

    S3 = boto3.resource('s3',
                        aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
                        aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
                        region_name=settings.REGION_NAME
                        )
    BUCKET = S3.Bucket(AWS_BUCKET)
