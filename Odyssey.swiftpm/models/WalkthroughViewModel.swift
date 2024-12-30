import Combine
import Foundation
import SwiftUI

@MainActor
final class WalkthroughViewModel: ObservableObject {
    private let allSteps: [WalkthroughStep]

    private var stepIndex: Int

    @Published
    private(set) var currentStep: WalkthroughStep

    let onEvent: PassthroughSubject<TooltipEvent, Never> = .init()

    var scrollProxy: ScrollViewProxy?

    @Published
    private(set) var atHomeRecommendationsSectionTitleGlobalY: CGFloat?
    func setAtHomeRecommendationsSectionTitleGlobalY(_ newValue: CGFloat) {
        DispatchQueue.main.async {
            self.atHomeRecommendationsSectionTitleGlobalY = newValue
        }
    }

    @Published
    private(set) var topRecommendationsEyebrowGlobalY: CGFloat?
    func setTopRecommendationsEyebrowGlobalY(_ newValue: CGFloat) {
        DispatchQueue.main.async {
            self.topRecommendationsEyebrowGlobalY = newValue
        }
    }

    @Published
    private(set) var headerViewGlobalMaxY: CGFloat?
    func setHeaderViewGlobalMaxY(_ newValue: CGFloat) {
        DispatchQueue.main.async {
            self.headerViewGlobalMaxY = newValue
        }
    }

    var currentMessage: TooltipMessage {
        currentStep.message
    }

    init(
        startIndex: Int = 0,
        steps: [WalkthroughStep] = WalkthroughStep.allCases
    ) {
        stepIndex = startIndex
        allSteps = steps
        currentStep = steps[stepIndex]
    }

    func handle(action: TooltipMessage.Action) {
        switch action {
            case .done:
                finish()
            case .next:
                advance()
        }
    }

    var isAtEnd: Bool {
        stepIndex == allSteps.count - 1
    }

    var caretDirection: TooltipCaretDirection {
        currentStep.caretDirection
    }

    // todo(alaina): add documentation
    var verticalOffset: CGFloat {
        let tooltipHeight: CGFloat = 140
        let tooltipCaretToContentPadding: CGFloat = 8
        switch currentStep {
            case .first,
                 .second:
                if let headerViewGlobalMaxY = headerViewGlobalMaxY {
                    return headerViewGlobalMaxY + tooltipCaretToContentPadding
                } else {
                    return 0
                }
            case .third:
                if let topRecsEyebrowGlobalY = topRecommendationsEyebrowGlobalY {
                    return topRecsEyebrowGlobalY - tooltipHeight - tooltipCaretToContentPadding
                } else {
                    return 0
                }
            case .fourth:
                if let atHomeRecsSectionTitleGlobalY = atHomeRecommendationsSectionTitleGlobalY {
                    return atHomeRecsSectionTitleGlobalY - tooltipHeight
                } else {
                    return 0
                }
        }
    }

    func onAppear() {
        let event = TooltipEvent(kind: .seen, message: currentStep.message)
        onEvent.send(event)
    }

    // MARK: - Private

    private func advance() {
        let event = TooltipEvent(
            kind: .next,
            message: currentStep.message
        )
        onEvent.send(event)

        stepIndex += 1
        if stepIndex < allSteps.count {
            let nextStep = allSteps[stepIndex]
            display(step: nextStep)
        }
    }

    private func finish() {
        let event: TooltipEvent = TooltipEvent(
            kind: .done,
            message: currentStep.message
        )
        onEvent.send(event)

        withAnimation {
            scrollProxy?.scrollTo(
                tooltipAnchor(for: .first),
                anchor: unitPoint(for: .first)
            )
        }
    }

    private func display(step: WalkthroughStep) {
        withAnimation(.easeInOut) {
            currentStep = step
            if step.shouldAutoScroll {
                scrollProxy?.scrollTo(
                    tooltipAnchor(for: step),
                    anchor: unitPoint(for: step)
                )
            }
        }

        let event = TooltipEvent(kind: .seen, message: currentStep.message)
        onEvent.send(event)
    }

    private func tooltipAnchor(for step: WalkthroughStep) -> TooltipAnchor {
        switch step {
            case .first,
                 .second:
                .topOfScrollView
            case .third:
                .topTravelRecommendations
            case .fourth:
                .atHomeRecommendations
        }
    }

    private func unitPoint(for step: WalkthroughStep) -> UnitPoint {
        switch step {
            case .first,
                 .second:
                .top
            case .third:
                UnitPoint(x: 0, y: 1.2)
            case .fourth:
                .bottom
        }
    }
}
