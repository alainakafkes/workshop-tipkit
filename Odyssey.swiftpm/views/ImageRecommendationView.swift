import SwiftUI

struct ImageRecommendationView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    private let recommendation: TravelRecommendation
    private let index: Int

    @State var imageUrl: URL?
    @State var imageHeightPercentage: Double = 0.7

    init(with recommendation: TravelRecommendation, at index: Int) {
        self.recommendation = recommendation
        self.index = index
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            backgroundImageView
                .mask(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                .black,
                                .black.opacity(0.3),
                                .black.opacity(0.2),
                                .black.opacity(0.00),
                            ]
                        ),
                        startPoint: UnitPoint(x: 0, y: 0.7),
                        endPoint: UnitPoint(x: 0, y: 1)
                    )
                )
            Spacer()
        }
        .maybeAddOverlayForWalkthrough(
            isShowingWalkthrough: $viewModel.isShowingWalkthrough,
            stepsToHighlight: [],
            currentStep: $viewModel.currentWalkthroughStep
        )
        .overlay(alignment: .bottom) {
            descriptionView
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                .id(TooltipAnchor.topTravelRecommendations)
                .maybeAdjustOpacityForWalkthrough(
                    isShowingWalkthrough: $viewModel.isShowingWalkthrough,
                    stepToHighlight: .third,
                    currentStep: $viewModel.currentWalkthroughStep
                )
        }
    }

    private var backgroundImageView: some View {
        Color.clear
            .overlay(
                AsyncImage(
                    url: URL(string: recommendation.imageUrlString ?? ""),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    },
                    placeholder: {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [.indigo, .black],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                )
            )
            .clipped()
    }

    private var descriptionView: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                eyebrowView
                    .background {
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    let minY = geometry.frame(in: .global).minY
                                    viewModel.walkthroughViewModel?.setTopRecommendationsEyebrowGlobalY(minY)
                                }
                                .onChange(of: geometry.frame(in: .global).minY) { minY in
                                    viewModel.walkthroughViewModel?.setTopRecommendationsEyebrowGlobalY(minY)
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 16)

                Text(recommendation.title)
                    .font(.title)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 2)
                Text(recommendation.subtitle)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)

                if let summary = recommendation.summary {
                    Text(summary)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                }

                Capsule()
                    .foregroundStyle(.regularMaterial)
                    .frame(height: 48)
                    .padding(.horizontal, 40)
                    .overlay {
                        Text("learn more...")
                            .font(.body)
                            .foregroundStyle(
                                .black.opacity(0.7)
                            )
                    }
            }
        }
    }

    private var eyebrowView: some View {
        HStack(alignment: .center, spacing: 4) {
            Image(systemName: "star.leadinghalf.filled")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundColor(.white)

            Text("starred by our staff")
                .font(.subheadline)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    ImageRecommendationView(with: .forTestingImage, at: 0)
        .environmentObject(ContentViewModel())
}
