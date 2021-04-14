//
//  CarouseViewCell.swift
//  App
//
//  Created by Flutter on 2021/4/13.
//

import UIKit

class CarouseViewCell: UICollectionViewCell {
    
    lazy var imageView:UIImageView = {
       UIImageView()
    }()
    var type: JKLotteryType = .ssq
    var imgCornerRadius: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.leaf.add(to: self.contentView)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}

// MARK: - Override

extension CarouseViewCell {
    override func layoutSubviews() {
        self.imageView.frame = self.bounds;
        let maskPath = UIBezierPath(roundedRect: self.imageView.bounds, cornerRadius: self.imgCornerRadius)
        let maskLayer = CAShapeLayer()
        //设置大小
        maskLayer.frame = self.bounds;
        //设置图形样子
        maskLayer.path = maskPath.cgPath
        self.imageView.layer.mask = maskLayer
    }
}
