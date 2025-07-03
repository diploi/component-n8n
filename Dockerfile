FROM node:22-alpine AS base

ARG FOLDER=/app

FROM base AS deps
RUN apk add --no-cache libc6-compat

COPY . /app
WORKDIR ${FOLDER}

RUN npm install

RUN mkdir -p node_modules

FROM base AS builder
COPY . /app
WORKDIR ${FOLDER}
COPY --from=deps ${FOLDER}/node_modules ./node_modules

FROM base AS runner

COPY --from=builder /app /app

RUN chown -R 1000:1000 /app

WORKDIR ${FOLDER}

USER 1000:1000

EXPOSE 5678

CMD ["npx","n8n"]