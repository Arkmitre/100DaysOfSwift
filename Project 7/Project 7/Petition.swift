//
//  Petition.swift
//  Project 7
//
//  Created by Alexander on 20/08/2024.
//  Copyright © 2024 Alexander Khorkov. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
