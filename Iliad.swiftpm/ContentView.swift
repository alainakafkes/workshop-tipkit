import SwiftUI
import TipKit

@available(iOS 17.0, *)
struct ContentView: View {
//    private let tip = SimpleStarTip()

    var body: some View {
        VStack {
            Text("A few things about Homer's Iliad")
                .font(.title2)
            List {
//                Section {
//                    TipView(tip)
//                }

                Section {
                    ListItemView(title: "Achilles")
                    ListItemView(title: "Agamemnon")
                    ListItemView(title: "Patroclus")
                    ListItemView(title: "Odysseus")
                    ListItemView(title: "Diomedes")
                    ListItemView(title: "Great Ajax")
                    ListItemView(title: "Little Ajax")
                    ListItemView(title: "Nestor")
                    ListItemView(title: "Menelaus")
                    ListItemView(title: "Idomeneus")
                    ListItemView(title: "Machaon")
                    ListItemView(title: "Calchas")
                    ListItemView(title: "Peleus")
                    ListItemView(title: "Phoenix")
                } header: {
                    Text("Characters")
                }

                Section {
                    ListItemView(title: "Fate")
                    ListItemView(title: "Glory")
                    ListItemView(title: "Homecoming")
                    ListItemView(title: "Pride")
                    ListItemView(title: "Heroism")
                    ListItemView(title: "Respectability")
                    ListItemView(title: "Hubris")
                    ListItemView(title: "Wrath")
                    ListItemView(title: "War")
                } header: {
                    Text("Themes")
                }

                Section {
                    ListItemView(title: "Barley rusks")
                    ListItemView(title: "Figs")
                    ListItemView(title: "Dates")
                    ListItemView(title: "Olives")
                    ListItemView(title: "Fried dough")
                    ListItemView(title: "Honey")
                    ListItemView(title: "Sesame")
                    ListItemView(title: "Cheese")
                    ListItemView(title: "Olive oil")
                    ListItemView(title: "Pomegranates")
                    ListItemView(title: "Wine")
                } header: {
                    Text("Foods")
                }
            }
        }
    }
}
