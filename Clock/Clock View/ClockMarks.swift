
import SwiftUI

struct ClockMarks: View {
    
    private let relativeLength: CGFloat = 0.05
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<12) { n in
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width / 2, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width / 2, y: self.relativeLength * geometry.size.height))
                }
                .stroke(Color.secondary)
                .rotationEffect(Angle(degrees: Double(n) * 360 / 12))
            }
        }
    }
}
