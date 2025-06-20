FROM docker.n8n.io/n8nio/n8n

ARG FOLDER=/app

WORKDIR ${FOLDER}

COPY . /app

RUN chown -R 1000:1000 /app

RUN groupadd -g 1000 devgroup && \
    useradd -u 1000 -g 1000 -m devuser

USER devuser

EXPOSE 5678

CMD ["n8n"]
