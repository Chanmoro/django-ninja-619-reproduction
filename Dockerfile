FROM python:3.10.9-slim

RUN set -ex \
  && apt-get update \
  && apt-get install -y \
     build-essential \
  && rm -rf /var/lib/apt/lists/*

RUN set -ex \
  && apt-get update \
  && apt-get install -y \
     libpq-dev \
  && rm -rf /var/lib/apt/lists/*

RUN pip install poetry

WORKDIR /app
COPY ./pyproject.toml /app/pyproject.toml
COPY ./poetry.lock /app/poetry.lock

RUN poetry install

COPY . /app/.
