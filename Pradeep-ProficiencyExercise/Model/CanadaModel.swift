//
//  CanadaModel.swift
//  Pradeep-ProficiencyExercise
//
//  Created by Pradeep on 03/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import Foundation
// MARK: - Canada
struct CanadaModel: Decodable {
    let title: String
    let rows: [CanadaRowModel]
}

// MARK: - CanadaRowModel
struct CanadaRowModel: Decodable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
