FROM ubuntu:18.04

# install base lib
RUN apt-get update && apt-get install -y \
    wget pkg-config git python build-essential zlib1g-dev libssl-dev libsasl2-dev libzstd-dev

# make librdkafka
RUN git clone https://github.com/edenhill/librdkafka.git && cd ./librdkafka && git checkout v1.3.0; \
    ./configure --enable-static; \
    make && make install

# install golang
RUN wget -O go.tgz https://studygolang.com/dl/golang/go1.14.2.linux-amd64.tar.gz; \
    tar -C /usr/local -xzf go.tgz; \
    rm go.tgz; \
    export PATH="/usr/local/go/bin:$PATH"; \
    go version
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"