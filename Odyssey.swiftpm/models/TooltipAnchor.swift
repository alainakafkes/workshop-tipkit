struct TooltipAnchor: Identifiable, Hashable {
    let id: String

    init(id: String) {
        self.id = id
    }
}

extension TooltipAnchor {
    static let topOfScrollView = TooltipAnchor(id: "topOfScrollView")
    static let topTravelRecommendations = TooltipAnchor(id: "topRecommendations")
    static let atHomeRecommendations = TooltipAnchor(id: "atHomeRecommendations")
}
