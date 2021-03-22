//
//  ViewController.swift
//  UICore
//
//  Created by Flutter on 2021/3/12.
//

import UIKit
import Standard

open class ViewController: UIViewController {
   public let disposeBag: DisposeBag = DisposeBag()
    
}

// MARK: - TypeName
extension ViewController: TypeName {}

// MARK: - Public

public extension ViewController {

}

// MARK: - Override

extension ViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

// MARK: - Private

private extension ViewController {
    func setupUI() {
        view.backgroundColor = .white
    }
}
