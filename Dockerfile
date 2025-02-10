FROM node:22.13.1-alpine AS base

WORKDIR /app
# note: all these files need because of pnpm workspace 
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY packages ./packages
COPY patches ./patches

COPY apps/builder/build ./apps/builder/build
COPY apps/builder/package.json ./apps/builder/package.json

FROM base AS prod-deps
RUN npm i -g pnpm@9.14.4
RUN pnpm i --prod --frozen-lockfile --filter @webstudio-is/builder

FROM node:22.13.1-alpine
WORKDIR /app/apps/builder

COPY --from=base /app/apps/builder/build ./build

COPY --from=prod-deps /app/node_modules ../../node_modules
COPY --from=prod-deps /app/apps/builder/node_modules ./node_modules

EXPOSE 13100
CMD ["npx", "remix-serve", "build/server/index.js"]