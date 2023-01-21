FROM golang:1.19-alpine AS go-build

WORKDIR /portfolio-site

COPY src/go.mod .
COPY src/go.sum .
RUN go mod download

COPY ./src .

RUN go build

FROM node:19.2.0 AS node-build

WORKDIR /portfolio-site
COPY --from=go-build /portfolio-site ./

WORKDIR /portfolio-site/frontend

RUN npm install && npm run build

FROM golang:1.19-alpine

WORKDIR /app

COPY --from=go-build \
    /portfolio-site \
    /app

COPY --from=node-build \
    /portfolio-site/build \
    /app/build/

CMD ["/app//portfolio-site"]