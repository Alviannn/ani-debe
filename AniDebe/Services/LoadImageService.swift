//
//  LoadImageService.swift
//  AniDebe
//
//  Created by prk on 13/01/23.
//

import Foundation
import UIKit

func loadImageFromUrl(rawUrl: String, onComplete: @escaping (UIImage?, Error?) -> Void) {
    guard let url = URL(string: rawUrl) else { return }
    URLSession.shared.dataTask(with: url) { data, _, err in
        if err != nil {
            onComplete(nil, err)
            return
        }
        
        guard let imageData = data else { return }

        DispatchQueue.main.async {
            let image = UIImage(data: imageData)
            onComplete(image, nil)
        }
    }.resume()
}
