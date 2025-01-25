import TipKit

@available(iOS 17.0, *)
struct SimpleStarTip: Tip {
    var id: String = UUID().uuidString

    var title: Text {
        Text("Star what you need to study")
    }
    var message: Text? {
        Text("Your starred items can be found on the Strategic Study screen.")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}
