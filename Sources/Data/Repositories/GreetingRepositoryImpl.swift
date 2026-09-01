import Foundation

/// Concrete implementation of `GreetingRepository`.
///
/// This intentionally does NOT make a real network call — it returns a
/// static local greeting after a trivial `Task.sleep` that simulates
/// asynchronous work. Swap this out for a real networking client (with
/// its own request/response models) when you build a real feature; keep
/// that networking code confined to the Data layer.
final class GreetingRepositoryImpl: GreetingRepository {
    func getGreeting() async -> Greeting {
        try? await Task.sleep(nanoseconds: 300_000_000)
        return Greeting(message: "Hello from the Data layer!")
    }
}
