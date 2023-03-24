FROM python:3.11.2-alpine

WORKDIR /myapp


RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add --no-cache mariadb-dev


COPY requirements.txt /myapp/

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

RUN apk del build-deps

COPY . /myapp


EXPOSE 9000