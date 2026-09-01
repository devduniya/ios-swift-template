/// The Domain layer only depends on this protocol, never on a concrete
/// implementation. The Data layer provides the implementation.
protocol GreetingRepository {
    func getGreeting() async -> Greeting
}
