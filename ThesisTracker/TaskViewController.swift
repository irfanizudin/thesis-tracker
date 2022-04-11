//
//  TaskViewController.swift
//  ThesisTracker
//
//  Created by Irfan Izudin on 08/04/22.
//

import UIKit


class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var getIndex:Int?
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var category: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        table.register(BookCell.nib(), forCellReuseIdentifier: BookCell.identifier)
        table.delegate = self
        table.dataSource = self
        category.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        getData()

        if(getIndex == 0){
            category.selectedSegmentIndex = 0
            taskToDisplay = bookTask
            titleToDisplay = titleProgress[0]
        }else{
            category.selectedSegmentIndex = 1
            taskToDisplay = implementationTask
            titleToDisplay = titleProgress[1]
        }
        
    }
        
    
    let titleProgress = ["Book Progress", "Implementation Progress"]
    lazy var titleToDisplay = titleProgress[0]
        
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            print("bookTask")
            taskToDisplay = bookTask
            titleToDisplay = titleProgress[0]
        }else{
            print("implementTask")
            taskToDisplay = implementationTask
            titleToDisplay = titleProgress[1]
        }
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width-20, height: 60))

        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.text = titleToDisplay
        header.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: header.centerYAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 0).isActive = true
                
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let item = taskToDisplay[indexPath.row].title
        let uniqueId = taskToDisplay[indexPath.row].id
        
        let sheet = UIAlertController(title: "\(item)", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            self.taskToDisplay.filter {$0.id == uniqueId}
            self.taskToDisplay[indexPath.row].status = "done"
            self.table.reloadData()
            print("\(item) done")
        }))
        sheet.addAction(UIAlertAction(title: "In Progress", style: .default, handler: { _ in
            self.taskToDisplay.filter {$0.id == uniqueId}
            self.taskToDisplay[indexPath.row].status = "inProgress"
            self.table.reloadData()
            print("\(item) in progress")
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(sheet, animated: true)
        
        print(taskToDisplay[indexPath.row].title)
        print(uuid)
    }
        
    let id = 0
    
    let uuid = UUID().uuidString
    
    lazy var bookTask = allTask.filter { $0.category == "book" }
    lazy var implementationTask = allTask.filter { $0.category == "implementation" }
    lazy var taskToDisplay = bookTask
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as! BookCell
        
        cell.taskLabel.text = taskToDisplay[indexPath.row].title
        
        let imgStatus: UIImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 28, height: 28))
        
        if (taskToDisplay[indexPath.row].status == "notStarted") {
            imgStatus.image = UIImage(systemName: "circle")
            cell.tintColor = .systemRed
        } else if (taskToDisplay[indexPath.row].status == "inProgress") {
            imgStatus.image = UIImage(systemName: "circle.dashed")
            cell.tintColor = .systemYellow

        } else if (taskToDisplay[indexPath.row].status == "done") {
            imgStatus.image = UIImage(systemName: "checkmark.circle")
            cell.tintColor = .systemGreen
        }
        imgStatus.contentMode = .scaleAspectFit
        cell.accessoryView = imgStatus
        
        return cell
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
