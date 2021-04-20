//
//  JKBall.swift
//  App
//
//  Created by Flutter on 2021/4/20.
//

import UIKit



class JKBall: UILabel {
    
    static let ballWidth:CGFloat = 40.0
    static let ballPadding:CGFloat = 15.0
    
    enum JKBallType: Int {
        case red
        case blue
    }
    
    var type: JKBallType = .red {
        didSet {
            if self.type == .red {
                self.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.3058823529, blue: 0.2784313725, alpha: 1)
            }else if self.type == .blue {
                self.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.5529411765, blue: 0.9803921569, alpha: 1)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


private extension JKBall {
    
    func setupUI() {
        
        self.font = .systemFont(ofSize: 20)
        self.textColor = .white
        self.textAlignment = .center
        self.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.3058823529, blue: 0.2784313725, alpha: 1)
        self.layer.cornerRadius = JKBall.ballWidth/2
        self.layer.masksToBounds = true

    }
    
}
