## FightCamp take home (iOS) 🥊

Hey! Congratulations on making it to the next step in the interview process. We look forward to having you potentially join the FightCamp family!

## Expectations

Replicate the FightCamp package selection designs into a **shippable** native iOS App using Swift and SwiftUI.

See the image below as a reference:

![](img/mockups-01.png)

![](img/package-animation-01.gif)

## Goals 

There are 3 packages available:

- FightCamp Personal
- FightCamp Tribe
- FightCamp Connect

#### Goal level 1

One of the three packages is displayed on the screen.

In this case, we should be able to easily change the code so that another package can be displayed.

#### Goal level 2

The thumbnail section is interactive. The border color of the thumbnail and the preview image update when one of the 4 thumbnails is tapped on.


#### Goal level 3

All three packages are displayed on the screen and embedded into a scrolling view (UIScrollView, UITableView, UICollectionView). 
All three packages can be viewed by scrolling the screen up or down.


## Requirements

- Must compile (No Errors or warnings)
- Swift (No Objective-C)
- Layout is done programmatically (No storyboards or nibs)
- Use MVVM architecture
- Light & dark mode compatible
- No third party libraries
- Support all iPhones with a screen size greater than or equal to 4.7 inches (Support for iPad is not required)
- The UI should not be hardcoded (Use `packages.json` to simulate an API call and populate the UI) 

## Project Submission

Download this repository to get access to the configured XCode project and the helper files.

Try to accomplish as many goal levels as you can.

Create a small README with the following items:

* Small summary of the reasoning behind your technical decisions.
* What is missing and why. (if applicable)
* Any other information you believe is necessary for us to know about your submission.

Once completed, email us a Zipped version of your Xcode project with all source files.

## Time allotment 

It should take approximately 3 hours to complete **Goal level 1**. 

It should take approximately 1 more hour in order to complete **Goal level 2 & 3**

Feel free to take extra time to perfect your solution.

## Evaluation

| Criteria | |
|:--|:--|
Readability of the code (easy to read, easy to navigate, well structured)  | ++++
UI is performant and matches the design | ++++
Respect of the MVVM architecture (e.g. UI separation from the model) | +++
Simplicity of the solutions used | +++
Use of the Swift/SwiftUI functionalities | +++
Formatting of the code and code comments | ++

## Helper Files

| Files    | Description    |
|:-----|:------|
|`Colors.swift`| Contains all needed Colors
|`Fonts.swift` | Contains all Fonts needed to style the labels
| `Layout.swift` | Contains all CGFloat layout dimensions
| `packages.json` | Contains the FightCamp packages metadata (json format)

## Layout reference

Refer to this image below to build the UI

![](./img/specs-01.png)
