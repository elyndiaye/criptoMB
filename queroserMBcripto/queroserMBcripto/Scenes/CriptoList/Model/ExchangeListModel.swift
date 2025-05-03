//
//  ExchangeListModel.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import Foundation

protocol ExchangeListDisplay { }

struct ExchangeModel: Decodable, Equatable, ExchangeListDisplay {
    let name: String?
    let exchangeId: String?
    let website: String?
    let volume1hrsUsd: Double?
    let volume1dayUsd: Double?
    let volume1mthsUsd: Double?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case exchangeId = "exchange_id"
        case website = "website"
        case volume1hrsUsd = "volume_1hrs_usd"
        case volume1dayUsd = "volume_1day_usd"
        case volume1mthsUsd = "volume_1mth_usd"
    }
}

struct ExchangeImageModel: Decodable, Equatable {
    let exchangeId: String?
    let url: URL?
}

