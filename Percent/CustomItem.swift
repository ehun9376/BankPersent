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
        
        self.titleLabel.textColor = .white
        self.titleLabel.textAlignment = .center
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        self.titleLabel.layer.cornerRadius = self.titleLabel.frame.height / 2
        self.titleLabel.clipsToBounds = true
    }
    
    func setupView(title: String?) {
        
        guard let title = title else {
            self.titleLabel.isHidden = true
            return
        }
        
        self.titleLabel.isHidden = false
        
        self.titleLabel.text = title
        
        if title == "莊" {
            self.titleLabel.backgroundColor = .red
        } else if title == "閒"  {
            self.titleLabel.backgroundColor = .blue
        } else {
            self.titleLabel.backgroundColor = .clear
        }
        
    }
}
