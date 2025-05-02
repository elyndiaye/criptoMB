//
//  Helper.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}


extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}

extension NumberFormatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        return formatter
    }()
    
    func string(fromValue value: Double) -> String {
        switch value {
        case 1_000_000_000_000...:
            return "\(string(from: NSNumber(value: value/1_000_000_000_000)) ?? "0") T"
        case 1_000_000_000...:
            return "\(string(from: NSNumber(value: value/1_000_000_000)) ?? "0") B"
        case 1_000_000...:
            return "\(string(from: NSNumber(value: value/1_000_000)) ?? "0") M"
        case 1_000...:
            return "\(string(from: NSNumber(value: value/1_000)) ?? "0") K"
        default:
            return string(from: NSNumber(value: value)) ?? "0"
        }
    }
}
