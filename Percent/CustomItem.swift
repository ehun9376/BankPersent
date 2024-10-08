//
//  CustomItem.swift
//  Percent
//
//  Created by 陳逸煌 on 2024/10/7.
//

import Foundation
import UIKit

class CustomItem: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = .white

        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        
        self.titleLabel.layer.cornerRadius = ((UIScreen.main.bounds.size.width / 8 ) - 6) / 2
        self.titleLabel.clipsToBounds = true
        self.titleLabel.textColor = .white
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        
    }
    
    override func prepareForReuse() {
        self.contentView.backgroundColor = .white

        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        
        self.titleLabel.layer.cornerRadius = ((UIScreen.main.bounds.size.width / 8 ) - 6) / 2
        self.titleLabel.clipsToBounds = true
        self.titleLabel.textColor = .white
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
  
    
    func setupView(title: String?) {
        
        guard let title = title, title != "0" else {
            self.titleLabel.isHidden = true
            return
        }
        
        self.titleLabel.isHidden = false
        
        self.titleLabel.text = title
        
        if title == "莊" {
            self.titleLabel.backgroundColor = .red
            self.titleLabel.textColor = .white
            self.titleLabel.textAlignment = .center
            self.titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
            self.titleLabel.adjustsFontSizeToFitWidth = true
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 1
        } else if title == "閒"  {
            self.titleLabel.backgroundColor = .blue

        }
        
    }
}
