import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .preferredColorScheme(.dark) // the design is dark only, so glass and system pieces always use their dark look
        }
    }
}
