//
//  UserViewModel.swift
//  iosApp
//
//  Created by Sean Howard on 12/04/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation

class UserViewModel: ObservableObject {
    
    var username: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
}
