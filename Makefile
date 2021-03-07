.DEFAULT_GOAL := help



.PHONY: help
help:
	@echo "Usage: "
	@echo "make	generate-login:		...	generate login proto"
	@echo "make	clean-login:		...	clean login proto generated files"
	@echo ""


${PROTOC_GEN_SWIFT}: protoc-gen-swift

${PROTOC_GEN_GRPC_SWIFT}:protoc-gen-grpc-swift


%.pb.swift: %.proto ${PROTOC_GEN_SWIFT}
	protoc $< \
		--proto_path=$(dir $<) \
		--plugin=${PROTOC_GEN_SWIFT} \
		--swift_opt=Visibility=Public \
		--swift_out=$(dir $<)

%.grpc.swift: %.proto ${PROTOC_GEN_GRPC_SWIFT}
	protoc $< \
		--proto_path=$(dir $<) \
		--plugin=${PROTOC_GEN_GRPC_SWIFT} \
		--grpc-swift_opt=Visibility=Public \
		--grpc-swift_out=$(dir $<)

LOGIN_PROTO=./Jeak/Models/login.proto

# 把.proto转换为pb.swift
LOGIN_PROTO_PB=$(LOGIN_PROTO:.proto=.pb.swift)

# 把.proto转换为.grpc.swift
LOGIN_PROTO_GRPC=$(LOGIN_PROTO:.proto=.grpc.swift)

# Generates protobufs and gRPC client and server for the Jeak
.PHONY:
generate-login: ${LOGIN_PROTO_PB} ${LOGIN_PROTO_GRPC}

.PHONY:
clean-login:
	rm -rf ./Jeak/Models/*.grpc.swift
	rm -rf ./Jeak/Models/*.pb.swift
