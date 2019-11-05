//
//  HikeView.swift
//  DrawAndAnimation_SwiftUI
//
//  Created by keymon on 2019/11/5.
//  Copyright © 2019 olecx. All rights reserved.
//

import SwiftUI

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        HikeView(hike: hikeData[0])
    }
}
