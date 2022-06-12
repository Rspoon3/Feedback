# UISplitView Controller Modal Presentation

## Summary 
Presenting a view controller over a `UISplitViewController` pane does not work as expected when the app is resized on iPad if the `modalPresentationStyle` is `currentContext`. 

## Current Behavior
I created a `UISplitViewController` with a primary and secondary column. When presenting a third (`ColorVC`) over the secondary column, it seems to work as expected. However, when you resize the application, the modal view controller does not properly resize. Additionally if you initially present the view controller while the splitview is collapsed, when you expand it, the presented view contorller does not move to the secondary column- it stays on the main column.

![example](https://user-images.githubusercontent.com/42879920/173239346-0360bf41-12e9-4d05-86e0-29b6044a11f8.png)

https://user-images.githubusercontent.com/42879920/173239435-e5401495-de99-462e-92b0-a011e77735ff.mov


https://user-images.githubusercontent.com/42879920/173239748-970fec00-9548-48f9-8426-1d13f5bbd540.mov


https://user-images.githubusercontent.com/42879920/173239353-ca2bf8f1-bd59-4d92-92e8-e339b7ecf5e7.mov



```swift
private func presentColorVC() {
  let vc = ColorVC()
  let nav = UINavigationController(rootViewController: vc)
  nav.definesPresentationContext = true
  nav.modalPresentationStyle = .currentContext
  present(nav, animated: true)
}
```



## Desired Behavior
The presented view controller should properly resize with the application and when presented on the DetailsVC while the split view is collapsed, when the app resizes, it should move the the secondary column (since that is the column DetailsVC ends up as).

## Notes
I am using `overrideTraitCollection` to return a custom size for regular and compact. If you comment out this behavior, when resizing the application the behavior is a bit closer to what is expected, however it still has issues; when going from a "regular" view to "compact" view, the presented modal does not show.

```siwft
override func overrideTraitCollection(forChild childViewController: UIViewController) -> UITraitCollection? {
     super.overrideTraitCollection(forChild: childViewController)
     return .init(horizontalSizeClass: view.frame.width >= 800 ? .regular : .compact)
}
```

## Version/Build
- Xcode 13.4.1 (13F100)
- iPad 12.9, 15.5 (5th generation)
- iPadOS version, 14-16.1 (beta 1)
