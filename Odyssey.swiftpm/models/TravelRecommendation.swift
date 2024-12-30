import Foundation

// MARK: - TravelRecommendation

public struct TravelRecommendation: Hashable, Identifiable, Sendable {
    public var id: String { UUID().uuidString }

    public let title: String
    let subtitle: String
    let summary: String?
    let imageUrlString: String?

    static let forTestingImage: TravelRecommendation = .init(
        title: "ithaki",
        subtitle: "an ionian isle for your itinerary",
        summary: "splash out on odysseus's beachy beaut and miss it just as dearly.",
        imageUrlString: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Ithaki-Vathy.jpg/1600px-Ithaki-Vathy.jpg"
    )

    static let forTestingTile: TravelRecommendation = .init(
        title: "sicilian food 101",
        subtitle: "learn how to feast, but not like laestrygon!",
        summary: nil,
        imageUrlString: nil
    )

    static let forTestingCheckable: TravelRecommendation = .init(
        title: "stroll through old town kerkyra",
        subtitle: "10,000 steps is kinda fake but walking is still great, especially when history surrounds you!",
        summary: nil,
        imageUrlString: nil
    )
}

// MARK: - RecommendationsSection

public struct RecommendationsSection: Hashable, Sendable {
    let title: String?
    public let recommendations: [TravelRecommendation]

    enum CodingKeys: String, CodingKey {
        case title
        case recommendations
    }

    static let empty: RecommendationsSection = .init(title: nil, recommendations: [])

    static let topTravelRecommendationsSectionForTesting: RecommendationsSection = .init(
        title: nil,
        recommendations: [
            .forTestingImage,
            .forTestingImage,
            .forTestingImage,
        ]
    )

    static let atHomeRecommendationsSectionForTesting: RecommendationsSection = .init(
        title: "Transportive tastes",
        recommendations: [
            .forTestingTile,
            .forTestingTile,
        ]
    )

    static let checkableRecommendationsSectionForTesting: RecommendationsSection = .init(
        title: "On the go",
        recommendations: [
            .forTestingCheckable,
            .forTestingCheckable,
            .forTestingCheckable,
        ]
    )
}
