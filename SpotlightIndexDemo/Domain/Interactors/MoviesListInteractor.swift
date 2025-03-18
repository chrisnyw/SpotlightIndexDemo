//
//  MoviesListInteractor.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import Foundation

protocol MoviesListInteractorProtocol {
    func getMoviesList() async -> [Movie]
    func getMovie(from spotlightMovieId: String) async -> Movie?
}

final class MoviesListInteractor: MoviesListInteractorProtocol {
    func getMoviesList() async -> [Movie] {
        var movies: [Movie] = []
        movies.append(
            Movie(
                id: UUID(uuidString: "86D17D90-5CFC-45A7-A2CC-7D43FCDC2490")!,
                title: "Sonic the Hedgehog 3 (2024)",
                image: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg",
                duration: "1h 50m",
                category: "Action, Science Fiction, Comedy, Family",
                rating: "7.7",
                description: "Sonic, Knuckles, and Tails reunite against a powerful new adversary, Shadow, a mysterious villain with powers unlike anything they have faced before. With their abilities outmatched in every way, Team Sonic must seek out an unlikely alliance in hopes of stopping Shadow and protecting the planet."
            )
        )
        movies.append(
            Movie(
                id: UUID(uuidString: "7D4C0919-7BDE-438E-8EF7-908EB92843D5")!,
                title: "Moana 2 (2024)",
                image: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
                duration: "1h 39m",
                category: "Animation, Adventure, Family, Comedy",
                rating: "7.2",
                description: "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced."
            )
        )
        movies.append(
            Movie(
                id: UUID(uuidString: "6A3CFC41-E3CD-441E-9523-8A9BA529A935")!,
                title: "Inside Out 2 (2024)",
                image: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
                duration: "1h 37m",
                category: "Animation, Adventure, Comedy, Family",
                rating: "7.6",
                description: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone."
            )
        )
        return movies
    }
    
    func getMovie(from spotlightMovieId: String) async -> Movie? {
        return await self.getMoviesList().first(where: { $0.indexingUniqueIdentifier == spotlightMovieId })
    }
}
