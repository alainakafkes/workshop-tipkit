import Foundation

/// A type of interaction that a user has with the tooltip.
struct TooltipEvent {
    enum Kind {
        case seen
        case next
        case done
    }

    let kind: Kind
    let message: TooltipMessage
}
