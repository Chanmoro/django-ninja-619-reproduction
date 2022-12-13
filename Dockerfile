FROM python:3.10.9-slim

RUN set -ex \
  && apt-get update \
  && apt-get install -y \
#     git \
#     wget \
#     curl \
     build-essential \
  && rm -rf /var/lib/apt/lists/*

## Add postgres repository
#RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list
#RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
#
RUN set -ex \
  && apt-get update \
  && apt-get install -y \
     libpq-dev \
  && rm -rf /var/lib/apt/lists/*

#ADD ./docker/bashrc /root/.bashrc

RUN pip install poetry

WORKDIR /app
COPY ./pyproject.toml /app/pyproject.toml
COPY ./poetry.lock /app/poetry.lock

RUN poetry install

COPY . /app/.
