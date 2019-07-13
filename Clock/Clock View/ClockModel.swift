
import Foundation

struct ClockModel {
    
    let hours: Int
    
    let minutes: Int
    
    let seconds: Int
    
    init(date: Date) {
        let calendar = Calendar.current
        let now = Date()
        let hours = calendar.component(.hour, from: now)
        self.hours = hours <= 12 ? hours : hours - 12
        minutes = calendar.component(.minute, from: now)
        seconds = calendar.component(.second, from: now)
    }
}
