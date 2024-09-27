# ``Cache Challenge``

This is my take on a showcase about how I would prioritize a Caching to be implemented for better user experience. ``I assumed that we are not allowed to use NSCache, as it already provides a great auto-purging functionality with memory.`` I felt like it should be an obvious forbidden factor in this task, as most likely NSCache already considers many more points for such caching behavior.

## Overview

In my understanding, there are two policies which brings better user experience:

1. To store recently seen images and avoid reloading them each time.
2. To decrease the long time loading as much as possible.

For addressing first requirement, I would just go for a Doubly-Linked-List to keep track what is seen recently to prioritize it for remaining in cache, yet constantly checking if we are not using too much memory for that.
And for addressing second requirement, I would say it's indeed a good call to behave large images (I would define them with a threshold in their size) as some separate category to invest memory for them. This means, I would split our memory budget in two sections: A relatively-small section would be dedicated to small images. and a relatively-larger portion of memory would be allocated to larger images. My reasoning is, larger images might be so much satisfaction-killer for our users. So, it might make sense to behave as some special content which large images. This brings the feeling that users with slow connection still can have a better user experience while scrolling our content.

## Implementation

### Caching

Long strory short, in a 4-hour time window, I just tried to implement this idea and simplify it enough to demonstrate how such an idea might be a good one when it comes to enhancing user experience. For that, I assumed any image larger than 2MB to be considered as a large image. I have 20MB capacity on memory for large images and 5MB capacity for small images. This allows me to showcase how the idea works in the example which I prepared in the main bundle of the app. I tried to set these values in a way which it demonstrates that both cache properties might get filled and hence, have some relatively-obsolete objects to get removed. But the sense that these two are separated from each other and just because smaller-image cache gets full, doesn't mean that we need to remove from the other.

I also felt like it's important to make sure that my Cache object is behaving correctly in a LRU (Least Recently Used) manner. So, I added some tests for it to assure that the oldest instances are getting killed in the stack and keep more recent items. Also, some other obvious expectations from the LRUCache is tested using unit tests. Like the Asynchronous addition of elements and expectation and it always should consider the capacity limit.

``Please pay attention that I just set these limits to properly demonstrate that each cache would reach to some limit at some time, even the big capacity for larger images is getting filled and hence some items are getting removed from there. In a real usecase, we might easily set these to something around 100MB or even much more to get better performance.``


### Showcase

In the app, I'm removing the saved image each time that the cell calls onDisappear method to demonstrate how caching would work. Also, I don't cancel the process of loading an image in the cache once the cell is getting disappearing, as it's still likely to user get back to this point of scroll more than other points in the scrolling path.

### Further ideas

I see many more points to be addressed for making this better. Some ideas from the top of my head:
1. It can be implemented as a scoring system rather than just checking for being bigger or smaller than a threshold size (2MB in my example). This way, we might consider more factors, like the state of memory and not to behaving completely different with an Image of size 1.9MB comparing to a 2.1MB. Overall, it sounds interesting to define a way to measure cost of loading the image and behave with it differently in terms of being cached. In the provided time-frame, I tried to demonstrate such idea with two separate caching properties in my Cache object.
2. We can make this more dynamic and more useful for usecase of the users. Like what if all the images are bigger than 2MB. For sure, it's more optimal to use the capacity of small images for large images in this case to make the performance even better.
3. Another idea, is to leverage some disk capacity for keeping the removed items from our in-memory cache in there, for some time. This way, we might have much larger capacity for loading items faster, especially when we consider slow internet connections, caching on disk might be a life-saver.
4. It feels cool to have compression for caching stuff as well, as it helps to keep much more in the memory with the current approach as well, just by compressing the stuff before storing them in memory and later decompress them. This can be used on the Disk for keeping much more items in the cache and bring much more efficient caching performance, when it comes to some repeated element in getting fetched.

Author: Abbas Sabetinezhad
