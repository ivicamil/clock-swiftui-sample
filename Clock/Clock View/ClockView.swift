
import SwiftUI
import Combine

struct ClockView : View {
    
    @State(initialValue: ClockModel(date: Date()))
    private var time: ClockModel
    
    @State
    private var timerSubscription: Cancellable? = nil
    
    private let hourPointerBaseRadius: CGFloat = 0.1
    
    private let secondPointerBaseRadius: CGFloat = 0.05
    
    var body: some View {
        ZStack {
            Circle().stroke(Color.primary)
            ClockMarks()
            ClockIndicator(type: .hour, time: time)
            ClockIndicator(type: .minute, time: time)
            ClockIndicator(type: .second, time: time)
        }
        .padding()
        .aspectRatio(1, contentMode: .fit)
        .onAppear { self.subscribe() }
        .onDisappear { self.unsubscribe() }
    }
    
    private func subscribe() {
        timerSubscription =
            Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .map(ClockModel.init)
            .assign(to: \.time, on: self)
    }
    
    private func unsubscribe() {
        timerSubscription?.cancel()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
#endif
