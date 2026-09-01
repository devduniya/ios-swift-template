/// Wraps a single repository call behind an intention-revealing name.
/// ViewModels call use cases, never repositories, directly.
struct GetGreetingUseCase {
    private let repository: GreetingRepository

    init(repository: GreetingRepository) {
        self.repository = repository
    }

    func execute() async -> Greeting {
        await repository.getGreeting()
    }
}
