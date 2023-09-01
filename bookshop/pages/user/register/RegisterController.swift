//
//  RegisterController.swift
//  bookshop
//
//  Created by macos.li on 2022/5/28.
//

import Foundation
import UIKit

class RegisterController: UIViewController{
    
    var joinBtn: UIButton!
    var backBtn: UIButton!
    var accountTextField: EWTextField!
    var passwordTextField: EWTextField!
    var psd2TF: EWTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(scrollView)
        
        let xOffset = CGFloat(25)
        let yOffset = CGFloat(100)
        
        accountTextField = EWTextField(frame: CGRect(x: xOffset, y: yOffset,
                                                     width: self.view.frame.width - 2 * xOffset, height: 40), isSecure: false)
        accountTextField.setTitle("账号", ofSize: 18)
        accountTextField.clearButtonMode = .always
        scrollView.addSubview(accountTextField)
        
        passwordTextField = EWTextField(frame: CGRect(x: xOffset, y: accountTextField.frame.maxY + 30,
                                                      width: self.view.frame.width - 2 * xOffset, height: 40), isSecure: true)
        passwordTextField.setTitle("密码", ofSize: 18)
        scrollView.addSubview(passwordTextField)
        
        psd2TF = EWTextField(frame: CGRect(x: xOffset, y: passwordTextField.frame.maxY + 30,
                                                      width: self.view.frame.width - 2 * xOffset, height: 40), isSecure: true)
        psd2TF.setTitle("再次确认密码", ofSize: 18)
        scrollView.addSubview(psd2TF)
        
        joinBtn = UIButton(frame: CGRect(x: 10, y: psd2TF.frame.maxY + 50, width: self.view.frame.width - 20, height: 50))
        joinBtn.backgroundColor = ColorUtil.blue
        joinBtn.layer.cornerRadius = 25
        joinBtn.setTitle("注册", for: .normal)
        joinBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        scrollView.addSubview(joinBtn)
        
        backBtn = UIButton(frame: CGRect(x: (self.view.frame.width - 150)/2, y: joinBtn.frame.maxY + 10, width: 150, height: 30))
        backBtn.titleLabel?.font = .systemFont(ofSize: 14)
        backBtn.setTitleColor(.darkGray, for: .normal)
        backBtn.setTitle("前往登陆", for: .normal)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        scrollView.addSubview(backBtn)
        
    }
    
    @objc func register() {
        let var1: String? = accountTextField.text
        let var2: String? = passwordTextField.text
        let var3: String? = psd2TF.text
        var msg = "输入不完整"
        
        if(!StringUtil.isEmpty(str: var1) || !StringUtil.isEmpty(str: var2) || !StringUtil.isEmpty(str: var3)){
            if(var2 != var3) {
                msg = "两次输入的密码不相同"
            } else {
                let res: CommonUtil.Response = CommonUtil.register(account: var1!, password: var2!)
                if(res.isSuccess){
                    self.dismiss(animated: true, completion: nil)
                    return
                } else {
                    msg = res.msg!
                }
            }
        }
        
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "确认", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
