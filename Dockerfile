FROM golang:1.15

ENV GO111MODULE=on

RUN apt-get update
RUN apt-get install -y libpcap-dev \
&& rm -rf /var/lib/apt/lists/*

RUN export PATH="$PATH:$(go env GOPATH)/bin"

COPY . /go/src
WORKDIR /go/src

RUN go mod init redis-traffic-stats

RUN go build .

EXPOSE 9200

#RUN chmod +x  /go/src/redis-traffic-stats

#RUN cd /go/src

CMD ['/go/src/redis-traffic-stats --interface=eth0 --addr=0.0.0.0:9200 --password=pass  --debug=false -s=: -r="[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}" --max=150']
#CMD ["/bin/bash", "-lc", "/go/src/redis-traffic-stats", "--interface=eth0", "--addr=0.0.0.0:9200", "--password=pass", "--debug=false", "-s=:", "-r=\"[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}\"", "--max=150"]
