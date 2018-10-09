//
//  InputDataModel.swift
//  DataEntryApp
//
//  Created by Ravikumar Bukka on 29/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation



public typealias DataEntry = [DataEntryElement]

public struct DataEntryElement: Codable {
    let questions: String
    let answers, reasonSelect, daySelect: [String]
    
//    let reasonSelect: Observable<[String]> = Observable()
//    let daySelect: Observable<[String]> = Observable()
    
    enum CodingKeys: String, CodingKey {
        case questions = "Questions"
        case answers = "Answers"
        case reasonSelect = "ReasonSelect"
        case daySelect = "DaySelect"
    }
}

//struct FormViewModel {
//    let reasonSelect: Observable<[String]> = Observable()
//    let daySelect: Observable<[String]> = Observable()
//}
