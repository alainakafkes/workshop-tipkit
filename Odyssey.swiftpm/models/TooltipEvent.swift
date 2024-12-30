import Foundation

struct TooltipEvent {
    enum Kind {
        case seen
        case next
        case done
    }

    let kind: Kind
    let message: TooltipMessage
}
