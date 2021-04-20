//
//  File.swift
//  App
//
//  Created by Flutter on 2021/4/20.
//

import UIKit

protocol RxBaseCellViewModel {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

protocol BaseCellViewModel {
    var identifier: String { get set }
    var target: String? { get set }
    var size: CGSize { get set }
    func willDisplay(cell: UIView)
    func didEndDisplaying(cell: UIView)
}

