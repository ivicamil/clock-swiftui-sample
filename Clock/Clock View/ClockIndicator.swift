
import SwiftUI

struct ClockIndicator: View {
    
    enum `Type` {
        case hour
        case minute
        case second
        
        var color: Color {
            switch self {
            case .second: return .red
            default: return .primary
            }
        }
        
        var thickness: CGFloat {
            switch self {
            case .hour: return 6
            case .second: return 1
            case .minute: return 3
            }
        }
        
        var relativeLength: CGFloat {
            switch self {
            case .hour: return 0.6
            default: return 0.95
            }
        }
        
        func angle(for time: ClockModel) -> Angle {
            switch self {
            case .hour: return Angle(degrees: (360 / 12) * (Double(time.hours) + Double(time.minutes) / 60))
            case .minute: return Angle(degrees: Double(time.minutes) * 360 / 60)
            case .second: return Angle(degrees: Double(time.seconds) * 360 / 60)
            }
        }
        
        func baseRadiusFactor(for time: ClockModel) -> CGFloat {
            switch self {
            case .hour: return 0.1
            case .minute: return 0.1
            case .second: return 0.05
            }
        }
    }
    
    let type: `Type`
    
    let time: ClockModel
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let c = self.center(of: geometry.size)
                let baseRadius = 0.5 * self.type.baseRadiusFactor(for: self.time) * min(geometry.size.width, geometry.size.height)
                path.addArc(center: c, radius: baseRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
            }
            .fill(self.type.color)
            Path { path in
                let c = self.center(of: geometry.size)
                path.move(to: c)
                path.addLine(to: CGPoint(x: c.x, y: c.y - self.type.relativeLength * self.radius(for: geometry.size)))
            }
            .stroke(style: StrokeStyle(lineWidth: self.type.thickness, lineCap: .round))
            .fill(self.type.color)
            .rotationEffect(self.type.angle(for: self.time))
        }
    }
    
    private func center(of size: CGSize) -> CGPoint {
        return CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    private func radius(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) / 2
    }
}

