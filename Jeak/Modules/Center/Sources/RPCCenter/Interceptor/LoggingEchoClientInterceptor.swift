//
//  LoggingEchoClientInterceptor.swift
//  Center
//
//  Created by Flutter on 2021/5/26.
//

import Foundation
import GRPC
import NIOHPACK
import NIO


class LoggingEchoClientInterceptor<Request, Response>: ClientInterceptor<Request, Response> {
    
  override func send(
    _ part: GRPCClientRequestPart<Request>,
    promise: EventLoopPromise<Void>?,
    context: ClientInterceptorContext<Request, Response>
  ) {
    switch part {
    case let .metadata(headers):
        context.logger.info("> Starting '\(context.path)' RPC, headers: '\(prettify(headers))'")
    case let .message(request, _):
        context.logger.info("> Sending request with '\(request)'")
    case .end:
        context.logger.info("> Closing request stream")
    }
    context.send(part, promise: promise)
  }

  override func receive(
    _ part: GRPCClientResponsePart<Response>,
    context: ClientInterceptorContext<Request, Response>
  ) {
    switch part {
    case let .metadata(headers):
        context.logger.info("< Received headers: '\(prettify(headers))'")
    case let .message(response):
        context.logger.info("< Received response with '\(response)'")
    case let .end(status, trailers):
        context.logger.info("< Response stream closed with status: '\(status)' and trailers:'\(prettify(trailers))'")
    }
    context.receive(part)
  }
}

extension LoggingEchoClientInterceptor{
    func prettify(_ headers: HPACKHeaders) -> String {
        "[" + headers.map { name, value, _ in "'\(name)': '\(value)'" }
            .joined(separator: ", ") + "]"
    }
}


