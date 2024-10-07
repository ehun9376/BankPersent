//
//  extension.swift
//  Percent
//
//  Created by 陳逸煌 on 2024/10/7.
//

import Foundation
import UIKit


extension Collection {
    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
