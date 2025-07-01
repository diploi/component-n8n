FROM node:22-alpine AS base

ARG FOLDER=/app

FROM base AS deps
RUN apk add --no-cache libc6-compat

COPY . /app
WORKDIR ${FOLDER}

RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i --frozen-lockfile; \
  else echo "Lockfile not found." && exit 1; \
  fi

RUN mkdir -p node_modules

FROM base AS builder
COPY . /app
WORKDIR ${FOLDER}
COPY --from=deps ${FOLDER}/node_modules ./node_modules

FROM base AS runner

COPY --from=builder --chown=1000:1000 /app /app
WORKDIR ${FOLDER}

USER 1000:1000

EXPOSE 5678

CMD ["npx","n8n"]