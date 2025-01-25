# Tinkering with TipKit

## About the Iliad app

Iliad is a skeletal (truly!) sample app in which users can star topics from [Homer's epic poem the Iliad](https://en.wikipedia.org/wiki/Iliad) that they'd like to learn more about. If you have extra time, feel free to give it more heft. :)

## Creating a tip

To create a tip, simply create a new [structure](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures/) that conforms to the [`Tip`](https://developer.apple.com/documentation/tipkit/tip). Import the TipKit framework at the top the file to ensure access to the Tip protocol.

I built `SimpleStarTip` as an example, but feel free to edit it or create your own!

```
import TipKit

struct SimpleStarTip: Tip {
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
```

The simplest of tips requires only a `title`. We'll explore greater tip customization in the "Styling a tip" section.

## Displaying a tip

> [!IMPORTANT]
> In order to display tips in an iOS application, one must execute [`Tips.configure()`](https://developer.apple.com/documentation/tipkit/tips/configure(_:)) upon app initialization. I've done this for you in Iliad.

Tips can be presented in one of two ways: in-line with the rest of the UI, or as a popover.

To present a tip in-line with the rest of the UI, initialize a [`TipView`](https://developer.apple.com/documentation/tipkit/tipview) with an object that conforms to the [`Tip`](https://developer.apple.com/documentation/tipkit/tip) protocol.

**Exercise**: present `SimpleStarTip` (or the tip you created in the "Creating a tip" section) in-line within `ContentView`, `ListItemView`, or another SwiftUI view of your creation. Play around with arrow direction and positioning.

To present a tip as a popover on a SwiftUI view, apply the [`.popoverTip()`](https://developer.apple.com/documentation/swiftui/view/popovertip(_:arrowedge:action:)) view modifier to that view.

**Exercise**: present `SimpleStarTip` (or the tip you created in the "Creating a tip" section) as a popover. Play around with arrow direction and positioning.

## Dismissing tips

Now that we know how to present a tip, how might we dismiss it?

We'll stick with the simple way for now: use the Tip protocol's instance method [`invalidate(reason:)`](https://developer.apple.com/documentation/tipkit/tip/invalidate(reason:)).

**Exercise**: dismiss the tip you presented in the "Displaying a tip" section. Play around with the various invalidation reasons.

## Supporting user interaction with a tip

Let's return to the definition of `SimpleStarTip`, or whatever tip you created in the "Creating a tip" section.

You may have noticed that the [`Tip`](https://developer.apple.com/documentation/tipkit/tip) protocol includes an `actions` array. Per Apple's [documentation](https://developer.apple.com/documentation/tipkit/tip/action), these actions "appear at the bottom of your TipView in the form of buttons."

Setting up one `Action` within the `actions` array might look like

```
var actions: [Action] {
    Action(title: "Visit Strategic Study screen")
}
```

or

```
var actions: [Action] {
    Action(id: "strategic-study", title: "Visit Strategic Study screen")
}
```

or even

```
var actions: [Action] {
    Action {
        Text("Visit Strategic Study screen")
    }
}
```

Amazingly, the `actions` array seems not to enforce usage of square brackets (aka `[...]`) when only one `Action` is provided.

**Exercise**: define one or more `Action`s on the tip you created in the "Creating a tip" section. If working with the `SimpleStarTip`, consider creating an action that could take a user to the Strategic Study screen, as exemplified above.

In the "Displaying a tip" section, we learned to display tips in-line with the rest of the UI by initializing a `TipView` with an object that conforms to the `Tip` protocol. Besides a `tip` and `arrowEdge`, `TipView`s can also be [instantiated with an `action` closure](https://developer.apple.com/documentation/tipkit/tipview/init(_:arrowedge:action:)-ztv8).

Within the action closure, you can check an `Action`'s `id` and handle it accordingly!

```
struct ExampleView: View {
    let tip = SimpleStarTip()

    var body: some View {
        TipView(tip) { action in
            if action.id == "strategic-study" {
                // do something!
            }
        }
    }
}
```

What of popover tips? They too support actions! The [`.popoverTip()`](https://developer.apple.com/documentation/swiftui/view/popovertip(_:arrowedge:action:)) view modifier has an `action` closure as one of its arguments. This closure has the same type as the `TipView` `action` closure shown above.

**Exercise**: hook up the action you created earlier in this section to a change that happens within the UI. If working with the `SimpleStarTip`, consider building an empty version of the Strategic Study screen and navigating to it when the user taps on the action button.

## Styling a tip

Before we treat our tip to a glow-up, let's isolate it in its own SwiftUI preview.

**Exercise**: use `#Preview { ... }` syntax to present a `TipView` for `SimpleStarTip` (or the tip you created in the "Creating a tip" section) in the SwiftUI previews window.

TK

## Displaying a group of tips

TK

## Writing display rules for our tips

TK

## Further reading

* [Apple's TipKit documentation](https://developer.apple.com/documentation/tipkit)
