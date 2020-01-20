/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import CoreData
import CoreSpotlight
import MobileCoreServices

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var people: [NSManagedObject] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "The List"
    tableView.register(UITableViewCell.self,
                       forCellReuseIdentifier: "Cell")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext

    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
    do {
      people = try managedContext.fetch(fetchRequest)
      self.setupSearchableContent()
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }

  @IBAction func addName(_ sender: UIBarButtonItem) {

    let alert = UIAlertController(title: "New Name",
                                  message: "Add a new name",
                                  preferredStyle: .alert)

    let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in

      guard let textField = alert.textFields?.first,
        let nameToSave = textField.text else {
          return
      }

      self.save(name: nameToSave)
      let addedIndex = self.people.count - 1
      guard addedIndex >= 0 else {
        return
      }
      let indexPath = IndexPath(row: self.people.count - 1, section: 0)
      self.tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }

    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .default)

    alert.addTextField()

    alert.addAction(saveAction)
    alert.addAction(cancelAction)

    present(alert, animated: true)
  }

  func save(name: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext

    guard let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext) else {
      return
    }

    let person = NSManagedObject(entity: entity,
                                 insertInto: managedContext)

    person.setValue(name, forKeyPath: "name")

    do {
      try managedContext.save()
      people.append(person)
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }

  func setupSearchableContent() {
    var searchableItems = [CSSearchableItem]()
    for person in people {
      guard let personName = person.value(forKeyPath: "name") as? String else {
        continue
      }
      let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
      searchableItemAttributeSet.title = personName
      searchableItemAttributeSet.contentDescription = "This is \(personName)"
      searchableItemAttributeSet.keywords = ["Laurentiu"]

      let searchableItem = CSSearchableItem(uniqueIdentifier: "com.appcoda.HitList.\(personName)", domainIdentifier: "people", attributeSet: searchableItemAttributeSet)
      searchableItems.append(searchableItem)
    }

    CSSearchableIndex.default().indexSearchableItems(searchableItems)
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return people.count
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let person = people[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                             for: indexPath)
    cell.textLabel?.text = person.value(forKeyPath: "name") as? String
    return cell
  }
}
