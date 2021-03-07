//
//  ViewController.swift
//  Jeak
//
//  Created by Flutter on 2021/3/5.
//

import UIKit
import SnapKit
import GRPC
import NIO


class ViewController: UIViewController {
    
    lazy var button = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        button.setTitle("HelloWord", for: .normal)
        button.addTarget(self, action: #selector(helloWorld(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
        button.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            $0.center.equalToSuperview()
        }
  
    }

    @objc
    func helloWorld(sender:UIButton) {
        
        
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer {
              try! group.syncShutdownGracefully()
            }
            // Configure the channel, we're not using TLS so the connection is `insecure`.
            let channel = ClientConnection.insecure(group: group)
              .connect(host: "192.168.3.22", port: 18080)
            // Close the connection when we're done with it.
            defer {
              try! channel.close().wait()
            }
            
            
            
            let client = Login_LoginClient(channel: channel)
            let request = Login_LoginRequest.with{
                $0.name = "admin"
            }
           
            let login = client.login(request)
            
            login.response.whenSuccess{
                print(" login received: \($0.message)")
            }
            login.response.whenFailure{
                print("login failed: \($0)")
            }
            _ = try? login.response.wait()
            

            
        }
        
//                    guard let result = try?  login.response.wait() else {
//                        print("login failed:")
//                        return
//                    }
        
//        login.response.whenComplete { (result) in
//            do{
//                let response = try result.get()
//                print(" login received: \(response.message)")
//            } catch {
//                print("login failed: \(error)")
//            }
//        }
        // wait() on the response to stop the program from exiting before the response is received.
//        do {
//            let response = try login.response.wait()
//            sender.setTitle(String(response.message), for: .normal)
//            print(" login received: \(response.message)")
//        } catch {
//            sender.setTitle("1111", for: .normal)
//            print("login failed: \(error)")
//        }
      
    }

}

