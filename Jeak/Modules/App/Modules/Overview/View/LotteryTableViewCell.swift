//
//  LotteryTableViewCell.swift
//  App
//
//  Created by Flutter on 2021/4/15.
//

import UIKit

class LotteryTableViewCell: UITableViewCell {

    var type: JKLotteryType = .ssq
    
    private lazy var backgroundImageView: UIImageView = {
        UIImageView(image: UIImage(color: Theme.backgroundColor))
    }()
    
    /** 标题 e.g. 双色球 */
    lazy var titleLabel: UILabel = {
        UILabel()
            .leaf
            .font(UIFont.boldSystemFont(ofSize: 20))
            .textColor(.black)
            .textAlignment(.left)
            .instance
    }()
 
    
    /** 期数 e.g.  2021039期 */
    lazy var phaseLabel: UILabel = {
        UILabel()
            .leaf
            .font(UIFont.systemFont(ofSize: 16))
            .textColor(.black)
            .textAlignment(.left)
            .instance
    }()
   
    /** 日期 e.g.  04-13 星期二 */
    lazy var dateLabel: UILabel = {
        UILabel()
            .leaf
            .font(UIFont.systemFont(ofSize: 16))
            .textColor(.black)
            .textAlignment(.right)
            .instance
    }()
    
    lazy var ball1: JKBall = {
        let ball: JKBall = JKBall()
        ball.type = .red
        return ball
    }()
    lazy var ball2: JKBall = {
        let ball: JKBall = JKBall()
        ball.type = .red
        return ball
    }()
    lazy var ball3: JKBall = {
        let ball: JKBall = JKBall()
        ball.type = .red
        return ball
    }()
    lazy var ball4: JKBall = {
        let ball: JKBall = JKBall()
        ball.type = .red
        return ball
    }()
    lazy var ball5: JKBall = {
        let ball: JKBall = JKBall()
        ball.type = .red
        return ball
    }()
    lazy var ball6: JKBall = {
        let ball: JKBall = JKBall()
        ball.type = .red
        return ball
    }()
    lazy var ball7: JKBall = {
        let ball: JKBall = JKBall()
        ball.type = .blue
        return ball
    }()
    
    lazy var indicator: UIImageView = {
        UIImageView()
            .leaf
            .image(CommonModular.image(named: "ic_overview_cell_right"))
            .instance
    }()
    
    
    lazy var detailView: UIView = {
        UIView()
            .leaf
            .backgroundColor(#colorLiteral(red: 0.9568627451, green: 0.9725490196, blue: 0.9803921569, alpha: 1))
            .corners(radius: 4)
            .instance
    }()
    
    lazy var bottomLineView: UIView = {
        UIView()
            .leaf
            .backgroundColor(#colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1))
            .instance
    }()
    
   private lazy var firstRankTitleLabel: UILabel = {
        UILabel()
            .leaf
            .text("一等奖")
            .textColor(#colorLiteral(red: 0.5647058824, green: 0.5647058824, blue: 0.5647058824, alpha: 1))
            .font(.systemFont(ofSize: 16))
            .textAlignment(.center)
            .instance
    }()
    
    lazy var firstRankCountLabel: UILabel = {
        UILabel()
            .leaf
            .backgroundColor(#colorLiteral(red: 0.9019607843, green: 0.3058823529, blue: 0.2784313725, alpha: 1))
            .font(.systemFont(ofSize: 12))
            .textColor(.white)
            .corners(radius: 8)
            .textAlignment(.center)
            .instance
    }()
    
    lazy var firstRankRewardLabel: UILabel = {
        UILabel()
            .leaf
            .font(.systemFont(ofSize: 16))
            .textAlignment(.center)
            .instance
    }()
    
    private lazy var rewardPoolTitleLabel: UILabel = {
        UILabel()
            .leaf
            .text("奖池滚存")
            .textColor(#colorLiteral(red: 0.5647058824, green: 0.5647058824, blue: 0.5647058824, alpha: 1))
            .font(.systemFont(ofSize: 16))
            .textAlignment(.center)
            .instance
        
    }()
    
    lazy var rewardPoolLabel: UILabel = {
        UILabel()
            .leaf
            .font(.systemFont(ofSize: 16))
            .textAlignment(.center)
            .instance
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension LotteryTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


private extension LotteryTableViewCell {
    
    func setupUI() {
//        contentView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
//        backgroundImageView.leaf.add(to: contentView)
//        backgroundImageView.snp.makeConstraints {
//            $0.top.leading.trailing.equalTo(contentView)
//            $0.height.equalTo(180)
//            $0.bottom.equalTo(contentView).offset(-10)
//        }

        titleLabel.text = self.type.toString()
        titleLabel.leaf.add(to: contentView)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(10)
            $0.top.equalTo(15)
        }
        
        phaseLabel.text = "2021039期"
        phaseLabel.leaf.add(to: contentView)
        phaseLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.titleLabel)
            $0.leading.equalTo(self.titleLabel.snp_trailingMargin).offset(10)
        }
        
        dateLabel.text = "04-13 星期二"
        dateLabel.leaf.add(to: contentView)
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.titleLabel)
            $0.trailing.equalTo(-10)
        }
        
        ball1.text = "01"
        ball1.leaf.add(to: contentView)
        ball1.snp.makeConstraints {
            $0.leading.equalTo(self.titleLabel)
            $0.size.equalTo(CGSize(width: JKBall.ballWidth, height: JKBall.ballWidth))
            $0.top.equalTo(self.titleLabel.snp_bottomMargin).offset(30)
        }
        
        ball2.text = "02"
        ball2.leaf.add(to: contentView)
        ball2.snp.makeConstraints {
            $0.centerY.equalTo(ball1)
            $0.leading.equalTo(ball1.snp_trailingMargin).offset(JKBall.ballPadding)
            $0.size.equalTo(CGSize(width: JKBall.ballWidth, height: JKBall.ballWidth))
        }
        
        ball3.text = "03"
        ball3.leaf.add(to: contentView)
        ball3.snp.makeConstraints {
            $0.centerY.equalTo(ball2)
            $0.leading.equalTo(ball2.snp_trailingMargin).offset(JKBall.ballPadding)
            $0.size.equalTo(CGSize(width: JKBall.ballWidth, height: JKBall.ballWidth))
        }
        
        ball4.text = "04"
        ball4.leaf.add(to: contentView)
        ball4.snp.makeConstraints {
            $0.centerY.equalTo(ball3)
            $0.leading.equalTo(ball3.snp_trailingMargin).offset(JKBall.ballPadding)
            $0.size.equalTo(CGSize(width: JKBall.ballWidth, height: JKBall.ballWidth))
        }
        
        
        ball5.text = "05"
        ball5.leaf.add(to: contentView)
        ball5.snp.makeConstraints {
            $0.centerY.equalTo(ball4)
            $0.leading.equalTo(ball4.snp_trailingMargin).offset(JKBall.ballPadding)
            $0.size.equalTo(CGSize(width: JKBall.ballWidth, height: JKBall.ballWidth))
        }
        
        ball6.text = "06"
        ball6.leaf.add(to: contentView)
        ball6.snp.makeConstraints {
            $0.centerY.equalTo(ball5)
            $0.leading.equalTo(ball5.snp_trailingMargin).offset(JKBall.ballPadding)
            $0.size.equalTo(CGSize(width: JKBall.ballWidth, height: JKBall.ballWidth))
        }
        
        ball7.text = "01"
        ball7.leaf.add(to: contentView)
        ball7.snp.makeConstraints {
            $0.centerY.equalTo(ball6)
            $0.leading.equalTo(ball6.snp_trailingMargin).offset(JKBall.ballPadding)
            $0.size.equalTo(CGSize(width: JKBall.ballWidth, height: JKBall.ballWidth))
        }
        
        indicator.leaf.add(to: contentView)
        indicator.snp.makeConstraints {
            $0.centerY.equalTo(ball1)
            $0.trailing.equalTo(dateLabel)
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        detailView.leaf.add(to: contentView)
        detailView.snp.makeConstraints {
            $0.leading.equalTo(ball1)
            $0.trailing.equalTo(dateLabel)
            $0.top.equalTo(ball1.snp_bottomMargin).offset(20)
            $0.height.equalTo(80)
        }
        
        
        firstRankTitleLabel.leaf.add(to: detailView)
        firstRankTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.5)
            $0.centerX.equalToSuperview().multipliedBy(0.5)
        }
        
        rewardPoolTitleLabel.leaf.add(to: detailView)
        rewardPoolTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.5)
            $0.centerX.equalToSuperview().multipliedBy(1.5)
        }
        
        
        firstRankCountLabel.text = "5注"
        firstRankCountLabel.leaf.add(to: detailView)
        firstRankCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(firstRankTitleLabel)
            $0.height.equalTo(16)
            $0.width.equalTo(40)
            $0.leading.equalTo(firstRankTitleLabel.snp_trailingMargin).offset(15)
        }
        
        
        let expFRR = 87129121
        firstRankRewardLabel.attributedText = transformAttr(money: expFRR)
        firstRankRewardLabel.leaf.add(to: detailView)
        firstRankRewardLabel.snp.makeConstraints {
            $0.centerX.equalTo(firstRankTitleLabel)
            $0.centerY.equalToSuperview().multipliedBy(1.5)
        }
        
        let expRP = 887129121
        rewardPoolLabel.attributedText = transformAttr(money: expRP)
        rewardPoolLabel.leaf.add(to: detailView)
        rewardPoolLabel.snp.makeConstraints {
            $0.centerX.equalTo(rewardPoolTitleLabel)
            $0.centerY.equalToSuperview().multipliedBy(1.5)
        }
        
    
        bottomLineView.leaf.add(to: contentView)
        bottomLineView.snp.makeConstraints {
            $0.top.equalTo(detailView.snp_bottomMargin).offset(20)
            $0.height.equalTo(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        
        
        
    }
    
    
    func transformAttr(money:Int)->NSAttributedString{
        
        let ohm = 100000000
        let ots = 10000
        let abs = NSMutableAttributedString()
        
        let hm = money/ohm
        let ts = (money%ohm)/ots
        let remain = (money%ohm)%ots
        if hm > 0 {
            let curr = NSAttributedString(string: "\(hm)", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : #colorLiteral(red: 0.9019607843, green: 0.3058823529, blue: 0.2784313725, alpha: 1)])
            abs.append(curr)

            abs.append(NSAttributedString(string: "亿", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : UIColor.black]))
        }
        
        
        if ts > 0 {
            let curr = NSAttributedString(string: "\(ts)", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : #colorLiteral(red: 0.9019607843, green: 0.3058823529, blue: 0.2784313725, alpha: 1)])
            abs.append(curr)

            abs.append(NSAttributedString(string: "万", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : UIColor.black]))
        }

        if remain > 0 {
            let curr = NSAttributedString(string: "\(remain)", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : #colorLiteral(red: 0.9019607843, green: 0.3058823529, blue: 0.2784313725, alpha: 1)])
            abs.append(curr)

            abs.append(NSAttributedString(string: "元", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : UIColor.black]))
        }


        
        return abs.copy() as! NSAttributedString
    }
    
    
}


//extension LotteryTableViewCell: ConfigurableCell {
//    
//}
