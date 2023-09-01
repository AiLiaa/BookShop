//
//  Logout.swift
//  bookshop
//
//  Created by macos.li on 2022/5/28.
//

import Foundation
import UIKit

class LogoutCell: BaseCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.theme_textColor = ThemeColorPicker(keyPath: "Global.textColor")
    }
}

