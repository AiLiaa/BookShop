//
//  ShoppingCarController.swift
//  bookshop
//
//  Created by macos.li on 2022/5/27.
//

import Foundation
import UIKit

class ShoppingCarController: UITableViewController {
    
    var label: UILabel?
    @IBOutlet weak var btn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        let w = self.tableView.frame.width

        tableView.backgroundView?.contentMode = .bottomRight
        
        label = UILabel(frame: CGRect(x: w/4, y: w/4, width: w/2, height: 20))
        label?.text = "购物车空空"
        label?.font = UIFont.systemFont(ofSize: 13)
        label?.textColor = UIColor.gray
        label?.textAlignment = NSTextAlignment.center
        self.tableView.addSubview(label!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(observerRefresh), name: NSNotification.Name(rawValue:"refreshShoppingCar"), object: nil)
        
        viewDidLoadHelper()
    }
    
    //清空购物车
    @IBAction func clearAll(_ sender: Any) {
        CommonUtil.clearShoppingCar()
        observerRefresh()
    }
    
    func viewDidLoadHelper() {
        // 在购物车为空的时候文字提示
        if(CommonUtil.getShoppingCar().count == 0){
            label?.isHidden = false
            btn.isEnabled = false
        } else {
            label?.isHidden = true
            btn.isEnabled = true
        }
    }
    
    @objc func observerRefresh(){
        viewDidLoadHelper()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommonUtil.getShoppingCar().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCarCell", for: indexPath) as! ShoppingCarCell
        let book: Book = CommonUtil.getShoppingCar()[indexPath.row]
        cell.coverImageView.image = book.cover
        cell.bookNameLabel.text = book.name
        cell.priceLabel.text = book.price?.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // 所有单元格都可删除
        return UITableViewCell.EditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let toRemove = CommonUtil.getShoppingCar()[indexPath.row]
            CommonUtil.removeFromShoppingCar(book: toRemove)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            viewDidLoadHelper()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
