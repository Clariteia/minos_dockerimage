FROM python:3.9-slim-buster as build

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y curl git

# Install and setup poetry
RUN pip install -U pip && curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="${PATH}:/root/.local/bin"

WORKDIR /microservice
ENV PYTHONPATH=/microservice:$PYTHONPATH

RUN poetry config virtualenvs.in-project true
