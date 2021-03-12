//
//  ViewController.swift
//  UICore
//
//  Created by Flutter on 2021/3/12.
//

import Foundation
import RxSwift

open class ViewController: UIViewController {
   public let disposeBag: DisposeBag = DisposeBag()
    
}

// MARK: - Public

public extension ViewController {
//    var disposeBag: DisposeBag { DisposeBag() }
}

// MARK: - Override

extension ViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}




// MARK: - Private

private extension ViewController {
    func setup() {
        view.backgroundColor = .white
    }
}
