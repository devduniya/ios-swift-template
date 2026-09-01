import SwiftUI

/// The "V" in MVVM. Only reads `@Published` state from the ViewModel and
/// calls its methods — it never touches a use case or repository.
struct ContentView: View {
    @StateObject private var viewModel = GreetingViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("MyApp")
                .font(.largeTitle)
                .bold()

            Text(viewModel.greeting ?? "No greeting yet")
                .font(.body)
                .foregroundColor(.secondary)

            Button("Refresh") {
                viewModel.refresh()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            viewModel.refresh()
        }
    }
}

#Preview {
    ContentView()
}
