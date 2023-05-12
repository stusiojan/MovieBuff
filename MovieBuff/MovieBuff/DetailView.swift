//
//  DetailView.swift
//  MovieBuff
//
//  Created by Jan Stusio on 28/03/2023.
//

import SwiftUI

struct DetailView: View {
    let movie: Movie
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottom) {
                Image(movie.genre ?? "Unknown")
                    .resizable()
                    .scaledToFit()
                
                Text(movie.genre?.uppercased() ?? "UNKNOWN")
                    .font(.caption)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .offset(x: -5, y: -5)
            }
            
            Text("director: \(movie.director ?? "Unknown director")")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(movie.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(movie.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(movie.title ?? "Unknown movie")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete movie?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteMovie)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this movie", systemImage: "trash")
            }
        }
    }
    
    func deleteMovie() {
        moc.delete(movie)
        //some more
        dismiss()
    }
}

//Core Data combined with assets in previews are horrible
