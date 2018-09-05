## How to use custom UITableViewCell
We use tableView in our applications almost on daily basis. So getting it right in terms of memory managment and neat coding style is important.  Here is how I use custom UITableViewCell in my applications.

First of all I do not create TableViewCell in StoryBoard because in that way we can not use it in multiple screens when needed. So I prefer using Xib. Follow the following steps to create a new UITableViewCell.

Go to File -> New -> File or just press ⌘N. Select CocoaTouch class and click on Next. Here Type the name of your custom UITableViewCell and make sure to subclass it from UITableViewCell.  Check the box next to "Also create Xib file" . Select Swift as language and click Next. Save the files on desired location and click on create.

Now lets assume that you named your cell as "HomeTableViewCell". Now design your cell according to your need. As you might already know that we need to dequeue the cell in order to get best, smooth and memory efficient experience. SO instead of doing all that stuff in our ViewController, lets try to write some clean code. So go to your  tableViewCell's swift file and add this method.


``` swift  
    class func cellForTableView(tableView: UITableView) -> HomeTableViewCell {
    let kSamleTableViewCellIdentifier = "kHomeTableViewCellIdentifier"
    tableView.register(UINib(nibName: "HomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: kHomeTableViewCellIdentifier)
    let cell = tableView.dequeueReusableCell(withIdentifier: kHomeTableViewCellIdentifier) as! HomeTableViewCell
    return cell
    }
```

To use this cell in our tableView we will do as follows in the ViewController:

``` swift 

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let cell = HomeTableViewCell.cellForTableView(tableView: tableView)
return cell
}
```

In this way our viewController will be much more cleaner. and we will not have a lot of code for each cell.
For first-hand experience, just clone the project and run it.
