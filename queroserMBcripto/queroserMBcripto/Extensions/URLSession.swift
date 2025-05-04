//
//  URLSession.swift
//  queroserMBcripto
//
//  Created by Ely Assumpcao Ndiaye on 02/05/25.
//

import UIKit

extension URLSession {
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) -> URLSessionDataTask {
        let task = self.dataTask(with: url) { data, _, error in
            if let error = error {
                debugPrint("Failed to fetch image: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
        return task
    }
}
