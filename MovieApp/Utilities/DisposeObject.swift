//
//  File.swift
//  MovieApp
//
//  Created by Amr Moheb on 08/03/2024.
//

import Foundation
import Combine

class DisposeObject {
    var deinitCalled: (() -> Void)?
    var cancellables: Set<AnyCancellable>

    init() {
        self.cancellables = Set<AnyCancellable>()
    }

    deinit {
        self.cancellables.removeAll()
        deinitCalled?()
    }
}
