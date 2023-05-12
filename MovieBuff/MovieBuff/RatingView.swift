//
//  RatingView.swift
//  MovieBuff
//
//  Created by Jan Stusio on 27/03/2023.
//

import SwiftUI
//import RiveRuntime

struct RatingView: View {
    @Binding var rating : Int //will be passed externally
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
//    let starrating = RiveViewModel(fileName: "rating-stars", animationName: "\(rating)_star", autoPlay: false)
    
    var body: some View {
        HStack {
            //starrating.view()
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
