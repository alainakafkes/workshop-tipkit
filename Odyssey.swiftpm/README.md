# A TipKit-less take

## About the Odyssey app

Odyssey is a façade of a fake travel app in which users can't do much but look at pretty places. What Odyseey lacks in depth, it makes up for with its sleek scrollable walkthrough.

## Understanding Odyssey's custom walkthrough

`WalkthroughView` and `WalkthroughViewModel` power Odyssey's four-tooltip walkthrough. The former overlays the `StickyHeaderView` – the mint green rounded rectangle at the top of the overall `ContentView` – which in turns overlays the `ContentView`. In short, `WalkthroughView` gets presented over the entire `ContentView`.

`WalkthroughView` calculates where each tooltip should live within the viewport. It determines the current tooltip's vertical offset within the viewport by subtracting the minimum vertical position of the current viewport from the vertical position of the subview to which the tooltip should point. Both of these vertical positions exist within the global `CoordinateSpace`.

 How does `WalkthroughView` know the relevant subview's vertical position? That logic lies in the `verticalOffset` variable in its view model. The `verticalOffset` for each tooltip differs based on the subview to which the tooltip must point. `WalkthroughViewModel` features an interface via which callers can update it with the current position of the subview. Take `setAtHomeRecommendationsSectionTitleGlobalY` for an example. The `atHomeRecommendationsView` subview within the `ScrollableRecommendationsView` calls this method whenever its vertical position changes, thereby equipping `WalkthroughViewModel` the information it needs to provide `WalkthroughView` with a `verticalOffset` that positions the associated tooltip in the appropriate place.
 
 But `WalkthroughViewModel` handles more than tooltips' vertical positions: it controls the user's advancement from tooltip to tooltip, and programmatically scrolls if the viewport does not contain the relevant subview for the current tooltip. Where it is instantiated in `ContentView`, it receives a reference to a proxy for the `ScrollView` that contains all of the recommendations. Methods like `advance()` and `finish()` programmatically scroll the screen to the `tooltipAnchor` and `unitPoint` for the subview to which the next tooltip should point.
 
 You may have noticed that, while the walkthrough is active, the app highlights the subview to which the tooltip points, and shrouds the rest of the viewport in semi-darkness. Odyssey uses two view modifiers – `maybeAddOverlayForWalkthrough` and `maybeAdjustOpacityForWalkthrough` – to dim subviews during the appropriate walkthrough steps. I must admit that I figured out which subviews to dim and/or highlight via trial and error. :')
 
I invite you to poke through the code, and let me know if you have any other questions about the walkthrough's architecture and functionality!

## Extending upon Odyssey's custom walkthrough

**Exercise**: Create and display a fifth tooltip that points to the "On the go" section header within the `ContentView`. Highlight some or all of the "On the go" section, and dim the rest of the subviews in the viewport.

**Exercise**: How might have you designed this walkthrough differently? I am open to feedback. :)
