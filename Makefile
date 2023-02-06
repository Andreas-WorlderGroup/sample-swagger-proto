clean:
	rm -rf ./pkg/*
	rm -rf ./api/*.lock

build:
	buf build --path api/financial_dashboard_internal.proto
	cd api && buf mod update

generate: clean build
	. resource/.gopath && cd api && buf generate
	. resource/.gopath && cd pkg && protoc-go-inject-tag -input="*.pb.go"

install:
	. resource/.gopath && go install \
		google.golang.org/protobuf/cmd/protoc-gen-go \
		google.golang.org/grpc/cmd/protoc-gen-go-grpc \
		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
		github.com/bufbuild/buf/cmd/buf \
		github.com/favadi/protoc-go-inject-tag \
		github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
