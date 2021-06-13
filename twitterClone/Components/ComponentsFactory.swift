import MaterialComponents
import UIKit

class ComponentsFactory {
    
    var textFieldControllerFloating = MDCTextInputControllerUnderline()
    
    static func floatLabel(textFieldFloating: MDCTextField) -> MDCTextInputControllerUnderline {
        var textFieldControllerFloating = MDCTextInputControllerUnderline()
        
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: textFieldFloating)
        
        textFieldControllerFloating.activeColor = .white
        textFieldControllerFloating.disabledColor = .white
        
        textFieldControllerFloating.leadingUnderlineLabelTextColor = .white
        textFieldControllerFloating.trailingUnderlineLabelTextColor = .white
        textFieldControllerFloating.inlinePlaceholderColor = .white
        textFieldControllerFloating.borderFillColor = UIColor.twitterBlue
        textFieldControllerFloating.isFloatingEnabled = true
        textFieldControllerFloating.floatingPlaceholderActiveColor = .white
        textFieldControllerFloating.floatingPlaceholderNormalColor = .white
        
        
        textFieldControllerFloating.activeColor = .white
        textFieldControllerFloating.normalColor = .white                 
        textFieldControllerFloating.errorColor = UIColor.red
        
        return textFieldControllerFloating
    }
    
    
    static func textFieldInput(placeholder: String, keyboardType: UIKeyboardType) -> MDCTextField {
        
        let textFieldFloating = MDCTextField()
        
        textFieldFloating.placeholder = placeholder
        textFieldFloating.textColor = .white
        textFieldFloating.layer.cornerRadius = 10
        textFieldFloating.keyboardType = keyboardType
        textFieldFloating.autocapitalizationType = .none
        textFieldFloating.font = UIFont(name: "Roboto-Regular", size: 16)
        
        textFieldFloating.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.twitterBlue])
        
        return textFieldFloating
    }
    
    static func buttonBase (title: String) -> MDCButton {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.twitterBlue, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitleFont(UIFont(name: "Roboto-Regular", size: 16), for: .normal)

        return button
    }
    
    static func labelBase (text: String, nameFont: String, sizeFont: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: nameFont, size: sizeFont)
        label.textColor = textColor

        return label
    }
    
}
