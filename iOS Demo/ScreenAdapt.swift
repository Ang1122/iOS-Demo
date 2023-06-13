//
//  ScreenAdapt.swift
//  MathSolveNow
//
//  Created by 郭宝琪 on 2023/4/11.
//

import Foundation
import UIKit

// 屏幕参数
public let kScreenBounds = UIScreen.main.bounds
public let kScreenSize = UIScreen.main.bounds.size
public let kScreenWidth = UIScreen.main.bounds.size.width
public let kScreenHeight = UIScreen.main.bounds.size.height
public let kScreenScale = UIScreen.main.scale

public let kIsFullScreen = kScreenHeight > 750.0
public let kIsSmallScreen = kScreenHeight <= 750.0

public enum AdaptType {
    case constraint
    case fontSize
    case cornerRadius
    case all
}

public func adapt(_ value: CGFloat, _ smallValue: CGFloat? = nil) -> CGFloat {
    if smallValue != nil && kIsSmallScreen {
        return smallValue! * kScreenWidth / 375.0
    }
    
    return value * kScreenWidth / 375.0
}

// 通用导航栏高度
var navigationBarHeight: CGFloat {
    return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
}

// 状态栏高度
var statusBarHeight: CGFloat {
    return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? (kIsFullScreen ? 44 : 20)
}

public extension UIView {
    func adaptView(types: [AdaptType] = [.constraint]) {
        if types.count == 0 {
            return
        }
        
        self.adaptViews(types: types)
        self.layoutIfNeeded()
    }
    
    private func adaptViews(types: [AdaptType]) {
        var constraintAdapt = false
        var fontSizeAdapt = false
        var cornerRadiusAdapt = false
        types.forEach { (type: AdaptType) in
            switch type {
            case .all:
                constraintAdapt = true
                fontSizeAdapt = true
                cornerRadiusAdapt = true
            case .constraint:
                constraintAdapt = true
            case .fontSize:
                fontSizeAdapt = true
            case .cornerRadius:
                cornerRadiusAdapt = true
            }
        }
        
        if constraintAdapt {
            //对约束进行等比例适配
            self.constraints.forEach { (constraint: NSLayoutConstraint) in
                constraint.constant = adapt(constraint.constant)
            }
        }
        
        if cornerRadiusAdapt {
            //对圆角大小进行等比例适配
            if self.layer.cornerRadius > 0 {
                self.layer.cornerRadius = adapt(self.layer.cornerRadius)
            }
        }
        
        if fontSizeAdapt {
            //对字体大小进行等比例适配
            if self.isKind(of: UILabel.classForCoder()) {
                if let className = NSClassFromString("UIButtonLabel"), !self.isKind(of: className) {
                    if let label = self as? UILabel, let font = label.font {
                        label.font = font.withSize(adapt(font.pointSize))
                    }
                }
                
            } else if self.isKind(of: UIButton.classForCoder()) {
                if let button = self as? UIButton, let font = button.titleLabel?.font  {
                    button.titleLabel?.font = font.withSize(adapt(font.pointSize))
                }
                
            } else if self.isKind(of: UITextField.classForCoder()) {
                if let textField = self as? UITextField, let font = textField.font {
                    textField.font = font.withSize(adapt(font.pointSize))
                }
                
            } else if self.isKind(of: UITextView.classForCoder()) {
                if let textView = self as? UITextView, let font = textView.font {
                    textView.font = font.withSize(adapt(font.pointSize))
                }
                
            }
        }
        
        self.subviews.forEach { (subView: UIView) in
            subView.adaptViews(types: types)
        }
    }
}

private var constraintAdaptEnableKey = "constraintAdaptEnableKey"
public extension NSLayoutConstraint {
    @IBInspectable var adaptEnable: Bool {
        get {
            return (objc_getAssociatedObject(self, &constraintAdaptEnableKey) as? Bool) ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &constraintAdaptEnableKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            
            if newValue == true {
                constant = adapt(constant)
            }
            
        }
    }
    
    @IBInspectable var smallConstant: CGFloat {
        get {
            return constant
        }
        
        set {
            guard kIsSmallScreen else {
                return
            }
            
            constant = adaptEnable ? adapt(newValue) : newValue
        }
    }
}

public extension UIImageView {
    @IBInspectable var smallImage: UIImage? {
        get {
            return self.image
        }
        
        set {
            guard kIsSmallScreen else {
                return
            }
            
            self.image = newValue
        }
    }
}

private var labelFontAdaptKey = "labelFontAdaptKey"
public extension UILabel {
    @IBInspectable var fontAdapt: Bool {
        get {
            return (objc_getAssociatedObject(self, &labelFontAdaptKey) as? Bool) ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &labelFontAdaptKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            
            if newValue == true {
                font = font.withSize(adapt(font.pointSize))
            }
        }
    }
    
    @IBInspectable var smallFontSize: CGFloat {
        get {
            return font.pointSize
        }
        
        set {
            guard kIsSmallScreen else {
                return
            }
            
            font = font.withSize(fontAdapt ? adapt(newValue) : newValue)
        }
    }
}

private var buttonFontAdaptKey = "buttonFontAdaptKey"
public extension UIButton {
    @IBInspectable var fontAdapt: Bool {
        get {
            return (objc_getAssociatedObject(self, &buttonFontAdaptKey) as? Bool) ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &buttonFontAdaptKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            
            guard newValue == true, let titleFont = titleLabel?.font else {
                return
            }
            
            titleLabel?.font = titleFont.withSize(adapt(titleFont.pointSize))
        }
    }
    
    @IBInspectable var smallFontSize: CGFloat {
        get {
            return titleLabel?.font.pointSize ?? 0
        }
        
        set {
            guard kIsSmallScreen, let titleFont = titleLabel?.font else {
                return
            }
            titleLabel?.font = titleFont.withSize(fontAdapt ? adapt(newValue) : newValue)
        }
    }
}

private var textFieldFontAdaptKey = "textFieldFontAdaptKey"
public extension UITextField {
    @IBInspectable var fontAdapt: Bool {
        get {
            return (objc_getAssociatedObject(self, &textFieldFontAdaptKey) as? Bool) ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &textFieldFontAdaptKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            
            guard newValue == true, let textFont = font else {
                return
            }
            font = textFont.withSize(adapt(textFont.pointSize))
        }
    }
    
    @IBInspectable var smallFontSize: CGFloat {
        get {
            return font?.pointSize ?? 0
        }
        
        set {
            guard kIsSmallScreen, let textFont = font else {
                return
            }
            font = textFont.withSize(fontAdapt ? adapt(newValue) : newValue)
        }
    }
}

private var textViewFontAdaptKey = "textViewFontAdaptKey"
public extension UITextView {
    @IBInspectable var fontAdapt: Bool {
        get {
            return (objc_getAssociatedObject(self, &textViewFontAdaptKey) as? Bool) ?? false
        }
        
        set {
            objc_setAssociatedObject(self, &textViewFontAdaptKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            
            guard newValue == true, let textFont = font else {
                return
            }
            font = textFont.withSize(adapt(textFont.pointSize))
            
        }
    }
    
    @IBInspectable var smallFontSize: CGFloat {
        get {
            return font?.pointSize ?? 0
        }
        
        set {
            guard kIsSmallScreen, let textFont = font else {
                return
            }
            font = textFont.withSize(fontAdapt ? adapt(newValue) : newValue)
        }
    }
}

