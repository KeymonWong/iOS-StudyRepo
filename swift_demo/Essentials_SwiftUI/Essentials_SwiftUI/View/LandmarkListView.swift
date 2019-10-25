//
//  LandmarkListView.swift
//  ListAndNavigation
//
//  Created by keymon on 2019/10/23.
//  Copyright © 2019 olecx. All rights reserved.
//

import SwiftUI

struct LandmarkListView: View {
    var body: some View {
        /// You can make your data identifiable in one of two ways: by passing along with your data a key path to a property that uniquely identifies each element, or by making your data type conform to the Identifiable protocol.
        NavigationView {
            List(landmarkData) { landmark in
                NavigationLink(destination: LandmarkDetailView(landmark: landmark)) {
                    LandmarkRowView(landmark: landmark)
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
    }
}
#endif
