
import Foundation
import UIKit

class MultilineLabel: UILabel {
    
    var lineSpacing: CGFloat
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, fontOfSize: CGFloat, textStr: String, lineSpacing: CGFloat ) {
        self.lineSpacing = lineSpacing
        // 高度自适应
        super.init(frame: CGRect(x: x, y: y, width: width, height: CGFloat.greatestFiniteMagnitude))
        let text = NSMutableAttributedString.init(string: textStr)
        let style = NSMutableParagraphStyle.init()
        style.lineSpacing = lineSpacing;    // 行间距
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.length))
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.numberOfLines = 0
        self.attributedText = text
        self.textAlignment = NSTextAlignment.left // 左对齐
        self.font = UIFont.systemFont(ofSize: fontOfSize) // 字体大小
        self.sizeToFit()
        
        self.frame = CGRect(x: x, y: y, width: width, height: self.frame.height)
    }
    
    func setText(textStr: String) {
        let text = NSMutableAttributedString.init(string: textStr)
        let style = NSMutableParagraphStyle.init()
        style.lineSpacing = lineSpacing
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.length))
        self.attributedText = text
        self.sizeToFit()
    }
    
    // 获取当前label的高度
    func getHeight() -> CGFloat {
        return self.frame.height
    }
    
    // 计算文本的高度，开放给外界使用，便于布局
    static func caculateHeight(width: CGFloat, fontOfSize: CGFloat, textStr: String, lineSpacing: CGFloat ) -> CGFloat {
        let label = MultilineLabel(x: 0, y: 0, width: width, fontOfSize: fontOfSize, textStr: textStr, lineSpacing: lineSpacing)
        return label.frame.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
