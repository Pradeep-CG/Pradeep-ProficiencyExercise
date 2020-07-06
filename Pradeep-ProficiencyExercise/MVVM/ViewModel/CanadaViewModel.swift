//
//  CanadaViewModel.swift
//  Pradeep-ProficiencyExercise
//
//  Created by Pradeep on 07/07/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import Foundation

class CanadaViewModel {
    var httpUtility: HttpUtility = HttpUtility()
    var canadaList: CanadaModel?
    typealias ComplitionBlock = (CanadaModel, Bool) -> Void
    func getDataFromApi(apiUrl: String, complitionBlock:@escaping (ComplitionBlock)) {
        if Reachability.isConnectedToNetwork() {
            // make api call
            httpUtility.getApiData(requestUrl: Constants.apiString, resultType: CanadaModel.self, completionHandler: { (canadaResponse) in
                self.canadaList = canadaResponse
                complitionBlock(canadaResponse, true)
                //debugPrint("response = \(String(describing: self.canadaList))")
            })
        } else {
            complitionBlock(CanadaModel(title: "", rows: [CanadaRowModel(title: nil, rowDescription: nil, imageHref: nil)]), false)
        }
    }
    func getNumberOfRows() -> Int {
        return canadaList?.rows.count ?? 0
    }

}
