FROM python:3.11.7

WORKDIR /s3-upload

COPY . /s3-upload

EXPOSE 80

RUN pip install -r requirments.txt && \
    mkdir /s3-upload/data

VOLUME /s3-upload/data

CMD ["fastapi", "run", "main.py", "--port", "80"]