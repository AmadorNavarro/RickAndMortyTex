@testable import RickAndMortyTex
import Foundation

final class FileLoader {
    
    func loadFile(name: String) -> Data {
        let url = Bundle(for: type(of: self)).url(forResource: name, withExtension: ".json")!
        let json = try! String(contentsOf: url)
        return json.data(using: .utf8)!
    }
    
}
