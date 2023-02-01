import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        
        Resolver.defaultScope = .application
        
        // Domain
        main.register { LoadCharactersUseCase(resolve()) as ILoadCharactersUseCase }
        
        // Data
        main.register { RequestFactory() as IRequestFactory }
        main.register { CharactersRepository(resolve()) as ICharactersRepository }
        
    }
    
}
