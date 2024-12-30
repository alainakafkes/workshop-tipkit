struct TooltipMessage: Identifiable, Hashable, Equatable {
    var id: String { title }

    enum Action: String {
        case done
        case next

        var buttonText: String {
            rawValue.capitalized(with: .current)
        }
    }

    let title: String
    let subtitle: String
    let action: Action
    let messageIndex: Int
}

extension TooltipMessage {
    static let first = TooltipMessage(
        title: "Welcome to your odyssey",
        subtitle: "Let me know if you need me to crack any skulls we need evergreen content we want to empower the team with the right tools.",
        action: .next,
        messageIndex: 1
    )

    static let second = TooltipMessage(
        title: "Here's how to get started",
        subtitle: "Eat our own dog food this is meaningless, or forcing function , and gain traction, for collaboration through advanced technlogy.",
        action: .next,
        messageIndex: 2
    )

    static let third = TooltipMessage(
        title: "We scrounged these up for you",
        subtitle: "Not a hill to die on rehydrate the team we have put the apim bol, temporarily.",
        action: .next,
        messageIndex: 3
    )

    static let fourth = TooltipMessage(
        title: "Home in on what helped others",
        subtitle: "Gain traction. Lose client to 10:00 meeting. High performance keywords.",
        action: .done,
        messageIndex: 4
    )
}
