//
//  LSMarketListCell.swift
//  HYEX_Swift
//
//  Created by iOS  Developer on 2021/3/6.
//

import UIKit

class LSMarketListCell: UITableViewCell {

    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var settlementCurrency: UILabel!
    @IBOutlet weak var hourAmount: UILabel!
    @IBOutlet weak var changeRate: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var convert: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var marketModel:LSMarketListModel?{
        didSet{
            coinName.text = marketModel!.coinName
            settlementCurrency.text = "/\(String(describing: marketModel!.settlementCurrency!))"
            if let sumCurrency = marketModel!.sumCurrency {
                hourAmount.text = String(format: "%@ %.4f", "24H量".localized,sumCurrency)
            }else{
                hourAmount.text = String(format: "%@ 0.0000", "24H量".localized)
            }
            if let latestPrice = marketModel!.latestPrice {
                price.text = "\(latestPrice)"
            }else{
                price.text = "0.00"
            }
            if let latestCnyPrice = marketModel!.latestCnyPrice {
                convert.text = "\(latestCnyPrice)"
            }else{
                convert.text = "0.00"
            }
            if let changerate = marketModel!.changeRate {
                if changerate >= 0 {
                    changeRate.backgroundColor = HEXCOLOR(h: 0x18ba96, alpha: 1)
                    changeRate.text = String(format: "+%.2f%%", changerate * 100)
                }else{
                    changeRate.backgroundColor = HEXCOLOR(h: 0xFFEDED, alpha: 1)
                    changeRate.text = String(format: "%.2f%%", changerate * 100)
                }
            }else{
                changeRate.backgroundColor = HEXCOLOR(h: 0x18ba96, alpha: 1)
                changeRate.text = "0.00"
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
