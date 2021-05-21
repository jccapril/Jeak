//
//  File.swift
//  App
//
//  Created by Flutter on 2021/4/20.
//

import Foundation
import UICore
import UIKit
import RPC
class OverviewSimpleCellViewModel {
    var identifier: String
//    var target: String?
//    var size: CGSize
    var data: Jeak_Lottery?
    private weak var weakCell: LotterySimpleTableViewCell?
    init(identifier: String, data: Jeak_Lottery?) {
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
            cell.titleLabel.text = self.data?.name
            cell.phaseLabel.text = self.data?.code
             
            let date = Date.stringConvertDate(string: self.data?.date ?? "",dateFormat: "yyyy-MM-dd").string(format: "MM-dd EEEE")
            cell.dateLabel.text =  date
            cell.ball1.text = self.data?.red[0]
            cell.ball2.text = self.data?.red[1]
            cell.ball3.text = self.data?.red[2]
            cell.ball4.text = self.data?.red[3]
            cell.ball5.text = self.data?.red[4]
            if self.data?.type == 0 {
                cell.ball6.text = self.data?.red[5]
                cell.ball6.type = .red
                cell.ball7.text = self.data?.blue[0]
                cell.ball7.type = .blue
            }else if self.data?.type == 1 {
                cell.ball6.text = self.data?.blue[0]
                cell.ball6.type = .blue
                cell.ball7.text = self.data?.blue[1]
                cell.ball7.type = .blue
            }
            cell.firstRankCountLabel.text = "\( self.data?.firstCount ?? 0)注"
            cell.firstRankRewardLabel.attributedText = self.transformAttr(money: Int(self.data?.firstMoney ?? 0))
            cell.rewardPoolLabel.attributedText = self.transformAttr(money: Int(self.data?.poolMoney ?? 0))
        }
    }
    func transformAttr(money:Int)->NSAttributedString{
        
        let abs = NSMutableAttributedString()
        
        if money == 0 {
            let curr = NSAttributedString(string: "\(money)", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : #colorLiteral(red: 0.9019607843, green: 0.3058823529, blue: 0.2784313725, alpha: 1)])
            abs.append(curr)

            abs.append(NSAttributedString(string: "元", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : UIColor.black]))
            return abs.copy() as! NSAttributedString
        }
        
        let ohm = 100000000
        let ots = 10000
        
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

        if remain >= 0 {
            let curr = NSAttributedString(string: "\(remain)", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : #colorLiteral(red: 0.9019607843, green: 0.3058823529, blue: 0.2784313725, alpha: 1)])
            abs.append(curr)

            abs.append(NSAttributedString(string: "元", attributes: [.font : UIFont.systemFont(ofSize: 16),.foregroundColor : UIColor.black]))
        }


        
        return abs.copy() as! NSAttributedString
    }
}
