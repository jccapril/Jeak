//
//  CodableExampleViewController.swift
//  App
//
//  Created by Flutter on 2021/3/12.
//

import UICore

class CodableExampleViewController: ViewController {

    
    let jsonString =
    """
    {
        "name": "小明",
        "age": 12,
        "weight": 43.2,
        "gender": 1,
        "birth_date": "1992-12-25"
    }
    """
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        
//        do {
//            let xiaoming = try JSONDecoder().decode(Student.self, from: data)
//        } catch {
//            // 异常处理
//        }

        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-mm"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let xmDecode = try! decoder.decode(Student.self, from: jsonString.data(using: .utf8)!)
        print(xmDecode)
        
        encoder.dateEncodingStrategy = .formatted(formatter)
        
        let xmEncode = try! encoder.encode(xmDecode)
        let xmEncodeStr = String(data: xmEncode, encoding: .utf8)
        print(xmEncodeStr ?? "")
        
    }
    
}


extension CodableExampleViewController {
    
    func setup() {
        
        self.title = "Codable Example"
        
    }
    
}




struct Student: Codable {
    var name: String
    var age: Int
    var weight: Float
    var gender: Gender
    var birthday: Date
    
    enum Gender:Int, Codable {
        case male
        case female
        case other
    }
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case weight
        case gender
        case birthday = "birth_date"
    }
    
}
