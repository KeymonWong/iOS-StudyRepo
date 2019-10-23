//
//  LandmarkDetailView.swift
//  ListAndNavigation
//
//  Created by keymon on 2019/10/23.
//  Copyright © 2019 olecx. All rights reserved.
//

import SwiftUI

struct LandmarkDetailView: View {
    var landmark: Landmark
    
    var body: some View {
        VStack {
            MapView(coor: landmark.locationCoor)
                .frame(height: 300)
                .edgesIgnoringSafeArea(.top)
            
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                    .foregroundColor(.red)
                HStack(alignment: .top) {
                    Text(landmark.park)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(landmark.state)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(Color.green)
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle(Text(landmark.name), displayMode: .inline)
    }
}

struct LandmarkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetailView(landmark: landmarkData[0])
    }
}
