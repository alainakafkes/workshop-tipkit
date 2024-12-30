import SwiftUI

struct ScrollableRecommendationsView: View {
    @ObservedObject private var viewModel: ContentViewModel

    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                topRecommendationsView
                    .frame(height: 800)
                    .padding(.top, 80)
                    .id(TooltipAnchor.topOfScrollView)

                atHomeRecommendationsView
                    .id(TooltipAnchor.atHomeRecommendations)
                    .maybeAddOverlayForWalkthrough(
                        isShowingWalkthrough: $viewModel.isShowingWalkthrough,
                        stepsToHighlight: [.fourth],
                        currentStep: $viewModel.currentWalkthroughStep
                    )

                checkableRecommendationsView
                    .maybeAddOverlayForWalkthrough(
                        isShowingWalkthrough: $viewModel.isShowingWalkthrough,
                        stepsToHighlight: [],
                        currentStep: $viewModel.currentWalkthroughStep
                    )
                Spacer()
                    .frame(height: 80)
            }
            .background(backgroundGradientView)
        }
    }

    private var backgroundGradientView: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(
                LinearGradient(
                    colors: [.pink, .orange],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .padding(.top, 120)
    }

    private var topRecommendationsView: some View {
        TabView(selection: $viewModel.selectedTopTravelRecTabIndex) {
            ForEach(
                Array(viewModel.topRecommendationsSection.recommendations.enumerated()),
                id: \.offset
            ) { index, rec in
                ImageRecommendationView(
                    with: rec,
                    at: index
                )
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }

    private var atHomeRecommendationsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let title = viewModel.atHomeRecommendationsSection.title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .background {
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    let minY = geometry.frame(in: .global).minY
                                    viewModel.walkthroughViewModel?.setAtHomeRecommendationsSectionTitleGlobalY(minY)
                                }
                                .onChange(of: geometry.frame(in: .global).minY) { minY in
                                    viewModel.walkthroughViewModel?.setAtHomeRecommendationsSectionTitleGlobalY(minY)
                                }
                        }
                    }
                    .accessibilityAddTraits(.isHeader)
                    .id(TooltipAnchor.atHomeRecommendations)
            }

            HStack(alignment: .center, spacing: 15) {
                ForEach(
                    Array(viewModel.atHomeRecommendationsSection.recommendations.enumerated()),
                    id: \.offset
                ) { index, rec in
                    TileRecommendationView(with: rec, at: index)
                        .frame(height: 114)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 36)
    }

    private var checkableRecommendationsView: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title = viewModel.checkableRecommendationsSection.title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .accessibilityAddTraits(.isHeader)
            }

            ForEach(viewModel.checkableRecommendationsSection.recommendations) { rec in
                CheckableRecommendationView(with: rec)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ScrollableRecommendationsView(viewModel: .init())
        .environmentObject(ContentViewModel())
}
