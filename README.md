## How to use custom UITableViewCell
We use tableView in our applications almost on daily basis. So getting it right in terms of memory managment and neat coding style is important.  Here is how I use custom UITableViewCell in my applications.

First of all I do not create TableViewCell in StoryBoard because in that way we can not use it in multiple screens when needed. So I prefer using Xib. Follow these steps to create a new UITableViewCell.

Go to File -> New -> File or just press ⌘N. Select CocoaTouch class and click on Next.

<img src="https://i.imgur.com/u7QdDFW.png" width="500" height="400" />

Here Type the name of your custom UITableViewCell and make sure to subclass it from UITableViewCell.  Check the box next to "Also create Xib file" . Select Swift as language and click Next. 

<img src="https://i.imgur.com/KEiF5Bx.png" width="500" height="400" />

Save the files on desired location and click on create.

Now lets assume that you named your cell as "HomeTableViewCell". Now design your cell according to your need. As you might already know that we need to dequeue the cell in order to get best, smooth and memory efficient experience. SO instead of doing all that stuff in our ViewController, lets try to write some clean code. So go to your  tableViewCell's swift file and add this method.


```swift  
class func cellForTableView(tableView: UITableView) -> HomeTableViewCell {
    let kSamleTableViewCellIdentifier = "kHomeTableViewCellIdentifier"
    tableView.register(UINib(nibName: "HomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: kHomeTableViewCellIdentifier)
    let cell = tableView.dequeueReusableCell(withIdentifier: kHomeTableViewCellIdentifier) as! HomeTableViewCell
    return cell
}
```
Make sure that each cell in your project is named uniquely and their identifier are also named accordingly. Otherwise you will get crash that will be hard to debug.

To use this cell in our tableView we will do as follows in the ViewController:

``` swift 

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = HomeTableViewCell.cellForTableView(tableView: tableView)
    return cell
}
```

In this way our viewController will be much more cleaner. and we will not have a lot of code for each cell. Now lets say that our cell have some buttons in it, like this

<img src="https://i.imgur.com/vPSDAaC.png" width="200" height="400" />

and we want to perfom some actions based on that in our ViewController. For this purpose first of all lets create IBActions for our buttons as follows:

```swift
@IBAction func acceptButtonTapped(_ sender: Any) {
}

@IBAction func rejectButtonTapped(_ sender: Any) {
}
```

We still need to figure out a way to responde to these buttons in our ViewController. There can be multiple ways to this but We will use Delegation. Open your cell class and at the top, right after import statements create a protocol as follows:

```swift
protocol HomeTableViewCellDelegate {
    func didTapAcceptButton(cell: HomeTableViewCell)
    func didTapRejectButton(cell: HomeTableViewCell)
}
```
Create a new variables as:

```swift
var delegate: HomeTableViewCellDelegate?
```

Now we will use this delegate for informing our ViewController about these actions, so update your IBActions as follows:

```swift
@IBAction func acceptButtonTapped(_ sender: Any) {
    delegate?.didTapAcceptButton(cell: self)
}

@IBAction func rejectButtonTapped(_ sender: Any) {
    delegate?.didTapRejectButton(cell: self)
}
```

Thatis it for the cell class, lets go back to our viewController and conform to this newly created protocol as follows:

```swift
extension HomeViewController: HomeTableViewCellDelegate {

    // MARK: - HomeTableViewCellDelegate
    
    func didTapAcceptButton(cell: HomeTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        print("did tap on row number \(String(describing: indexPath?.row)) do something accordingly")
    }
    
    func didTapRejectButton(cell: HomeTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        print("did tap on row number \(String(describing: indexPath?.row)) do something accordingly")
    }
}
```

At the end our ViewController would look something like this:

```swift
class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var names = ["Umair", "Afzal", "Ali", "Umer", "Huzaifa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }
}

extension HomeViewController: HomeTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeTableViewCell.cellForTableView(tableView: tableView)
        cell.setupCell(name: names[indexPath.row])
        return cell
    }
    
    // MARK: - HomeTableViewCellDelegate
    
    func didTapAcceptButton(cell: HomeTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        print("did tap on row number \(String(describing: indexPath?.row))")
    }
    
    func didTapRejectButton(cell: HomeTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        print("did tap on row number \(String(describing: indexPath?.row))")
    }
}
```

And our cell class would look something like this:

```swift
import UIKit

protocol HomeTableViewCellDelegate {
    func didTapAcceptButton(cell: HomeTableViewCell)
    func didTapRejectButton(cell: HomeHomeTableViewCell)
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var serviceLocationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    var delegate: HomeTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    class func cellForTableView(tableView: UITableView) -> HomeTableViewCell {
        let kSamleTableViewCellIdentifier = "kHomeTableViewCellIdentifier"
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: kHomeTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kHomeTableViewCellIdentifier) as! HomeTableViewCell
        return cell
    }

    func setupCell(name: String) { // pass required data like this
        nameLabel.text = name
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        delegate?.didTapAcceptButton(cell: self)
    }

    @IBAction func rejectButtonTapped(_ sender: Any) {
        delegate?.didTapRejectButton(cell: self)
    }
}

```

Thankyou for reading this, hope it helps you. For up and running code, clone the project.
