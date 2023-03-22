#######################################################################################
FROM alpine AS utils
#######################################################################################
# Create the user and group files that will be used in the running container to
# run the process as an unprivileged user.
RUN mkdir /user && \
  echo 'nobody:x:65534:65534:nobody:/:' > /user/passwd && \
  echo 'nobody:x:65534:' > /user/group

#######################################################################################
FROM node:16-alpine AS builder
#######################################################################################
ARG APP_NAME
WORKDIR /app
COPY . .

ENV NODE_ENV production

RUN npm i -g pnpm
RUN npx nx build $APP_NAME --configuration=production --generatePackageJson

#######################################################################################
FROM node:16-alpine AS final
#######################################################################################
ARG PORT
ARG APP_NAME

# Import the user and group files from the first stage.
COPY --from=utils /user/group /user/passwd /etc/

WORKDIR /app
COPY --from=builder /app/dist/apps/$APP_NAME .

ENV NODE_ENV production

RUN npm i pnpm -g
# install requird deps
RUN pnpm i --prod

EXPOSE $PORT

# Perform any further action as an unprivileged user.
USER nobody:nobody

ARG heapSize=1200
ENV heapSize=${heapSize}

ARG nodeArguments=''
ENV nodeArguments=${nodeArguments}

CMD node --max-old-space-size=${heapSize} ${nodeArguments} main.js
