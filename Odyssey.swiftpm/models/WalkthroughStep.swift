enum WalkthroughStep: CaseIterable, Equatable {
    case first
    case second
    case third
    case fourth

    var message: TooltipMessage {
        switch self {
            case .first:
                .first
            case .second:
                .second
            case .third:
                .third
            case .fourth:
                .fourth
        }
    }

    var caretDirection: TooltipCaretDirection {
        switch self {
            case .first,
                 .second:
                .up
            case .third,
                 .fourth:
                .down
        }
    }

    var shouldAutoScroll: Bool {
        self == .third || self == .fourth
    }
}
