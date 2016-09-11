# Introduction
FacebookApp is a project written in Swift for practice.
The basic prototype is from [letsbuildthatapp](http://videos.letsbuildthatapp.com/playlist/Facebook-Feed/video/How-to-Create-Facebook-Feed-(Ep-1) "Title"). And I will apply more and more features based on it.

# Limitation
- Swift 3 (At least XCode8)
- Manage third party libraries by Carthage. ( In order to make some libraries build successfully in Swift3, I've converted the Swift version to 3. )

# Feed page
- Apply dynamic height for the cells.
- Apply the mock data for the posts. // Build Fakery failed when using XCode 8 and Swift3, so we don't use Fakery in the transition period.
- Use WebImage to fetch image and display it.
- Visual format language for autolayout.

# Carthage
- WebImage: For fetching, displaying and caching the image.

# TODO
Add a blog to explain what rasterization is.
Apply the function of showing the action menu after clicking the right-top button on the card in the FeedView. 

## Performance
- The rounded image for the avatar, how to make the performance of showing the rouned corner images better. Here is a blog to discuss this problem.
[What is offscreen rendering ?](https://medium.com/@ninja31312/what-is-offscreen-rendering-636df95225be#.y4egd4neh)
