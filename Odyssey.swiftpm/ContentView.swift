import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel = .init()

    public var body: some View {
        ZStack(alignment: .top) {
            ScrollViewReader { proxy in
                ScrollableRecommendationsView(viewModel: viewModel)
                    .disabled(viewModel.isShowingWalkthrough)
                    .onAppear {
                        viewModel.walkthroughViewModel?.scrollProxy = proxy
                    }
                    .background(
                        .orange
                    )
            }

            StickyHeaderView(viewModel: viewModel)
        }
        .environmentObject(viewModel)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    ContentView()
}
