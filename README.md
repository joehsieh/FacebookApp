ntroduction
FacebookApp is a project written in Swift for practice.
The basic prototype is from [letsbuildthatapp](http://example.com/ "Title"). And I will apply more and more features based on it.

# Limitation
- Swift 3 (At least XCode8 Beta 6)
- Manage third party libraries by Carthage. ( In order to make some libraries build successfully in Swift3, I've converted the Swift version to 3. )

# Feed page
- Apply dynamic height for the cells.
- Apply the mock data for posts.
- Use WebImage to fetch image and display it.
- Visual format language for autolayout.

# Carthage
- Fakery: For displaying the mock data in feed list.
- WebImage: For fetching, displaying and caching the image.
- SwiftyJSON: Used by Fakery.

# TODO
## Performance
- The rounded image for avatar and related discussion for masking view, how to make the performance be better.
