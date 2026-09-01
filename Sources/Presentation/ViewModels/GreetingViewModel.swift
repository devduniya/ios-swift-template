import Foundation

/// The "VM" in MVVM. Owns a use case, publishes state for the View to
/// read, and never exposes the use case or repository to the View.
@MainActor
final class GreetingViewModel: ObservableObject {
    @Published var greeting: String?

    private let getGreetingUseCase: GetGreetingUseCase

    init(getGreetingUseCase: GetGreetingUseCase = GetGreetingUseCase(repository: GreetingRepositoryImpl())) {
        self.getGreetingUseCase = getGreetingUseCase
    }

    func refresh() {
        Task {
            let result = await getGreetingUseCase.execute()
            greeting = result.message
        }
    }
}
