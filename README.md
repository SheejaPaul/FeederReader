# FeederReader
Your daily news digest

![Xcode 8.2+](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 8.0+](https://img.shields.io/badge/iOS-11.0%2B-blue.svg)
![Swift 3.0+](https://img.shields.io/badge/Swift-3.0%2B-orange.svg)
![Build Status](https://img.shields.io/badge/Build-Passing%2B-green.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%2B-lightgray.svg)


- [Screenshots](#screenshots)
- [Features](#features)
- [Requirements](#requirements)

## Screenshots

<img width="898" alt="screen shot 2017-12-14 at 3 19 15 pm" src="https://user-images.githubusercontent.com/31255999/34019128-40a9a91a-e0e2-11e7-8cda-7604ec5e9c10.png">

## Features

- [x] Bold design with smooth user interactions
- [x] News feed sourced from The New York Times API
- [x] Content delivered as browse and search experiences
- [x] Allow the user to click on a photo and read the article to which the photo relates
- [x] Allow the user to share individual photos and stories via social media
- [x] Look great in both landscape and portrait modes and reflect Material Design principles
- [x] Not crash or hang and should handle for when networking/internet is slow or unavailable
- [x] Included Local Notifications feature 
- [x] Used Auto Layout and custom tableview pattern


## API's used:

- [New York Times: Top Stories](https://developer.nytimes.com/top_stories_v2.json)
  The Top Stories API returns a list of articles and associated images currently on the specified section
  
- [New York Times: Article Search](https://developer.nytimes.com/article_search_v2.json)
  The Article Search API provides lists of NYT articles by month going back to 1851. Simply pass in the year and month you want and it returns a JSON object with all articles for that month.
  

