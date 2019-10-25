//
//  UserData.swift
//  Essentials_SwiftUI
//
//  Created by keymon on 2019/10/25.
//  Copyright © 2019 olecx. All rights reserved.
//

import Foundation
import Combine

/// SwiftUI subscribes to your observable object,
/// and updates any views that need refreshing when the data changes.
final class UserData: ObservableObject {
    /// An observable object needs to publish any changes to its data,
    /// so that its subscribers can pick up the change.
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
