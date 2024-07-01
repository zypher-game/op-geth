FROM rust:1.79-bookworm AS rust-builder

WORKDIR /build
ADD . .

RUN cargo build --release

FROM golang:1.22-bookworm AS go-builder

COPY --from=rust-builder /build /build
WORKDIR /build

RUN go run build/ci.go install ./cmd/geth

FROM debian:bookworm
RUN apt-get update -y
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates

WORKDIR /app
COPY --from=go-builder /build/build/bin/geth .
Add start.sh start.sh
RUN chmod +x start.sh

CMD ["./start.sh"]
