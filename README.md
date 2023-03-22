# Backend

## Development server

### Local

Run `nx serve PACS` for a dev server. Navigate to http://localhost:<port>/. The app will automatically reload if you change any of the source files.

### Docker

Build and start: `docker compose up --build`
Start only: `docker compose up`

## Understand this workspace

Run `nx graph` to see a diagram of the dependencies of the projects.

## Remote caching

Run `npx nx connect-to-nx-cloud` to enable [remote caching](https://nx.app) and make CI faster.

## Further help

Visit the [Nx Documentation](https://nx.dev) to learn more.

## Developer

### Notes

- Apps configure dependency injection and wire up libraries. They should not contain any components, services, or business logic.
- Libs contain services, components, utilities, etc. They have well-defined public API.

### NX generate util

Basic syntax: `npx nx generate <plugin name>:<generator name> <default option> <others option>`

#### Generate application in apps

Node: `npx nx generate @nrwl/node:app <app name>`
Nestjs: `npx nx generate @nrwl/nest:app <app name>`

#### Generate lib in libs

Node: `npx nx generate @nrwl/node:lib <lib name> --buildable`
Nestjs: `npx nx generate @nrwl/nest:lib <lib name> --buildable`
