//
//  ViewController.swift
//  Percent
//
//  Created by yihuang on 2023/5/27.
//

import UIKit

enum ButtonType: CaseIterable {
    case bank
    case customer
    case minus
    
    var title: String {
        switch self {
        case .bank:
            return "莊"
        case .customer:
            return "閒"
        case .minus:
            return "後退"
        }
    }
    
    var tag: Int {
        switch self {
        case .bank:
            return 0
        case .customer:
            return 1
        case .minus:
            return 2
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .bank:
            return .red
        case .customer:
            return .blue
        case .minus:
            return .black
        }
    }
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var bankTitle: UILabel!
    
    
    @IBOutlet weak var bankValueLabel: UILabel!
    
    @IBOutlet weak var bankPercentLabel: UILabel!
    
    @IBOutlet weak var customerTitle: UILabel!
    
    @IBOutlet weak var customerValueLabel: UILabel!
    
    
    @IBOutlet weak var customerPercentLabel: UILabel!
    
    @IBOutlet weak var topCleanButton: UIButton!
    
    
    @IBOutlet weak var joinTitle: UILabel!
    
    @IBOutlet weak var jumpTitle: UILabel!
    
    @IBOutlet weak var joinValueLabel: UILabel!
    
    @IBOutlet weak var jumpValueLabel: UILabel!
    
    @IBOutlet weak var joinPercentLabel: UILabel!
    
    @IBOutlet weak var jumpPercentLabel: UILabel!
        
    @IBOutlet weak var actionStackView: UIStackView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var bankNumber: Float = 0 {
        didSet {
            self.bankNumber = self.bankNumber <= 0 ? 0 : self.bankNumber
            self.bankValueLabel.text = String(format: "%0d", Int(self.bankNumber))
            self.topNumberDidset()
        }
    }
    
    var customerNumber: Float = 0 {
        didSet {
            self.customerNumber = self.customerNumber <= 0 ? 0 : self.customerNumber
            self.customerValueLabel.text = String(format: "%0d", Int(self.customerNumber))
            self.topNumberDidset()
        }
    }
    
    var joinNumer: Float = 0 {
        didSet {
            self.joinNumer = self.joinNumer <= 0 ? 0 : self.joinNumer
            self.joinValueLabel.text = String(format: "%0d", Int(self.joinNumer))
            self.bottomNumberDidset()
        }
    }
    
    var jumpNumer: Float = 0 {
        didSet {
            self.jumpNumer = self.jumpNumer <= 0 ? 0 : self.jumpNumer
            self.jumpValueLabel.text = String(format: "%0d", Int(self.jumpNumer))
            self.bottomNumberDidset()
        }
    }
    
    var resultList: [String] = [] {
        didSet {
            print(resultList)
            self.countList()
            self.collectionView.reloadData()
            //TODO: - layout collectionView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topNumberDidset()
        self.bottomNumberDidset()
        self.setupCleanButton()
        self.setupBank()
        self.setupCustomer()
        self.setupJoin()
        self.setupJump()
        self.setupCleanButton()
        self.setupActionStackView()
        self.setupCollectionView()
        KeyboardHelper.shared.registFor(viewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupCollectionView()
    }
    
    
    func countList() {
        self.bankNumber = Float(self.resultList.count(where: {$0 == "莊"}))
        self.customerNumber = Float(self.resultList.count(where: {$0 == "閒"}))
        
        var joinCount = 0
        var jumpCount = 0

        guard self.resultList.count > 1 else {
            self.joinNumer = 0
            self.jumpNumer = 0
            return
        }
        
        for i in 1..<self.resultList.count {
            if let right = self.resultList[safe: i], let left = self.resultList[safe: i - 1] {
                if right == left {
                    joinCount += 1
                } else {
                    jumpCount += 1
                }
            }
        }
        
        self.joinNumer = Float(joinCount)
        self.jumpNumer = Float(jumpCount)
        
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.collectionView.frame.height / 4, height: self.collectionView.frame.height / 4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(.init(nibName: "CustomItem", bundle: nil), forCellWithReuseIdentifier: "CustomItem")
        
        self.collectionView.dataSource = self
        
        self.collectionView.reloadData()

    }
    
    func setupActionStackView() {
        for type in ButtonType.allCases {
            self.actionStackView.addArrangedSubview(self.createActionButton(type))
        }
    }
    
    
    func setupBank() {
        
        self.bankTitle.text = "莊"
        self.bankTitle.font = .systemFont(ofSize: 20, weight: .bold)
        self.bankTitle.textColor = .red
        
        self.bankValueLabel.text = "0"
        self.bankValueLabel.textAlignment = .center
        self.bankValueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.bankValueLabel.textColor = .red
        
        self.bankPercentLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    func setupCustomer() {
        
        self.customerTitle.text = "閒"
        self.customerTitle.font = .systemFont(ofSize: 20)
        self.customerTitle.textColor = .blue
        
        self.customerValueLabel.text = "0"
        self.customerValueLabel.textAlignment = .center
        self.customerValueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.customerValueLabel.textColor = .blue
        
        self.customerPercentLabel.font = .systemFont(ofSize: 20, weight: .bold)

    }
    
    func setupJoin() {
        
        self.joinTitle.text = "連"
        self.joinTitle.font = .systemFont(ofSize: 20, weight: .bold)
        self.joinTitle.textColor = .red
        
        self.joinValueLabel.text = "0"
        self.joinValueLabel.textAlignment = .center
        self.joinValueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.joinValueLabel.textColor = .red
        
        self.joinPercentLabel.font = .systemFont(ofSize: 20, weight: .bold)


    }
    
    func setupJump() {
        
        self.jumpTitle.text = "跳"
        self.jumpTitle.font = .systemFont(ofSize: 20, weight: .bold)
        self.jumpTitle.textColor = .blue
        
        self.jumpValueLabel.text = "0"
        self.jumpValueLabel.textAlignment = .center
        self.jumpValueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.jumpValueLabel.textColor = .blue
        
        self.jumpPercentLabel.font = .systemFont(ofSize: 20, weight: .bold)

    }
    
    func setupCleanButton() {
        self.setupCleanButton(self.topCleanButton)
    }
    
    func setupCleanButton(_ button: UIButton) {
        if #available(iOS 15.0, *) {
            button.configuration = nil
        }
        button.setTitle(" 清除 ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(cleanButtonAction(_:)), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func createActionButton(_ type: ButtonType) -> UIButton {
        
        let button = UIButton(type: .custom)
        
        if #available(iOS 15.0, *) {
            button.configuration = nil
        }
        
        button.setTitle(type.title, for: .normal)
        
        button.backgroundColor = type.backgroundColor
 
        button.tag = type.tag
        
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
        
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
        
        let alertController = UIAlertController(title: "確認?", message: "要清空列表嗎。", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "確認", style: .destructive) { [weak self] _ in
            self?.resultList.removeAll()
            self?.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { _ in
            
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        
        self.present(alertController, animated: true, completion: nil)
        
    }

    
    @objc func buttonAction(_ sender: UIButton) {
        
        switch sender.tag {
            
        case ButtonType.bank.tag:
            self.resultList.append(ButtonType.bank.title)
            
        case ButtonType.customer.tag:
            self.resultList.append(ButtonType.customer.title)

        case ButtonType.minus.tag:
            if !resultList.isEmpty {
                self.resultList.removeLast()
            }
            
            
        default:
            break
        }
        
    }


}





extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomItem", for: indexPath) as? CustomItem else { return UICollectionViewCell() }
        
        cell.setupView(title: self.getItem(at: indexPath))
    
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resultList.count + 100
    }
    
    // 根據要求重新排列數據順序
    func getItem(at indexPath: IndexPath) -> String? {
        let row = indexPath.item / 4 // 計算行（橫軸）
        let column = indexPath.item % 4 // 計算列（縱軸）
        let newIndex = row * 4 + column // 按照自定義規則重新排列數據
        
        print("row:\(row) column:\(column) newIndex: \(newIndex)")
        return self.resultList[safe: newIndex]
    }
}
