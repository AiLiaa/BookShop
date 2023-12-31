//
//  OrderController.swift
//  bookshop
//
//  Created by macos.li on 2022/5/27.
//

import Foundation
import UIKit

class OrderController: UITableViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        numberLabel.text = CommonUtil.getShoppingCar().count.description
        var amount = 0.0
        for b in CommonUtil.getShoppingCar() {
            amount += b.price!
        }
        amountLabel.text = amount.description
        
        btn.layer.cornerRadius = btn.frame.height/2
    }
        
    
    @IBAction func pay(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "您是否确认完成这笔订单？",
                                      preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "确认", style: .default, handler: {
            action in self.ensurePay()
        })
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
        CommonUtil.buy()
    }
    
    private func ensurePay() {
        print("确认支付")
        CommonUtil.buy()
        NotificationCenter.default.post(name: NSNotification.Name("refreshShoppingCar"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
}
