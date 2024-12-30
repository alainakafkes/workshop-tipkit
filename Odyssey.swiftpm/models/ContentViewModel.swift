import Combine
import Dispatch
import Foundation
import SwiftUI

@MainActor
final class ContentViewModel: ObservableObject {
    @Published var selectedTopTravelRecTabIndex: Int = 0
    @Published var isShowingWalkthrough: Bool = false
    @Published var currentWalkthroughStep: WalkthroughStep?

    private var subscriptions: [AnyCancellable] = []

    init() {
        setUpWalkthrough()
    }

    private func setUpWalkthrough() {
        let walkthroughViewModel = WalkthroughViewModel(startIndex: 0)

        walkthroughViewModel.onEvent.sink { [weak self] event in
            if event.kind == .seen {
                self?.currentWalkthroughStep = walkthroughViewModel.currentStep
            }
            self?.handle(event)
        }.store(in: &subscriptions)

        self.walkthroughViewModel = walkthroughViewModel
    }

    private(set) var walkthroughViewModel: WalkthroughViewModel? {
        didSet {
            isShowingWalkthrough = walkthroughViewModel != nil
        }
    }

    private func handle(_ tooltipEvent: TooltipEvent) {
        if tooltipEvent.kind == .done,
           walkthroughViewModel?.isAtEnd == true {
            hideWalkthrough()
        }

        currentWalkthroughStep = walkthroughViewModel?.currentStep
    }

    private func hideWalkthrough() {
        walkthroughViewModel = nil
    }

    var topRecommendationsSection: RecommendationsSection {
        .topTravelRecommendationsSectionForTesting
    }

    var atHomeRecommendationsSection: RecommendationsSection {
        .atHomeRecommendationsSectionForTesting
    }

    var checkableRecommendationsSection: RecommendationsSection {
        .checkableRecommendationsSectionForTesting
    }
}
