//
//  MockAsyncCall.swift
//  iosApp
//
//  Created by Sean Howard on 12/04/2022.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MockAsyncViewModel: ObservableObject {

    static private let dataSource: [String] = ["John", "Paul", "George", "Ringo"]
    private var tokens: Set<AnyCancellable> = []

    @Published var band = Band(id: UUID().uuidString)
    
    func load() {
        let delayPublisher = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect()
        let delayedValuesPublisher = Publishers.Zip(Self.dataSource.publisher, delayPublisher)
        
        delayedValuesPublisher.sink { [weak self] published in
            withAnimation {
                self?.band.members.append(Member(name: published.0))
            }
        }
        .store(in: &tokens)
    }
}

struct Band {
    var id: String
    var members = [Member]()
}

struct Member {
    var name: String
}
