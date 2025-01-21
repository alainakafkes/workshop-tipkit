import SwiftUI

@available(iOS 17.0, *)
struct ListItemView: View {
    let title: String

    @State private var isStarred: Bool = false
//    private let tip = SimpleStarTip()

    var body: some View {
        Button {
            isStarred.toggle()
//            tip.invalidate(reason: .actionPerformed)
        } label: {
            VStack(spacing: 8) {
                HStack {
                    Text(title)
                        .foregroundStyle(.black)

                    Spacer()

                    Image(systemName: isStarred ? "star.fill" : "star")
                        .tint(.black)
//                        .popoverTip(tip)
                }
            }
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        ListItemView(title: "hello")
    }
}
