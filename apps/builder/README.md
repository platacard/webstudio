# Builder app

### How to build and run the app:

Install deps:\
```pnpm i --frozen-lockfile --filter @webstudio-is/builder```

build app: 
```
cd apps/builder
pnpm build
```

Run app:\
```pnpm start```

### Docker

Build docker image:\
```docker build --no-cache -t builder -f Dockerfile .```

Run container:\
```docker run --rm -p 13100:13100 builder:latest```