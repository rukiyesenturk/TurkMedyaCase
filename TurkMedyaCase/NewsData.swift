//
//  News.swift
//  TurkMedyaCase
//
//  Created by Rukiye Şentürk on 27.10.2022.
//

import Foundation

// MARK: - News
struct NewsData: Codable {
    let errorCode: Int
    let errorMessage: JSONNull?
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let sectionType, repeatType: String
    let itemCountInRow: Int
    let lazyLoadingEnabled, titleVisible: Bool
    let title: String?
    let titleColor: JSONNull?
    let titleBgColor, sectionBgColor: String
    let itemList: [ItemList]
    let totalRecords: Int?
}

// MARK: - ItemList
struct ItemList: Codable {
    let hasPhotoGallery, hasVideo, titleVisible: Bool
    let fLike: ColumnistName
    let publishDate, shortText: String
    let fullPath: String?
    let category: Category
    let videoURL: ColumnistName
    let externalURL: String
    let columnistName: ColumnistName
    let itemID, title: String
    let imageURL: String
    let itemType: ItemType

    enum CodingKeys: String, CodingKey {
        case hasPhotoGallery, hasVideo, titleVisible, fLike, publishDate, shortText, fullPath, category
        case videoURL = "videoUrl"
        case externalURL = "externalUrl"
        case columnistName
        case itemID = "itemId"
        case title
        case imageURL = "imageUrl"
        case itemType
    }
}

// MARK: - Category
struct Category: Codable {
    let categoryID, title, slug: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case title, slug
    }
}

enum ColumnistName: String, Codable {
    case columnistName = "\""
    case empty = ""
}

enum ItemType: String, Codable {
    case externalContent = "EXTERNAL_CONTENT"
    case news = "NEWS"
    case photoGallery = "PHOTO_GALLERY"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
