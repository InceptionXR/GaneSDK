// To parse the JSON, add this file to your project and do:
//
//   let userResponce = try? newJSONDecoder().decode(UserResponce.self, from: jsonData)

import Foundation

public typealias UserResponce = [Experience]

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
    let amount: Int
    let currency: Currency
}

public enum Currency: String, Codable {
    case eur = "eur"
    case gbp = "gbp"
    case usd = "usd"
}

public struct Request: Codable {
    let requestPublic, approved: Bool
    let editDate: JSONNull?
    let type, message: String
    let relatedTo: RelatedTo
    let initiatorID, id, createdAt, updatedAt: String
    
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
    }
}

public struct RelatedTo: Codable {
    let entity, id, ownerID: String
    
    enum CodingKeys: String, CodingKey {
        case entity, id
        case ownerID = "owner_id"
    }
}

// MARK: Encode/decode helpers

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
