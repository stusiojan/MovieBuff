//
//  AddMovieView.swift
//  MovieBuff
//
//  Created by Jan Stusio on 27/03/2023.
//

import SwiftUI

struct AddMovieView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var director = ""
    @State private var genre = "Unknown"
    @State private var review = ""
    @State private var rating = 3
    
    let genres = ["Action", "Comedy", "Drama", "Fantasy", "Horror", "Mystery", "Romance", "Thriller", "Unknown", "Western"]
    
    var isValidated: Bool {
        if title.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of movie", text: $title)
                    TextField("Director's name", text: $director)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newMovie = Movie(context: moc)
                        newMovie.id = UUID()
                        newMovie.title = title
                        newMovie.director = director.trimmingCharacters(in: .whitespaces).isEmpty ? "Unknown": director
                        newMovie.genre = genre
                        newMovie.review = review
                        newMovie.rating = Int16(rating)
                        
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(isValidated == false)
                }
            }
            .navigationTitle("Add Movie")
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieView()
    }
}
