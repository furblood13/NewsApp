//
//  NewsModel.swift
//  NewsApp
//
//  Created by Furkan buğra karcı on 18.08.2024.
//

import Foundation

struct NewsResponce: Codable {
    let success: Bool
    let result: [News]?
}


struct News: Codable, Identifiable {
    var id = UUID() // Bu alan otomatik olarak UUID ile doldurulur.
    
    let key: String
    let url: String
    let description: String
    let image: String
    let name, source: String

    // id'yi JSON'dan hariç tutmak için CodingKeys enum'u ekliyoruz
    private enum CodingKeys: String, CodingKey {
        case key, url, description, image, name, source
    }
}

