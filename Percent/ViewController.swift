//
//  ViewController.swift
//  Percent
//
//  Created by yihuang on 2023/5/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bankTitle: UILabel!
    
    @IBOutlet weak var bankTextField: UITextField!
    
    @IBOutlet weak var bankPlusButton: UIButton!
    
    @IBOutlet weak var bankReduceButton: UIButton!
    
    @IBOutlet weak var bankPercentLabel: UILabel!
    
    @IBOutlet weak var customerTitle: UILabel!
    
    @IBOutlet weak var customerTextField: UITextField!
    
    @IBOutlet weak var customPlusButton: UIButton!
    
    @IBOutlet weak var customerReduceButton: UIButton!
    
    @IBOutlet weak var customerPercentLabel: UILabel!
    
    @IBOutlet weak var topCleanButton: UIButton!
    
    
    @IBOutlet weak var joinTitle: UILabel!
    
    @IBOutlet weak var jumpTitle: UILabel!
    
    @IBOutlet weak var joinTextField: UITextField!
    
    @IBOutlet weak var jumpField: UITextField!
    
    @IBOutlet weak var joinPlusButton: UIButton!
    
    @IBOutlet weak var joinReduceButton: UIButton!
    
    @IBOutlet weak var jumpPlusButton: UIButton!
    
    @IBOutlet weak var jumpReduceButton: UIButton!
    
    @IBOutlet weak var joinPercentLabel: UILabel!
    
    @IBOutlet weak var jumpPercentLabel: UILabel!
    
    @IBOutlet weak var bottomCleanButton: UIButton!
    
    var bankNumber: Float = 0 {
        didSet {
            self.bankNumber = self.bankNumber <= 0 ? 0 : self.bankNumber
            self.bankTextField.text = String(format: "%0d", Int(self.bankNumber))
            self.topNumberDidset()
        }
    }
    
    var customerNumber: Float = 0 {
        didSet {
            self.customerNumber = self.customerNumber <= 0 ? 0 : self.customerNumber
            self.customerTextField.text = String(format: "%0d", Int(self.customerNumber))
            self.topNumberDidset()
        }
    }
    
    var joinNumer: Float = 0 {
        didSet {
            self.joinNumer = self.joinNumer <= 0 ? 0 : self.joinNumer
            self.joinTextField.text = String(format: "%0d", Int(self.joinNumer))
            self.bottomNumberDidset()
        }
    }
    
    var jumpNumer: Float = 0 {
        didSet {
            self.jumpNumer = self.jumpNumer <= 0 ? 0 : self.jumpNumer
            self.jumpField.text = String(format: "%0d", Int(self.jumpNumer))
            self.bottomNumberDidset()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewAction)))
        self.topNumberDidset()
        self.bottomNumberDidset()
        self.setupCleanButton()
        self.setupBank()
        self.setupCustomer()
        self.setupJoin()
        self.setupJump()
        self.setupCleanButton()
        KeyboardHelper.shared.registFor(viewController: self)
    }
    
    @objc func viewAction() {
        self.view.endEditing(true)
    }
    
    
    func setupBank() {
        
        self.bankTitle.text = "莊"
        self.bankTitle.font = .systemFont(ofSize: 20)
        
        self.setupTextField(self.bankTextField, tag: 1)
        
        self.setupButton(self.bankPlusButton, tag: 1)
        self.setupButton(self.bankReduceButton, tag: 2)
    }
    
    func setupCustomer() {
        
        self.customerTitle.text = "閒"
        self.customerTitle.font = .systemFont(ofSize: 20)
        
        self.setupTextField(self.customerTextField, tag: 2)
        
        self.setupButton(self.customPlusButton, tag: 3)
        self.setupButton(self.customerReduceButton, tag: 4)
    }
    
    func setupJoin() {
        
        self.joinTitle.text = "連"
        self.joinTitle.font = .systemFont(ofSize: 20)
        
        self.setupTextField(self.joinTextField, tag: 3)
        
        self.setupButton(self.joinPlusButton, tag: 5)
        self.setupButton(self.joinReduceButton, tag: 6)
    }
    
    func setupJump() {
        
        self.jumpTitle.text = "跳"
        self.jumpTitle.font = .systemFont(ofSize: 20)
        
        self.setupTextField(self.jumpField, tag: 4)
        
        self.setupButton(self.jumpPlusButton, tag: 7)
        self.setupButton(self.jumpReduceButton, tag: 8)
    }
    
    func setupCleanButton() {
        self.setupCleanButton(self.topCleanButton, tag: 1)
        self.setupCleanButton(self.bottomCleanButton, tag: 2)
    }
    
    func setupCleanButton(_ button: UIButton, tag: Int) {
        if #available(iOS 15.0, *) {
            button.configuration = nil
        }
        button.setTitle(" 清除 ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.tag = tag
        button.addTarget(self, action: #selector(cleanButtonAction(_:)), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func setupButton(_ button: UIButton, tag: Int) {
        
        if #available(iOS 15.0, *) {
            button.configuration = nil
        }
        button.setTitle(nil, for: .normal)
        
        switch tag {
        case 1,3,5,7:
            button.setImage(UIImage(systemName: "plus.circle")?.resizeImage(targetSize: .init(width: 30, height: 30)), for: .normal)
        case 2,4,6,8:
            button.setImage(UIImage(systemName: "minus.circle")?.resizeImage(targetSize: .init(width: 30, height: 30)), for: .normal)
        default:
            break
        }
        
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        button.tag = tag
    }
    
    
    func setupTextField(_ textField: UITextField, tag: Int) {
        textField.text = "0"
        textField.addTarget(self, action: #selector(textFieldAction(_:)), for: .editingChanged)
        textField.tag = tag
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 20)
    }
    
    func topNumberDidset() {
        
        if self.bankNumber != 0, self.customerNumber != 0 {
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2

            if let result = formatter.string(from: NSNumber(value: self.bankNumber / (self.bankNumber+self.customerNumber) * 100.0)) {
                self.bankPercentLabel.text = "莊佔： \(result) %"
            }
            

            if let result = formatter.string(from: NSNumber(value: self.customerNumber / (self.bankNumber+self.customerNumber) * 100.0)) {
                self.customerPercentLabel.text = "閒佔： \(result) %"
            }

        } else {
            self.bankPercentLabel.text = "莊或閒不能為0"
            self.customerPercentLabel.text = "莊或閒不能為0"
        }
    }
    
    func bottomNumberDidset() {
        
        if self.joinNumer != 0, self.jumpNumer != 0 {
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2

            if let result = formatter.string(from: NSNumber(value: self.joinNumer / (self.joinNumer+self.jumpNumer) * 100.0)) {
                self.joinPercentLabel.text = "連佔： \(result) %"
            }
            

            if let result = formatter.string(from: NSNumber(value: self.jumpNumer / (self.joinNumer+self.jumpNumer) * 100.0)) {
                self.jumpPercentLabel.text = "跳佔： \(result) %"
            }

        } else {
            self.joinPercentLabel.text = "連或跳不能為0"
            self.jumpPercentLabel.text = "連或跳不能為0"
        }
    }

    
    @objc func textFieldAction(_ sender: UITextField) {
        
        switch sender.tag {
        case 1:
            self.bankNumber = Float(sender.text ?? "0") ?? 0
        case 2:
            self.customerNumber = Float(sender.text ?? "0") ?? 0
        case 3:
            self.joinNumer = Float(sender.text ?? "0") ?? 0
        case 4:
            self.jumpNumer = Float(sender.text ?? "0") ?? 0
        default:
            break
        }

    }
    
    @objc func cleanButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.bankNumber = 0
            self.customerNumber = 0
        case 2:
            self.joinNumer = 0
            self.jumpNumer = 0
        default:
            break
        }
    }

    
    @objc func buttonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        switch sender.tag {
        case 1:
            self.bankNumber += 1
        case 2:
            self.bankNumber -= 1
        case 3:
            self.customerNumber += 1
        case 4:
            self.customerNumber -= 1
        case 5:
            self.joinNumer += 1
        case 6:
            self.joinNumer -= 1
        case 7:
            self.jumpNumer += 1
        case 8:
            self.jumpNumer -= 1
        default:
            break
        }
    }


}


extension ViewController {
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 10.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
