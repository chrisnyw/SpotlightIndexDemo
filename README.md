# SpotlightIndexDemo

This project demonstrates how to integrate the iOS Spotlight Index API to enhance app content discoverability. With this implementation, users can search for app content directly through iOS Spotlight search. The demo follows the MVVM architecture.

<img src="https://github.com/chrisnyw/SpotlightIndexDemo/raw/refs/heads/main/Screenshots/SpotlightIndexScreenshot.png" width="200" title="Movie Listing" alt="Movie Listing"/>

## Introduction

### Features

This app showcases a list of movies with the following features:
- [Movie Listing Screen](#movie-listing-screen) – Displays a collection of movies.
- [Interactive Hover Effect](#interactive-hover-effect) – Scales and dims the movie poster when the user hovers over it.
- [Single Tap Navigation](#single-tap-navigation) – Opens the movie details screen with a smooth transition, applies smooth animations when navigating between screens.
- [Double Tap Parallax Effect](#double-tap-parallax-effect) – Displays a popup poster with a parallax effect.
- [Spotlight Indexing](#spotlight-indexing) – Allows users to add or remove movies from Spotlight search.

## Feature Details

### Movie listing screen

Displays movie cards with a poster, title, short description, duration, and rating.

<img src="https://github.com/chrisnyw/SpotlightIndexDemo/raw/refs/heads/main/Screenshots/MovieListingScreen.jpg" width="200" title="Movie Listing" alt="Movie Listing"/>

### Interactive Hover Effect

When the user hovers over a movie card, it responds with a subtle push-down effect, similar to a button press. The card returns to its normal state when the gesture is canceled.

<figure>
<img src="https://github.com/user-attachments/assets/88fbd30b-ed16-4982-b854-2c5dc285c261" width="200" title="Spotlight Demo Hover" alt="Spotlight Demo Hover"/>
</figure>

### Single Tap Navigation

Tapping on a movie card transitions smoothly to the movie details screen. The same transition effect is applied when dismissing the details screen.

<figure>
<img src="https://github.com/user-attachments/assets/74252a01-b4d8-420b-9b2d-c29ac72bdede" width="200" title="Spotlight Demo Single Tap Navigation" alt="Spotlight Demo Single Tap Navigation"/>
</figure>

### Double Tap Parallax Effect

Double tapping a movie card opens a popup poster with a parallax effect. Users can drag the popup to explore a 3D-like effect. A single tap on the popup dismisses it.

<figure>
<img src="https://github.com/user-attachments/assets/8312748f-514d-46c3-a39a-a2a48a175efa" width="200" title="Spotlight Demo Double Tap" alt="Spotlight Demo Double Tap"/>
</figure>


### Spotlight Indexing

Users can add movies to iOS Spotlight search, making them searchable within the system’s Spotlight results. Movies can also be removed from the index.

<figure>
<img src="https://github.com/user-attachments/assets/701bc9c4-ce5b-441f-80c1-48c7ddd5a140" width="200" title="Spotlight Demo Index" alt="Spotlight Demo Index"/>
</figure>

## Credits

This project utilizes the following APIs:
- [Core Spotlight](https://developer.apple.com/documentation/corespotlight) – For indexing the item to spotlight.
- [matchedGeometryEffect](https://developer.apple.com/documentation/swiftui/view/matchedgeometryeffect(id:in:properties:anchor:issource:)) – For smooth transitions between screens.
