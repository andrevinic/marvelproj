# Marvel

# Marvel-Project

This is an example of iOS Marvel App using swift.

iOS project has the following configuration:

* Targets
  * marvelprojTests: Unit tests working with XCTest and KIF_Quick
  * marvelproj Production Target.

* Project Configuration
  * Swift language.
 
  * There are few libraries
    - CoreData for favorite feature
    - Alamofire for HTTP requests
    - JSONSerialization with Codable swift 4
    - Load activity animation
    
  * At first, run pod install and insert private & public key
    - characters url to fetch all characters limited in 50`
    - public key (get on marvel api ```https://developer.marvel.com/```)
    - private key(get on marvel api ```https://developer.marvel.com/```)

  * `unit-tests`
    - Unit tests
  * `MarvelConstants`
    -This file has all the project constants to configurate height, width, limits to fetch and others.
  * `Auto-Layout`
    -The auto-layout is done in the storyboard/main and also on the xibs, inside views/xibs.
    * `Images`
    - Using KingFisher
    * `transition/threads`
    -In the transition view controller, I used DispatchGroup to wait all the thread fetches
  * `patterns`
  - Architecture: MVC. HTTManager to model, Views & Controllers

* Networking
  * `HTTPManager` networking class.
  * `CoreDataManager` to use favorite feature.


##### Usage - XCode 9.0 -> 9.3
You can open the marvelproj.xcodeproj file and run it and run as 'test' to check the tests

Clone the repository:

```shell
git clone https://github.com/andrevinic/marvelproj.git
```

![alt text](https://github.com/andrevinic/marvelproj/blob/master/marvel_images/Screen%20Shot%202018-05-13%20at%2023.28.21.png) ![alt text](https://github.com/andrevinic/marvelproj/blob/master/marvel_images/Screen%20Shot%202018-05-13%20at%2023.30.22.png) ![alt text](https://github.com/andrevinic/marvelproj/blob/master/marvel_images/Screen%20Shot%202018-05-13%20at%2023.28.30.png)

![alt text](https://github.com/andrevinic/marvelproj/blob/master/marvel_images/Screen%20Shot%202018-05-13%20at%2023.28.38.png) ![alt text](https://github.com/andrevinic/marvelproj/blob/master/marvel_images/Screen%20Shot%202018-05-13%20at%2023.28.46.png) ![alt text](https://github.com/andrevinic/marvelproj/blob/master/marvel_images/Screen%20Shot%202018-05-13%20at%2023.29.53.png) ![alt text](https://github.com/andrevinic/marvelproj/blob/master/marvel_images/Screen%20Shot%202018-05-13%20at%2023.30.02.png) 
