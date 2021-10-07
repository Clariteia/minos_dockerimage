FROM python:3.9-slim-buster as build

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

RUN apt-get update \
    && apt-get install -y curl git

# Install and setup poetry
RUN pip install -U pip \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
ENV PATH="${PATH}:/root/.local/bin"

WORKDIR /microservice
ENV PYTHONPATH=/microservice:$PYTHONPATH

COPY pyproject.toml ./
RUN poetry config virtualenvs.in-project true \
  && poetry install --no-interaction --no-ansi \
  && rm -f pyproject.toml poetry.lock
