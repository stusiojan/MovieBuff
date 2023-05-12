//
//  VisualRatingView.swift
//  MovieBuff
//
//  Created by Jan Stusio on 27/03/2023.
//

import SwiftUI

struct VisualRatingView: View {
    let rating: Int16
    
    var body: some View {
        switch rating {
        case 1:
            Text("🫣")
        case 2:
            Text("🫠")
        case 3:
            Text("😶")
        case 4:
            Text("☺️")
        default:
            Text("🥹")
        }
    }
}

struct VisualRatingView_Previews: PreviewProvider {
    static var previews: some View {
        VisualRatingView(rating: 3)
    }
}
