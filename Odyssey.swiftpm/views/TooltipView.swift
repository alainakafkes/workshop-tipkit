import Foundation
import SwiftUI

struct TooltipView: View {
    let message: TooltipMessage
    let action: (TooltipMessage.Action) -> Void
    private let caretDirection: TooltipCaretDirection

    private let backgroundColor: Color = Color(.sRGB, red: 0.95, green: 0.95, blue: 0.95, opacity: 1)

    init(
        message: TooltipMessage,
        caretDirection: TooltipCaretDirection,
        action: @escaping (TooltipMessage.Action) -> Void
    ) {
        self.message = message
        self.caretDirection = caretDirection
        self.action = action
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .center, spacing: 0) {
                switch caretDirection {
                    case .up:
                        upwardCaret
                        messageBubble
                    case .down:
                        messageBubble
                        downwardCaret
                }
            }
        }
    }

    private var upwardCaret: some View {
        UpwardTriangle()
            .fill(backgroundColor)
            .frame(width: 24, height: 12)
    }

    private var downwardCaret: some View {
        DownwardTriangle()
            .fill(backgroundColor)
            .frame(width: 24, height: 12)
    }

    private var messageBubble: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(message.title)
                    .font(.headline)
                    .foregroundStyle(.black.opacity(0.8))
                    .multilineTextAlignment(.leading)

                Spacer()
                    .frame(height: 4)

                Text(message.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.black.opacity(0.6))
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, 16)

                Spacer()
                    .frame(height: 10)

                actionButton
            }

            Spacer()
        }
        .padding(.leading, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(
            backgroundColor,
            in: RoundedRectangle(cornerRadius: 12)
        )
    }

    private var actionButton: some View {
        Button(action: {
            action(message.action)
        }) {
            Text(message.action.buttonText)
                .foregroundStyle(.white)
                .font(.title3)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(.mint)
                )
                .overlay(
                    Capsule()
                        .stroke(
                            .white.opacity(0.2),
                            lineWidth: 2
                        )
                )
        }
    }
}

#Preview {
    TooltipView(
        message: .first,
        caretDirection: .up,
        action: { _ in }
    )
}
