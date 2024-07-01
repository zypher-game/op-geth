FROM rust:1.73.0-buster AS builder

RUN wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.19.3.linux-amd64.tar.gz
ENV PATH="$PATH:/usr/local/go/bin"

WORKDIR /build
ADD . .

RUN make geth

FROM debian:buster
RUN apt-get update -y
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates

WORKDIR /app
COPY --from=builder /build/build/bin/geth .
Add start.sh start.sh
RUN chmod +x start.sh

CMD ["./start.sh"]
