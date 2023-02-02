import Foundation

struct CharactersResponse: Decodable {
    
    let pages: Int
    let results: [Character]
    
    enum CodingKeys: String, CodingKey {
        case info, results
    }
    
    enum InfoCodingKeys: String, CodingKey {
        case pages
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([Character].self, forKey: .results)
        
        let infoContainer = try container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info)
        pages = try infoContainer.decode(Int.self, forKey: .pages)
        
    }
    
}
