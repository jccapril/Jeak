//
//  File.swift
//  App
//
//  Created by Flutter on 2021/4/20.
//

import Foundation
import UICore
import UIKit

class OverviewSimpleCellViewModel {
    var identifier: String
//    var target: String?
//    var size: CGSize
    var data: JKLottery
    private weak var weakCell: LotterySimpleTableViewCell?
    init(identifier: String, data: JKLottery) {
        self.data = data
        self.identifier = identifier
    }
}

extension OverviewSimpleCellViewModel: BaseCellViewModel {
  
    func willDisplay(cell: UIView) {
        weakCell = cell as? LotterySimpleTableViewCell
        bindShow()
    }

    func didEndDisplaying(cell _: UIView) {}
}


private extension OverviewSimpleCellViewModel {
    func bindShow() {
        guard let cell = weakCell else {
            return
        }
        DispatchQueue.main.async {
            cell.titleLabel.text = self.data.lotteryName
            cell.phaseLabel.text = "\(self.data.lotteryPhase)"
            cell.dateLabel.text =  self.data.lotteryDate.string(format: "MM-dd EEEE")
            cell.ball1.text = self.data.redBalls[0]
            cell.ball2.text = self.data.redBalls[1]
            cell.ball3.text = self.data.redBalls[2]
            cell.ball4.text = self.data.redBalls[3]
            cell.ball5.text = self.data.redBalls[4]
            if self.data.lotteryType == .ssq {
                cell.ball6.text = self.data.redBalls[5]
                cell.ball6.type = .red
                cell.ball7.text = self.data.blueBalls[0]
                cell.ball7.type = .blue
            }else if self.data.lotteryType == .dlt {
                cell.ball6.text = self.data.blueBalls[0]
                cell.ball6.type = .blue
                cell.ball7.text = self.data.blueBalls[1]
                cell.ball7.type = .blue
            }
            cell.firstRankCountLabel.text = "\(self.data.lotteryFirstPrizeCount)注"
            cell.firstRankRewardLabel.attributedText = self.transformAttr(money: Int(self.data.lotteryFirstPrizeMoney))
            cell.rewardPoolLabel.attributedText = self.transformAttr(money: Int(self.data.lotteryRewardPoolMoney))
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
