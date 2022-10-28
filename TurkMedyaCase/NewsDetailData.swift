//
//  NewsDetailData.swift
//  TurkMedyaCase
//
//  Created by Rukiye Şentürk on 27.10.2022.
//

import Foundation

// MARK: - NewsDetail
struct NewsDetailData: Codable {
    let errorCode: Int
    let errorMessage: JSONNull?
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let headerAd: ErAd
    let newsDetail: NewsDetailClass
    let footerAd: ErAd
    let multimedia: Multimedia
    let itemList: [Video]
    let relatedNews: RelatedNews
    let video: Video
    let photoGallery: PhotoGallery
}

// MARK: - ErAd
struct ErAd: Codable {
    let itemType, adUnit: String
    let itemWidth, itemHeight: Int
}

// MARK: - Video
struct Video: Codable {
    let itemList: JSONNull?
    let itemID, title: String
    let imageURL: String
    let itemType: String
    let titleVisible: Bool
    let shortText, bodyText: String?
    let videoURL: String?

    enum CodingKeys: String, CodingKey {
        case itemList
        case itemID = "itemId"
        case title
        case imageURL = "imageUrl"
        case itemType, titleVisible, shortText, bodyText
        case videoURL = "videoUrl"
    }
}

// MARK: - Multimedia
struct Multimedia: Codable {
    let sectionType, repeatType: String
    let itemCountInRow: Int
    let lazyLoadingEnabled, titleVisible: Bool
    let title, titleColor, titleBgColor, sectionBgColor: JSONNull?
}

// MARK: - NewsDetailClass
struct NewsDetailClass: Codable {
    let resource, bodyText: String
    let hasPhotoGallery, hasVideo: Bool
    let publishDate: String
    let fullPath: String
    let shortText: String
    let category: Category
    let itemID, title, video: String
    let imageURL: String
    let itemType: String

    enum CodingKeys: String, CodingKey {
        case resource, bodyText, hasPhotoGallery, hasVideo, publishDate, fullPath, shortText, category
        case itemID = "itemId"
        case title, video
        case imageURL = "imageUrl"
        case itemType
    }
}

// MARK: - Category
struct CategoryDetail: Codable {
    let categoryID, title, slug: String
    let color: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case title, slug, color
    }
}

// MARK: - PhotoGallery
struct PhotoGallery: Codable {
    let itemList: JSONNull?
    let itemID, title: String
    let imageURL: String
    let itemType: String
    let titleVisible: Bool

    enum CodingKeys: String, CodingKey {
        case itemList
        case itemID = "itemId"
        case title
        case imageURL = "imageUrl"
        case itemType, titleVisible
    }
}

// MARK: - RelatedNews
struct RelatedNews: Codable {
    let hasPhotoGallery, hasVideo: Bool
    let publishDate, shortText: String
    let category: CategoryDetail
    let itemID, title: String
    let imageURL: String
    let itemType: String
    let titleVisible: Bool

    enum CodingKeys: String, CodingKey {
        case hasPhotoGallery, hasVideo, publishDate, shortText, category
        case itemID = "itemId"
        case title
        case imageURL = "imageUrl"
        case itemType, titleVisible
    }
}

// MARK: - Encode/decode helpers

class JSONNullDetail: Codable, Hashable {

    public static func == (lhs: JSONNullDetail, rhs: JSONNullDetail) -> Bool {
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
