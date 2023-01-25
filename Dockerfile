FROM golang:1.19-alpine as compiler

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o /super-config


FROM scratch
WORKDIR /
COPY --from=compiler /super-config /

EXPOSE 80

LABEL org.opencontainers.image.title="Superconfig"
LABEL org.opencontainers.image.name="super-config"
LABEL org.opencontainers.image.version="v1.6.0"
LABEL org.opencontainers.image.description="Listens nats.io topic and generates config"
LABEL org.opencontainers.image.base.name="golang:1.19-alpine"
LABEL org.opencontainers.image.source="https://github.com/agios-ierodromos/super-config"
LABEL org.opencontainers.image.url="https://github.com/agios-ierodromos/super-config"
LABEL org.opencontainers.image.documentation="https://github.com/agios-ierodromos/super-config/blob/main/README.md"
LABEL org.opencontainers.image.authors="alexandre.marcondes@gmail.com"
LABEL org.opencontainers.image.licenses="Apache-2.0"

ENTRYPOINT ["/super-config"]

