//
//  SetupView.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import UIKit

protocol SetupView {
    func buildView()
    func setupHierarchy()
    func setupConstraints()
    func setupStyles()
    func configureView()
}

extension SetupView {
    func buildView() {
        setupHierarchy()
        setupConstraints()
        setupStyles()
    }

    func setupStyles() {}
    func configureView() {}
}


