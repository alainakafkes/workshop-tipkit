import Foundation
import SwiftUI

struct WalkthroughView: View {
    @ObservedObject
    var viewModel: WalkthroughViewModel

    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                let globalYOffset = viewModel.verticalOffset
                let frameGlobalYPosition = geometry.frame(in: .global).minY
                let localYOffset = globalYOffset - frameGlobalYPosition

                TooltipView(
                    message: viewModel.currentMessage,
                    caretDirection: viewModel.caretDirection
                ) {
                    viewModel.handle(action: $0)
                }
                .transition(.asymmetric(insertion: .opacity, removal: .identity))
                .offset(y: localYOffset)
                .id(viewModel.currentMessage)
            }
            .padding(.horizontal, 20)
            .onAppear { viewModel.onAppear() }
        }
    }
}

#Preview {
    WalkthroughView(viewModel: .init(startIndex: 0))
}
