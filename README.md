<img alt="icon" src=".diploi/icon.svg" width="32">

# n8n Component for Diploi

[![launch with diploi badge](https://diploi.com/launch.svg)](https://diploi.com/component/deno)
[![component on diploi badge](https://diploi.com/component.svg)](https://diploi.com/component/deno)
[![latest tag badge](https://badgen.net/github/tag/diploi/component-n8n)](https://diploi.com/component/n8n)

A generic n8n component ready to be used for automating tasks.

This component was kickstarted running
`npm install n8n`
and it uses **PostgreSQL** by default.

Uses the official [node:22-alpine](https://hub.docker.com/_/node/) Docker image and **n8n 1.99.1**

## Operation

### Development

Will run first
`apk add --no-cache libc6-compat`
and next
`npm install`
when component is first initialized, after that the image runs `npx n8n` when the deployment is started.

### Production

Will build a production ready image. Image runs
`apk add --no-cache libc6-compat`
to install all necessary dependencies and
`npm ci` to install the necessary packages, to then run
`npx n8n`to start the deployment

#### IMPORTANT
- This component is not intended for n8n custom development, because it uses n8n as a node_module

## Links

- [n8n docs](https://docs.n8n.io/)
