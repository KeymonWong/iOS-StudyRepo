//
//  LandmarkListView.swift
//  ListAndNavigation
//
//  Created by keymon on 2019/10/23.
//  Copyright © 2019 okay. All rights reserved.
//

import SwiftUI

struct LandmarkListView: View {
    /// This userData property gets its value automatically,
    /// as long as the environmentObject(_:) modifier has been applied to a parent.
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        /// You can make your data identifiable in one of two ways:
        /// by passing along with your data a key path to a property that uniquely identifies each element,
        /// or by making your data type conform to the Identifiable protocol.
        NavigationView {
            List {
                /// Just like on @State properties,
                /// you can access a binding to a member of the userData object by using the $ prefix.
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(userData.landmarks) { landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink(
                            /// 通过 environmentObject(_:) 在 view树 上传递数据
                            destination: LandmarkDetailView(landmark: landmark).environmentObject(self.userData)
                        ) {
                            LandmarkRowView(landmark: landmark)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Landmarks"))
        }
    }
}

#if DEBUG
struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkListView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}
#endif
