//
//  MoviesModel.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import Foundation

struct Movie: Identifiable, Hashable {
    let id: UUID
    let title, image, duration, category, rating, description: String
    
    init(id: UUID = UUID(), title: String, image: String, duration: String, category: String, rating: String, description: String) {
        self.id = id
        self.title = title
        self.image = image
        self.duration = duration
        self.category = category
        self.rating = rating
        self.description = description
    }
}
