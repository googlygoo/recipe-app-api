FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
       gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

RUN pip install -r /requirements.txt

RUN apk del .tmp-build-deps

RUN mkdir /app
COPY ./app /app

WORKDIR /app

RUN adduser -D www-data
USER www-data

# RUN mkdir -p /vol/web/media
# RUN mkdir -p /vol/web/static
# RUN chown -R www-data:www-data /vol/
# RUN chmod -R 755 /vol/web
