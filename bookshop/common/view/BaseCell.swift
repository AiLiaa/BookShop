
import Foundation
import UIKit

class BaseCell: UITableViewCell {
    
    override func awakeFromNib() {
        self.theme_backgroundColor = ThemeColorPicker(keyPath: "Global.backgroundColor")
    }
    
}
