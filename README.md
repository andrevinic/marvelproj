# Marvel

# Marvel-Project

This is an example of iOS Marvel App using swift.

iOS project has the following configuration:

* Targets
  * marvelprojTests: Unit tests working with XCTest
  * marvelproj Production Target.

* Project Configuration
  * Swift language.
 
  * There is no third library
    - CoreData for favorite feature
    - URLSession for HTTP requests
    - JSONSerialization to convert json string to dictionary
    - Load activity animation
    
  * `strings.plist` in the folder `marvelproj/utils` containing:
    - characters url to fetch all characters limited in 20`
    - public key (Default there is my public key)
    - private key(Default there is my private key)
  * `unit-tests`
    - Unit tests
    * `MarvelConstants`
    -This file has all the project constants to configurate height, width, limits to fetch and others.
    * `Auto-Layout`
    -The auto-layout is done in the storyboard/main and also on the xibs, inside views/xibs.
    * `Images`
    -Used NSCache to cache all images downloaded with URLSerssion
    * `transition/threads`
    -In the transition view controller, I used DispatchGroup to wait all the thread fetches
  * `patterns`
  - Architecture: MVC. HTTManager to model, Views & Controllers

* Networking
  * `HTTPManager` networking class.
  * `CoreDataManager` to use favorite feature.


##### Usage - XCode 9.0 -> 9.3

Clone the repository:

```shell
git clone https://github.com/andrevinic/marvelproj.git
```
