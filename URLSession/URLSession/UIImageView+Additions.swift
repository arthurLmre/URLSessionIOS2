//
//  UIImageView+Additions.swift
//  URLSession
//
//  Created by lpiem on 13/03/2020.
//  Copyright © 2020 lpiem. All rights reserved.
//

import UIKit

extension UIImageView {
    func image(from url: URL, completion: ((UIImage?) -> Void)? = nil) {
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard
                error == nil,
            let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode),
                let data = data else {
                    completion?(nil)
                    return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                completion?(self.image)
            }
        }
        task.resume() //Si pas cette ligne la request ne sera jamais envoyé
    }
}
