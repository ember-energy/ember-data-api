FROM python:3.11
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV API_HOME=/opt/api
ENV PORT=8000
RUN mkdir -p ${API_HOME}

COPY . ${API_HOME}
WORKDIR ${API_HOME}

RUN uv venv
RUN uv pip install -r requirements.txt

EXPOSE ${PORT}
CMD [ "uv", "run", "datasette", ".", "-h", "0.0.0.0", "-p", ${PORT}, "--metadata", "metadata.json", "--cors", "--setting", "settings.json" ]
