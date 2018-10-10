//
//  Helpers.swift
//  Chirpy
//
//  Created by Kymberlee Hill on 3/25/18.
//  Copyright © 2018 Kymberlee Hill. All rights reserved.
//

import UIKit

class Helpers: NSObject {

    static func makeImageCircular(with image: UIImageView) -> UIImageView {
        image.layer.cornerRadius = image.frame.size.height / 2
        image.clipsToBounds = true
        return image
    }
    
}
