//
//  Badge.swift
//  DrawAndAnimation_SwiftUI
//
//  Created by keymon on 2019/10/25.
//  Copyright © 2019 olecx. All rights reserved.
//

import SwiftUI

struct Badge: View {
    static let rotationCount = 8
    
    var badgeSymbols: some View {
        ForEach(0 ..< Self.rotationCount) { i in
            RotatedBadgeSymbol(angle: .degrees(Double(i) / Double(Self.rotationCount)) * 360.0)
        }
        .opacity(0.5)
    }
    
    var body: some View {
        ZStack {
            BadgeBackground()
            
            GeometryReader { geo in
                self.badgeSymbols
                    .scaleEffect(1.0 / 4.0, anchor: .top)
                    .position(x: geo.size.width / 2.0, y: (3.0 / 4.0) * geo.size.height)
            }
        }
        .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
