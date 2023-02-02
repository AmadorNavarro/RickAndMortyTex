import Combine

final class CharacterListModel {
    
    @Published var loadingPage = false
    @Published var characters: [Character] = []
    @Published var error: HttpError?
    @Published var currentPage = 0
    
    var hasMorePages = true
    
}
