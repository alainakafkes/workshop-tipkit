import SwiftUI

struct StickyHeaderView: View {
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.mint)
                .frame(height: 130)
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                viewModel.walkthroughViewModel?
                                    .setHeaderViewGlobalMaxY(geometry.frame(in: .global).maxY)
                            }
                    }
                )
                .maybeAddOverlayForWalkthrough(
                    isShowingWalkthrough: $viewModel.isShowingWalkthrough,
                    stepsToHighlight: [.first, .second],
                    currentStep: $viewModel.currentWalkthroughStep
                )
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])

            if viewModel.isShowingWalkthrough,
               let walkthroughViewModel = viewModel.walkthroughViewModel {
                WalkthroughView(viewModel: walkthroughViewModel)
            }
        }
    }
}

