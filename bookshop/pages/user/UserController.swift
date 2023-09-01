//
//  UserController.swift
//  bookshop
//
//  Created by macos.li on 2022/5/28.
//

import Foundation
import UIKit

class UserController: UITableViewController {
    
    @IBOutlet weak var nicknameTextView: UITextView!
    @IBOutlet weak var headImage: UIImageView!
    
    // 界面初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        headImage.layer.masksToBounds = true
        headImage.layer.cornerRadius = headImage.frame.width / 2
        headImage.contentMode = .scaleToFill
        
        // 注册监听器
        NotificationCenter.default.addObserver(self, selector: #selector(observerLoginSuccess),
                                               name: NSNotification.Name(rawValue:"loginSuccess"), object: nil)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
                
        viewDidLoadHelper()
    }
    
    // 界面初始化helper
    func viewDidLoadHelper(){
        if(CommonUtil.getUser() == nil) {
            print("用户未登录")
            nicknameTextView.text = "未登录"
            headImage.theme_image = ThemeImagePicker(keyPath: "userHeadCell.headImage")
        } else {
            let img = CommonUtil.getUser()?.img
            if(img == nil) {
                headImage.theme_image = ThemeImagePicker(keyPath: "userHeadCell.headImage")
            } else {
                headImage.image = img
            }
            nicknameTextView.text = CommonUtil.getUser()?.nickname
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        // 需要检查用户是否登录的section
        if(indexPath.section == 1 || indexPath.section == 2){
            if(CommonUtil.getUser() == nil) {
                CBToast.showToastAction(message: "用户未登录")
                return
            }
        } else {
            return
        }
    }
    
    // 点击头像区域跳转登录界面
    @IBAction func login(_ sender: UITapGestureRecognizer) {
        if(CommonUtil.getUser() == nil) {
            print("用户未登录，进入登录页面")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    // 监听登录成功的通知，重新加载页面
    @objc func observerLoginSuccess(){
        print("监听到loginSuccess通知")
        viewDidLoadHelper()
    }
    
    // 退出登录，重新加载页面
    @IBAction func quitLogin(_ segue: UIStoryboardSegue){
        print("退出登录")
        CommonUtil.quitLogin()
        viewDidLoadHelper()
    }
    
    deinit {
        // 取消通知
        NotificationCenter.default.removeObserver(self)
    }
}
