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

**Exercise**: Hook up the action you created earlier in this section to a change that happens within the UI. If working with the `SimpleStarTip`, consider building an empty version of the Strategic Study screen and navigating to it when the user taps on the action button.

## Styling a tip

Before we treat our tip to a glow-up, let's isolate it in its own SwiftUI preview.

**Exercise**: use `#Preview { ... }` syntax to present a `TipView` for `SimpleStarTip` (or the tip you created in the "Creating a tip" section) in the SwiftUI previews window.

> [!TIP]
> If you run into a compiler error stating that `TipView`'s initializer can only be used in iOS 17+, annotate the offending macro (e.g., `#Preview`), struct, or other declaration with `@available(iOS 17.0, *)`.
>
> Sadly Xcode's did not allow me specify a minimum iOS version in this app playground, so you may run into this error a number of times. :<

Now that you can preview your tip as a `TipView`, you can zhuzh it up using view modifiers.

**Exercise**: Apply one or more view modifiers to the `TipView` you created in the last exercise. Consider tweaking its [appearance](https://developer.apple.com/documentation/swiftui/view-appearance), [text](https://developer.apple.com/documentation/swiftui/view-text-and-symbols), and [layout](https://developer.apple.com/documentation/swiftui/view-layout).

You can alternatively build out a style to apply to more than one tip. (More only multiple tips soon!). SwiftUI views – like the `TipView` itself – accept a [`.tipViewStyle()`](https://developer.apple.com/documentation/SwiftUI/View/tipViewStyle(_:)) view modifier. The one and only argument of the `tipViewStyle` modifier is an object that conforms to the [`TipViewStyle`](https://developer.apple.com/documentation/TipKit/TipViewStyle) protocol.

Here's a short example of a structure that conforms to `TipViewStyle`, and a `TipView` that uses it:

```
@available(iOS 17.0, *)
struct SimpleStarTipStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .trailing) {
            configuration.tip.title
                .font(.caption)
                .foregroundColor(.pink)
                .textCase(.uppercase)

            configuration.tip.message
                .font(.title)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    TipView(SimpleStarTip())
        .tipViewStyle(SimpleStarTipStyle())
}
```

**Exercise**: Move the styling logic you wrote on the `TipView` in the last exercise into a `TipViewStyle`-conforming structure, and apply that `TipViewStyle` to the aforementioned `TipView`.

## Writing display rules for a tip

Thus far, we've played around with how our tips look. Let's turn our attention to when – or, rather, under which conditions – our tips can be displayed.

The TipKit framework enables us to write [two types of eligibility rules](https://developer.apple.com/documentation/tipkit/tip/rule) that determine if and when our tips should be displayed:
* parameter-based rules, which are based on state or boolean values; and
* event-based rules, which are based on user actions.

Both types of rules can be constructed with swift's `#Rule` macro. Their definitions should live within the `rules` array of a `Tip`.

### Parameter rules

Here's what a parameter-based rule for `SimpleStarTip` might look like:

```
struct SimpleStarTip: Tip {
    // title, message, and image defined above

    @Parameter static var isFirstDayOfTheMonth: Bool = false

    var rules: [Rule] {
        #Rule(Self.$isFirstDayOfTheMonth) { currentValue
            currentValue == true // displays tip when isFirstDayOfTheMonth is set to true
        }
    }
}
```

With this rule in place, the app only presents `SimpleStarTip` when `isFirstDayOfTheMonth` is set to true.

**Exercise**: Write a rule that displays `SimpleStarTip` (or the tip you created in the "Creating a tip" section) every other minute. Validate this new rule within Iliad.

### Event rules

Here's what an event-based rule for `SimpleStarTip` might look like:

```
struct SimpleStarTip: Tip {
    static let didScrollToBottom: Event = Event(id: "didScrollToBottom")

    var rules: [Rule] {
        #Rule(Self.didScrollToBottom) {
            $0.donations.count == 1 // displays tip when user has scrolled to bottom of the screen exactly once
        }
    }
}
```

This rule merits more explanation because it relies on event donations. I'm not sure why Apple employs the word "donation" in this context (or others, like Siri!), but, in the TipKit framework, it is how an app communicates to the operating system that a given event has happened. So, one donation equals one event instance.

In order to increment the `donations` counter on the `didScrollToBottom` `Event` declared above, we must call the latter's [`donate()`](https://developer.apple.com/documentation/tipkit/tips/event/donate()) method. Note that it is asynchronous!

```
struct ExampleView: View {
    var body: some View {
        Circle()
            .task {
                await SimpleStarTip.didScrollToBottom.donate()
            }
    }
}

```

**Exercise**: Write a rule that displays `SimpleStarTip` (or the tip you created in the "Creating a tip" section) when a user taps on one of the `List`'s section headers four times. Validate this new rule within Iliad.

## Displaying a group of tips

TK

## Testing tips

TK

## Further reading

* [Apple's TipKit documentation](https://developer.apple.com/documentation/tipkit)
