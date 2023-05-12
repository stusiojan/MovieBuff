//
//  ContentView.swift
//  MovieBuff
//
//  Created by Jan Stusio on 24/03/2023.
//

import SwiftUI
import RiveRuntime

struct backgroundShapes: View {
    var body: some View {
        RiveViewModel(fileName: "shapesmoviebuff").view()
            .ignoresSafeArea()
            .blur(radius: 20)
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.rating, order: .reverse),
        //SortDescriptor(\.directior) why does it not work!!!
    ]) var movies: FetchedResults<Movie>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundShapes()
                
                List {
                    ForEach(movies) { movie in
                        NavigationLink {
                            DetailView(movie: movie)
                        } label: {
                            HStack{
                                VisualRatingView(rating: movie.rating)
                                    .font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    Text(movie.title ?? "Unknown title")
                                        .font(.headline)
                                    
                                    Text(movie.director ?? "Unknown director")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .listRowBackground(movie.rating == 1 ? Color.red.opacity(0.5) : Color.white.opacity(0.1))
                    }
                    .onDelete(perform: deleteMovies)
                }
                .listStyle(.plain)
            }
            .navigationTitle("MovieBuff")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Movie", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddMovieView()
            }
        }
    }
    
    func deleteMovies(at offsets: IndexSet) {
        for offset in offsets {
            let movie = movies[offset]
            moc.delete(movie)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
