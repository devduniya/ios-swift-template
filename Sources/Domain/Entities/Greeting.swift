/// A plain domain entity. No SwiftUI import, no Foundation networking —
/// the Domain layer knows nothing about how it is displayed or how the
/// data behind it is fetched.
struct Greeting {
    let message: String
}
