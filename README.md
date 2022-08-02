
# Q Movies

Q Flutter Task for Janssen Delos Santos

#### Summary:
Development Duration: 4 days
#### Finished Tasks:
Simple Version - ALL

Advanced Version - ALL




## Tasks

####  Simple Version

- Fetch the genres from the API to be able to associate the genre ids with the genre names
- Fetch popular movies from the API
- Cache the movies into a database of your choice (Hive, sqflite,...)
- Implement pagination when fetching movies
- Use the api_key as the query parameter in each request in order to successfully authorise the API requests
- When the user selects a movie, open the details page
- Try to make the UI look as close as possible to the provided Simple version section of the Figma file

#### Advanced Version

- Implement the navigation bar
- Add the favourite movies feature - NOTE: the user can toggle the movie as a favourite in the Movie list, Favourites list and in the Movie details page
- Cache the favourite movies into a database of your choice (Hive, sqflite,...)
- Bearer token header authorization (see example in postman) - bonus points for creating a custom auth interceptor in using the dio package
- Show notification when user is offline - NOTE: show cached movies but let the user know he is offline
- Add some animation transition between overview and details page


## Solution

- Used postman to test API
- Used dio for fetching data from server
- Used api_key to successfully authorize API requests
- Implemented pagination when fetching movies
- Used bearer token header authorization and created auth interceptor using dio package
- Used another_flushbar package on displaying notifications when the user change network
- Instead of using NavigationBar, I used TabBar so it has a swipe feature when switching from movies to favourites
- Used Hive for local data storage specifically for caching fetched data from api and storing favourites
- Used cached_network_image for caching network images
- Used Hero animation when transitioning to details page, and animate_do package for simple fade animation
- Used lottie animation for displaying empty data
- Used flutterscreen_util package for dynamic sizing and based the measurements on the figma design
## Developer

- [Janssen Delos Santos](https://www.linkedin.com/in/jangdsantos/)


## Demo

https://drive.google.com/file/d/1zs6vxW315PZiPTRtKtNsYbGRzAK5mazK/view

