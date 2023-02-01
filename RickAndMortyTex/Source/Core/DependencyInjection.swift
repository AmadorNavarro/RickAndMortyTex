import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        
        Resolver.defaultScope = .application
        
        // Data
        main.register { RequestFactory() }
        
    }
    
}
