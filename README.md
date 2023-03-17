# UIKit Fightcamp app

## this took a little longer than I expected because I'm used to RxSwift so I had to learn a bit more Combine to avoid third party libraries! Great project, the design documents, xcode project and overall documentation made this pretty fun!

### Package.swift
- generated with https://quicktype.io/

### FormattedPackageElement
- takes in the package from the API and formats it for the screen

### MainViewController
- Shows the data in a collectionview
- uses diffable datasource because im used to RxDataSources
- holds MainViewModel

## MainViewModel
- holds the data for the UI
- loads the data from a file
	- formats it for the UI after loading

### PackageView
- shows the Package in a styled cell
- loads images from URLs in the formatted package
- the thumbnail selection uses a published integer to keep track of the index
	- I thought about using a collectionview here, or keeping track of the index in the view model
		- we don't need to keep track of the tapped index when the cell is off screen so keeping track of the index didnt matter
		- a collection view inside of another collectionview cell seemed like a head ache
			- ideally this would be a more complicated collectionview flow layout with multiple cells instead of all in one cell

### PackageCollectionViewCell
- holds the package view. 
	- I wasnt sure if I would do a tableview or collectionview starting out so I used a view in a stackview

### ImageService
- im used to using SDWebImage which works like a singleton I did this the same
- it downloads the first time and saves the images for later

### Helpers
- a few extension methods that I needed to make it easier