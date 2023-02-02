import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        
        Resolver.defaultScope = .application
        
        // App
        main.register { AppNavigator() as IAppNavigator }
        
        // Domain
        main.register { LoadCharactersUseCase(resolve()) as ILoadCharactersUseCase }
        
        // Data
        main.register { RequestFactory() as IRequestFactory }
        main.register { CharactersRepository(resolve()) as ICharactersRepository }
        
    }
    
}
