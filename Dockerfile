FROM python:3.6-alpine as tester

LABEL maintainer="Milad B"

ENV PYTHONUNBUFFERED 1

RUN mkdir /config /src /docker

ADD config/requirements.pip /config/

COPY src /src 

ADD entrypoint.sh /docker/

RUN set -ex \
    && apk add --no-cache --virtual .crypto-rundeps \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
	libressl2.7-libcrypto \ 
	&& apk add --no-cache curl \
    && pip install -U pip \
    && LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "pip install --no-cache-dir -r /config/requirements.pip"

WORKDIR /src

RUN python manage.py test

FROM python:3.6-alpine as builder

LABEL maintainer="Milad B"

ENV PYTHONUNBUFFERED 1

RUN mkdir /config /src /docker

ADD config/requirements.pip /config/

COPY src /src 

ADD entrypoint.sh /docker/

RUN set -ex \
    && apk add --no-cache --virtual .crypto-rundeps \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
	libressl2.7-libcrypto \ 
	&& apk add --no-cache curl \
    && pip install -U pip \
    && LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "pip install --no-cache-dir -r /config/requirements.pip"

WORKDIR /src

ENTRYPOINT ["/docker/entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8000 || exit 1

# using sh -c to allow for variable expansion
CMD ["sh", "-c", "gunicorn greetings.wsgi:application --log-level=$LOG_LEVEL --reload -b 0.0.0.0:8000"]