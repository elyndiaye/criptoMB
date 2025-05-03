//
//  CriptoListCellViewModel.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import UIKit

class CriptoListCellViewModel {

    // MARK: - Properties
    private var task: URLSessionDataTask?
    static private var imageCache: [URL: UIImage] = [:]

    let name: String
    let id: String
    let dailyVolumeUsdText: String
    var exchangeIconURL: URL?
    var exchangeIconImage: UIImage? {
        didSet {
            onLogoImageUpdated?(exchangeIconImage)
        }
    }
    var hasAttemptedToDownloadImage: Bool = false
    var onLogoImageUpdated: ((UIImage?) -> Void)?

    // MARK: - Initializers
    init(from model: ExchangeModel, imageUrl: URL?) {
        name = model.name ?? "Não encontrado"
        id = "Id: \(model.exchangeId ?? "Desconhecido")"

        let volume = model.volume1dayUsd ?? 0
        dailyVolumeUsdText = NumberFormatter.currency.string(fromValue: volume)

        exchangeIconURL = imageUrl
        exchangeIconImage = CriptoListCellViewModel.cachedImage(for: imageUrl) ?? UIImage(systemName: "house", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: Spacing.space7)))
    }

    // MARK: - Image Handling
    func fetchImage(from imageUrl: URL?) {
        guard let imageUrl = imageUrl else { return }

        if let cachedImage = CriptoListCellViewModel.imageCache[imageUrl] {
            self.exchangeIconImage = cachedImage
            return
        }

        task = URLSession.shared.fetchImage(from: imageUrl) { [weak self] image in
            if let image = image {
                CriptoListCellViewModel.imageCache[imageUrl] = image
            }
            self?.exchangeIconImage = image
        }
    }

    func cancelImageDownload() {
        task?.cancel()
    }

    // MARK: - Private Helpers
    static private func cachedImage(for url: URL?) -> UIImage? {
        guard let url = url else { return nil }
        return imageCache[url]
    }
}

