//
//  CountCustomItem.swift
//  Percent
//
//  Created by 陳逸煌 on 2024/10/9.
//

import Foundation
import UIKit


class CountCustomItem: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = .white
        self.titleLabel.backgroundColor = .white
        self.titleLabel.textColor = .red
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        self.titleLabel.adjustsFontSizeToFitWidth = true

    }

    
    func setupView(title: String?) {
        
        guard let title = title, title != "0" else {
            self.titleLabel.isHidden = true
            return
        }
        
        self.titleLabel.isHidden = false
        
        self.titleLabel.text = title
        
 

        
        
    }
}
