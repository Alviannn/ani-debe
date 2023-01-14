//
//  URLSession+LoadImage.swift
//  AniDebe
//
//  Created by prk on 14/01/23.
//

import Foundation
import UIKit

extension URLSession {
    
    func loadUIImage(rawUrl: String, onComplete: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        let url = URL(string: rawUrl)!
        
        return URLSession.shared.dataTask(with: url) { data, _, err in
            if err != nil {
                onComplete(nil, err)
                return
            }
            
            onComplete(data, nil)
        }
    }
    
}
