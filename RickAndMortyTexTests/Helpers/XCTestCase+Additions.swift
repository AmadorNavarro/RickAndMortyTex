import XCTest

extension XCTestCase {
    
    func waitUntil(_ timeout: TimeInterval, _ condition: () -> Bool, file: StaticString = #file, line: UInt = #line) {
    
        let start = DispatchTime.now()

        while !condition() {
    
            let elapsed = DispatchTime.now().uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(elapsed) / 1_000_000_000
    
            if timeInterval > timeout {
                continueAfterFailure = false
                XCTFail("Timeout without fulfilled condition")
            }
    
            Thread.sleep(forTimeInterval: 0.001)
    
        }
    
    }
    
    func waitRunLoopUntil(_ timeout: TimeInterval = 0.9, _ condition: () -> Bool, file: StaticString = #file, line: UInt = #line) {
    
        let start = DispatchTime.now()
        RunLoop.current.run(until: Date())

        while !condition() {
    
            let elapsed = DispatchTime.now().uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(elapsed) / 1_000_000_000
    
            if timeInterval > timeout {
                continueAfterFailure = false
                XCTFail("Timeout without fulfilled condition")
            }
    
            Thread.sleep(forTimeInterval: 0.001)
            RunLoop.current.run(until: Date())
    
        }
    
    }
    
}
