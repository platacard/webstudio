# Builder app

## How to build and run the app:
Install pnpm:\
`npm i -g pnpm@latest`
---
### Dev mode
Isntall deps:\
`pnpm i`

Run:\
`pnpm run dev`
---
### Prod mode
Install runtime deps (optional: don't need if you installed all deps previously):\
`pnpm i --frozen-lockfile --prod --filter @webstudio-is/builder`

Build app: 
```
cd apps/builder
pnpm run build
```

Run app:\
`pnpm run start`
---
### Docker

Build docker image:\
`docker build --no-cache -t builder -f Dockerfile .`

Run container:\
`docker run --rm -p 13100:13100 builder:latest`