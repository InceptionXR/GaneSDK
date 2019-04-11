//
//  GaneExperince.swift
//  EnexApp
//
//  Created by John MAClovich on 07/04/2019.
//  Copyright © 2019 Inception. All rights reserved.
//

import Foundation

struct UserResponce: Codable {
    let meta: [String:String]
    let experiences: [Experience]
}

public struct Experience: Codable {
    public let description: String
    public let video: String?
    public let tags: [String]
    public let name: String
    public let image: String
    public let userID: String
    public let id, createdAt, updatedAt: String
    public let published: Bool
    public let assetURL: String?
    public let price: Price?
    public let requests: [Request]
    public let limitations: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case description, video, tags, name, image
        case userID = "user_id"
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case published
        case assetURL = "asset_url"
        case price, requests, limitations
    }
}

public struct Price: Codable {
   public let amount: Int
    public let currency: String
}
public struct Request: Codable {
    let requestPublic, approved: Bool
    let editDate: JSONNull?
    let type, message: String
    let relatedTo: RelatedTo
    let initiatorID, id, createdAt, updatedAt: String
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case requestPublic = "public"
        case approved
        case editDate = "edit_date"
        case type, message
        case relatedTo = "related_to"
        case initiatorID = "initiator_id"
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

public struct Comment: Codable {
    let editDate: JSONNull?
    let isRead: Bool
    let message, requestID, userID, id: String
    let createdAt, updatedAt: String
    let user: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case editDate = "edit_date"
        case isRead = "is_read"
        case message
        case requestID = "request_id"
        case userID = "user_id"
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
}

public struct RelatedTo: Codable {
    let entity, id, ownerID: String
    
    enum CodingKeys: String, CodingKey {
        case entity, id
        case ownerID = "owner_id"
    }
}

public class JSONNull: Codable, Hashable {
    
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

