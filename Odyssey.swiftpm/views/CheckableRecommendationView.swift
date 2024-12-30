import SwiftUI

struct CheckableRecommendationView: View {
    private let recommendation: TravelRecommendation

    @State private var isCompleted: Bool

    init(with recommendation: TravelRecommendation) {
        self.recommendation = recommendation
        _isCompleted = .init(initialValue: false)
    }

    var body: some View {
        Button(action: {
            guard !isCompleted else { return }
            isCompleted = true
        }, label: {
            HStack {
                if isCompleted {
                    completedCheckmarkFilled
                } else {
                    emptyCheckmarkView
                }

                descriptionView
                Spacer()
            }
        })
        .buttonStyle(.plain)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white.opacity(isCompleted ? 0.1 : 0.8))
        )
    }

    private var emptyCheckmarkView: some View {
        Image(systemName: "checkmark.circle")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 32, height: 32)
    }

    private var completedCheckmarkFilled: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundColor(.white)
            .aspectRatio(contentMode: .fill)
            .frame(width: 32, height: 32)
    }

    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(recommendation.title)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .foregroundStyle(isCompleted ? .white : .black)
                .opacity(isCompleted ? 1.0 : 0.8)
            Text(recommendation.subtitle)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .foregroundStyle(isCompleted ? .white : .black)
                .opacity(isCompleted ? 0.8 : 0.60)
        }
    }
}

#Preview {
    CheckableRecommendationView(with: .forTestingCheckable)
}
