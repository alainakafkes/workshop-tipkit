import SwiftUI

struct TileRecommendationView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    private let recommendation: TravelRecommendation
    private let index: Int

    private static let backgroundImageCornerRadius: CGFloat = 12

    init(with recommendation: TravelRecommendation, at index: Int) {
        self.recommendation = recommendation
        self.index = index
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            backgroundView

            VStack(alignment: .leading) {
                Spacer()

                textView
            }
            .padding(16)
        }
    }

    private var textView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(recommendation.title)
                .font(.headline)
                .foregroundColor(.black.opacity(0.8))

            HStack(spacing: 8) {
                Text(recommendation.subtitle)
                    .font(.caption)
                    .foregroundColor(.black.opacity(0.6))

                Image(systemName: "arrow.forward.circle")
                    .frame(width: 12, height: 12)
            }
        }
    }

    private var completedIconView: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundColor(.white)
    }

    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: Self.backgroundImageCornerRadius)
            .fill(
                .white.opacity(0.9)
            )
    }
}

#Preview {
    TileRecommendationView(with: .forTestingTile, at: 0)
}
