//
//  RPCService.swift
//  Center
//
//  Created by Flutter on 2021/3/9.
//

import Foundation
import GRPC
import NIO
import NIOSSL
//import LogMan
import Standard

public class RPCCenterBundle : BundleLoader {
    
}

open class RPCService {
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)

    private let name: String
    
    private(set) var connection: ClientConnection

//    let logger = Loggers[typeName]


    public init(name: String, host: String, port: Int, tls: Bool) {
        precondition(!name.isEmpty, "name should not be empty")
        self.name = name
        if tls {
    
            let cert = try! NIOSSLCertificate(bytes: .init(certPem.utf8), format: .pem)
            let builder: ClientConnection.Builder
            builder = ClientConnection.secure(group: group)
                .withTLS(trustRoots: .certificates([cert]))
                .withTLS(serverHostnameOverride: "djangoc.com")
            connection = builder.connect(host: host, port: port)

        }else {
            connection = ClientConnection.insecure(group: group).connect(host: host, port: port)
        }

    }


    deinit {
        try? group.syncShutdownGracefully()
    }
    
}

extension RPCService {
    func change(host: String, port: Int, tls: Bool) {
        do {
            try connection.close().wait()
        } catch {
            print("\(error)")
        }
        if tls {
            let cert = try! NIOSSLCertificate(bytes: .init(certPem.utf8), format: .pem)
            let builder: ClientConnection.Builder
            builder = ClientConnection.secure(group: group)
                .withTLS(trustRoots: .certificates([cert]))
                .withTLS(serverHostnameOverride: "djangoc.com")
            connection = builder.connect(host: host, port: port)
        }else {
            connection = ClientConnection.insecure(group: group).connect(host: host, port: port)
        }
    }
}

extension RPCService: TypeName {}


private let certPem = """
-----BEGIN CERTIFICATE-----
MIIDBjCCAe4CCQDA5wiUDbvlvzANBgkqhkiG9w0BAQsFADBFMQswCQYDVQQGEwJD
TjERMA8GA1UEBwwIU2hhbmdoYWkxDTALBgNVBAoMBGdlYWsxFDASBgNVBAMMC2Rq
YW5nb2MuY29tMB4XDTIxMDUyNjAxNDQyMloXDTMxMDUyNDAxNDQyMlowRTELMAkG
A1UEBhMCQ04xETAPBgNVBAcMCFNoYW5naGFpMQ0wCwYDVQQKDARnZWFrMRQwEgYD
VQQDDAtkamFuZ29jLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL5wLEcdYjhOgUUG0nZzQ7p0VG3wL9/RNc27DdIc+b3Z1L/P/WJw3KDtEvKTImQE
Rtw9aFCXlfNeSIhrQSbqHYXJ/g5daLY/rZjB/Hh4wUqN7rCt4n5cFPnFY24XY1ON
s+cjl3ulZdE5GoXZA+bGJskqnE/6lQEfes+IA3zFaGvsaNJrY01pVk9e5vqiBeSb
ZEeM+PkSyjFmgf5jgKL/yqTxM13b0UhIG2ZWt7xnINpeaXXLGDq2bJTRog5Lof5V
Merm7ye9UI7R3z66FQlz1a+dS3XNxGpl2skQ12vm3CU94olSdqLvMUQVa9rdhwch
CvxE/rEkSm8NEJ+4yCe3svkCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAkcD21NIe
RUYsxzp7B2950XOEH004C6NnoT20CHOEpgYN0b6nJzv+h32q3jFLPjLTUfBEOzXt
HN8NrGtXSxnxWbdTSKXkcjQCsQwXCHEL/MtNYVKAJkdpX3qxB3ITO4DZnl0X82GA
3hc834SWSIXUzRGhk1ncrZKjgUb6udjo/BdwKBTLkTT1Cv0fgCpl8EvGYMoZHmly
K2+vDVQGsgV5Ek6aZ1GgdE/lPsAqcRLw6EwgnhFsvroIRI6T4jKPcugswFCcb8wx
MPqEO25rbiaYhLEAY6oCzkZy6PKOX1Pk2N2gpU0X/4KUCHWGmMFApUkQDnAPJi4O
j/V/7ioSK5eQ2Q==
-----END CERTIFICATE-----
"""
