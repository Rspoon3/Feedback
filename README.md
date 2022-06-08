# Multiple Orthogoanl Scrolling Sections

Feedback ID: FB10103235  
Status: Open  
Date Submitted: 6-8-2022


## Summary 
Having the ability to scroll multiple sections horizontally when using `UICollectionViewCompositionalLayout`.

## Current Behavior
Only one section can scroll horizontally at a time.

https://user-images.githubusercontent.com/42879920/172642651-6c2e1403-e729-436d-9630-e441348c4bf5.mov

## Desired Behavior
Having the ability to specifiy multiple, or all sections, to scroll horizontally together in sync.

## Workaround
The current workaround is to traverse the `collectionView` subviews to find instances of scrollviews and then use a custom class to keep track and modify content offsets.

https://user-images.githubusercontent.com/42879920/172642932-21378643-f7eb-4a63-a093-0866e9621838.mov


## Version/Build
- Xcode 13.4.1 (13F100)
