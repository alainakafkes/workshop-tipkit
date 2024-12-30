import SwiftUI

// MARK: - View Extensions

extension View {
    @ViewBuilder
    func maybeAddOverlayForWalkthrough<T: Equatable>(
        isShowingWalkthrough: Binding<Bool>,
        stepsToHighlight: [T],
        currentStep: Binding<T?>
    ) -> some View {
        modifier(
            WalkthroughOverlayModifier(
                isShowingWalkthrough: isShowingWalkthrough,
                stepsToHighlight: stepsToHighlight,
                currentStep: currentStep
            )
        )
    }

    @ViewBuilder
    func maybeAdjustOpacityForWalkthrough<T: Equatable>(
        isShowingWalkthrough: Binding<Bool>,
        stepToHighlight: T,
        currentStep: Binding<T?>
    ) -> some View {
        modifier(
            WalkthroughOpacityModifier(
                isShowingWalkthrough: isShowingWalkthrough,
                stepToHighlight: stepToHighlight,
                currentStep: currentStep
            )
        )
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// MARK: - View Modifiers

// MARK: WalkthroughOverlayModifier

private struct WalkthroughOverlayModifier<T: Equatable>: ViewModifier {
    @Binding var isShowingWalkthrough: Bool
    let stepsToHighlight: [T]
    @Binding var currentStep: T?

    private var shouldHighlight: Bool {
        guard let currentStep else {
            return false
        }
        return stepsToHighlight.contains(currentStep)
    }

    func body(content: Content) -> some View {
        content
            .overlay {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(
                        isShowingWalkthrough ? .black.opacity(0.6) : .clear
                    )
            }
            .overlay {
                if isShowingWalkthrough, shouldHighlight {
                    content
                } else {
                    Color.clear
                }
            }
    }
}

// MARK: WalkthroughOpacityModifier

private struct WalkthroughOpacityModifier<T: Equatable>: ViewModifier {
    @Binding var isShowingWalkthrough: Bool
    let stepToHighlight: T
    @Binding var currentStep: T?

    private var shouldHighlight: Bool {
        currentStep == stepToHighlight
    }

    private var opacity: Double {
        if isShowingWalkthrough {
            if shouldHighlight {
                return 1.0
            } else {
                return 0.6
            }
        } else {
            return 1.0
        }
    }

    func body(content: Content) -> some View {
        content
            .opacity(opacity)
    }
}
