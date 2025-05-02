//
//  Colors.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import UIKit

enum Colors {
    case black
    case gray
    case red

    var color: UIColor {
        switch self {
        case .black:
            return UIColor(red: 0.07, green: 0.07, blue: 0.08, alpha: 1.00)
        case .gray:
            return UIColor(red: 0.11, green: 0.12, blue: 0.13, alpha: 1.00)
        case .red:
            return UIColor(red: 0.62, green: 0.48, blue: 0.52, alpha: 1.00)
        }
    }
}
