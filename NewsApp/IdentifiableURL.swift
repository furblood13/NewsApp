//
//  IdentifiableURL.swift
//  NewsApp
//
//  Created by Furkan buğra karcı on 19.08.2024.
//

import Foundation

struct IdentifiableURL: Identifiable {
    let id = UUID() // Bu id, her bir IdentifiableURL nesnesi için benzersiz olacak
    let url: URL
}
