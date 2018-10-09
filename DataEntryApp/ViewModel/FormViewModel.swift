//
//  FormViewModel.swift
//  DataEntryApp
//
//  Created by Administrator on 30/09/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import Foundation
import SimpleTwoWayBinding


struct FormViewModel {
    let reasonSelect: Observable<[String]> = Observable()
    let daySelect: Observable<String> = Observable()

    
    func getReasonString() -> String {
        
        if let reasonString = reasonSelect.value {
            return "\(String(describing: reasonString))"
        }
        return "--"
    }
    
    func getDayString() -> String {
        
        if let dayString = daySelect.value {
            return "\(String(describing: dayString))"
        }
        return "--"
    }
    
//    func getCommentString() -> String {
//        
//        if let commentString = comments.value {
//            return "\(String(describing: commentString))"
//        }
//        return "--"
//    }
}

