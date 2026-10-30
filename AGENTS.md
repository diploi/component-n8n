# n8n

[n8n](https://docs.n8n.io/) 2.45, the workflow automation tool, from the official `n8nio/n8n` image as it is
(`images[].image` in `diploi.yaml`; there is no Dockerfile).

## This component

- There is no code here. Workflows, credentials, users and executions live in n8n's own PostgreSQL database
  (`DB_POSTGRESDB_DATABASE`, default `n8n`, on the `postgres` add-on), not in this repository. Change them in n8n's
  editor or through n8n's MCP server, never by editing that database.
- Configuration is environment variables: the deployment's **Setup** tab (`README.md` lists its fields) and its
  **Environment** tab. Every `N8N_*` and `DB_*` variable is an
  [n8n setting](https://docs.n8n.io/hosting/configuration/environment-variables/). A change takes effect when the
  component restarts.
- Serves on port **5678** in every stage. Every stage runs the same image. The pod has a second container, `setup`,
  which creates n8n's database, sets n8n up on its first start and then waits. Its log
  (`diploi logs <identifier> -c setup`) says what the setup did.
- Login is `INITIAL_ADMIN_EMAIL` with `INITIAL_ADMIN_PASSWORD`, under **Admin login** in the Setup tab. Both are only
  read on the first start. The password is a secret: point the user to the Setup tab, never print it.
- Never change `N8N_ENCRYPTION_KEY`: n8n could no longer read the credentials it encrypted with it.
- n8n's MCP server is among your tools when this component is in the project. It acts as n8n's owner. Prefer its
  tools to n8n's REST API, and follow the instructions it sends when it connects. Its tools only read, change or run
  a workflow that is available in MCP: new ones are, and the user switches an older one on in its settings. Do not
  change n8n's settings, users or credentials unless the user asks for it.
- The credential **Diploi AI** (type Anthropic) points the Anthropic nodes, such as the Anthropic Chat Model of an AI
  Agent, at the Diploi AI proxy, billed to the user's Diploi account. Use it for Claude models instead of asking for an
  API key.
- n8n Assistant, n8n's own AI chat, is switched off: it needs a code sandbox, which this component does not set up.
  Build and fix workflows through the MCP server instead.
- Code nodes cannot read environment variables (`N8N_BLOCK_ENV_ACCESS_IN_NODE` is on by default). Put secrets in
  credentials.

## Diploi

AI-oriented platform docs: <https://docs.diploi.com/llms-full.txt>. Do not speculate about undocumented Diploi
behavior, link to the docs instead.

- Env vars imported from other components are live in the container. List them with `printenv` instead of
  guessing, and never print secret values.
- `diploi logs <identifier> --follow` streams logs. `diploi exec <identifier> -- <command>` runs a command in
  another component's container. The `n8n` CLI is in this component's image.
