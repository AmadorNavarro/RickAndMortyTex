import Foundation

extension Date {
    
    var noTimeFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMMM yyyy"
        return formatter.string(from: self)
    }
    
}

