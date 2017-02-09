# xtract

<p>Xtract Capstone Project</p>

<p>The app launches to a screen that lets you take a photo or choose a photo
from your album to 'xtract' (get the text from the image)</p>

<p>you will be presented with a `UIActivityIndicatorView` that shows that your app is loading</p>
![add](https://github.com/hmerzin/xtract/blob/master/new.PNG)
<p>if you do not have connection or there is a networking error you will be presented with a `UIAlertController`
informing you of the error</p>
![err](https://github.com/hmerzin/xtract/blob/master/err.PNG)
<p>if the request succeeds, you will be taken to the `DetailViewController` and you can edit the text and add a title</p>
![detail](https://github.com/hmerzin/xtract/blob/master/detail.PNG)
<p>The `UITabBarController` has two ViewControllers embedded in it, the add an image controller and the TableViewController
which displayes all of your xtracted items with the original image, title label and text label</p>
![tableview](https://github.com/hmerzin/xtract/blob/master/tbView.PNG)
<p>you can select these to go to the `DetailViewController` for each one or delete them</p>
![delete](https://github.com/hmerzin/xtract/blob/master/delete.PNG)
<p>each xtracted item is persisted locally on the device and can be accessed without network connection</p>

