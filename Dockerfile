FROM node:22-alpine AS base

ARG FOLDER=/app

WORKDIR ${FOLDER}

COPY package*.json ./

RUN npm install

COPY . .

FROM node:22-alpine AS runner

ARG FOLDER=/app

WORKDIR ${FOLDER}

COPY --from=base ${FOLDER} ${FOLDER}

RUN chown -R 1000:1000 ${FOLDER}

USER 1000:1000

EXPOSE 5678

CMD ["npx","n8n"]