import Foundation
import Combine

protocol BindableView: AnyObject {
    
}

extension BindableView {
    
    func sink<T>(_ publisher: Published<T>.Publisher, _ fn: @escaping (T) -> Void) {
        
        let pointer = Unmanaged.passUnretained(self).toOpaque()
        var cancellables = objc_getAssociatedObject(self, pointer) as? [AnyCancellable] ?? [AnyCancellable]()
        
        publisher
            .receive(on: DispatchQueue.main)
            .sink { fn($0) }
            .store(in: &cancellables)
        
        objc_setAssociatedObject(self, pointer, cancellables, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    
}
