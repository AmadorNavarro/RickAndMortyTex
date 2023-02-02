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
    
    func sink<T1, T2>(_ publisher1: Published<T1>.Publisher, _ publisher2: Published<T2>.Publisher, _ fn: @escaping (T1, T2) -> Void) {
        
        let pointer = Unmanaged.passUnretained(self).toOpaque()
        var cancellables = objc_getAssociatedObject(self, pointer) as? [AnyCancellable] ?? [AnyCancellable]()
        
        publisher1
            .combineLatest(publisher2)
            .receive(on: DispatchQueue.main)
            .sink { fn($0, $1) }
            .store(in: &cancellables)

        objc_setAssociatedObject(self, pointer, cancellables, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }
    
}
