//
//  LandmarkDetailView.swift
//  ListAndNavigation
//
//  Created by keymon on 2019/10/23.
//  Copyright © 2019 olecx. All rights reserved.
//

import SwiftUI

struct LandmarkDetailView: View {
    @EnvironmentObject var userData: UserData
    var landmark: Landmark
    
    var landmarkIndex: Int {
        userData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        VStack {
            MapView(coor: landmark.locationCoor)
                .frame(height: 300)
                .edgesIgnoringSafeArea(.top)
            
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                        .foregroundColor(.red)
                    
                    Button(action: {
                        self.userData.landmarks[self.landmarkIndex].isFavorite.toggle()
                    }) {
                        if self.userData.landmarks[self.landmarkIndex].isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                
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

#if DEBUG
struct LandmarkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return LandmarkDetailView(landmark: userData.landmarks[0]).environmentObject(userData)
    }
}
#endif
