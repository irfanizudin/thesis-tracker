//
//  ViewController.swift
//  ThesisTracker
//
//  Created by Irfan Izudin on 06/04/22.
//

import UIKit

struct Progress: Codable{
    var title: String
    var symbol: String
    var notStarted: Int
    var inProgress: Int
    var done: Int
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var data: [Progress] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        table.register(ProgressCell.nib(), forCellReuseIdentifier: ProgressCell.identifier)
        table.register(CompletionCell.nib(), forCellReuseIdentifier: CompletionCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        let defaults = UserDefaults.standard
        getData()

        let bookNotStarted = allTask.filter({return $0.category == "book" && $0.status == "notStarted"}).count
        let bookInProgress = allTask.filter({return $0.category == "book" && $0.status == "inProgress"}).count
        let bookDone = allTask.filter({return $0.category == "book" && $0.status == "done"}).count
        
        let implementNotStarted = allTask.filter({return $0.category == "implementation" && $0.status == "notStarted"}).count
        let implementInProgress = allTask.filter({return $0.category == "implementation" && $0.status == "inProgress"}).count
        let implementDone = allTask.filter({return $0.category == "implementation" && $0.status == "done"}).count

        
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(newTask) {
            defaults.set(encodedUser, forKey: "task")
        }
        
        let items = [
            Progress(title: "Book Progress", symbol: "books.vertical.fill", notStarted: bookNotStarted, inProgress: bookInProgress, done: bookDone),
            Progress(title: "Implementation Progress", symbol: "hammer.fill", notStarted: implementNotStarted, inProgress: implementInProgress, done: implementDone)
        ]
        data = items
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width-20, height: 60))
        header.backgroundColor = .clear
        
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 20, width: header.frame.width-20, height: header.frame.height-20)
        
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        
        if(section == 0){
            label.text = "My Progress"
        } else {
            label.text = "Tasks"
        }
        
        header.addSubview(label)
                
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width-20, height: 0))
        footer.backgroundColor = .clear
        return footer
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.section == 0 && indexPath.row == 0){
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyProgressViewController") as! MyProgressViewController
            navigationController?.pushViewController(vc, animated: true)
            print("My Progress")
        }
        else if(indexPath.section == 1 && indexPath.row == 0){
            let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
            
            vc.getIndex = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
            print("Tasks 1")
        }
        else if(indexPath.section == 1 && indexPath.row == 1){
            let vc = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
            vc.getIndex = indexPath.row

            navigationController?.pushViewController(vc, animated: true)
            print("Tasks 2")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return 196
        }else{
            return 102
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: ProgressCell.identifier, for: indexPath) as! ProgressCell
            
            cell.dateLabel.text = "Last Week"
            cell.timeDone.text = "2h 9m"
            cell.timeTarget.text = "3h 0m"
            cell.wordLabel.text = "Keep up the good work!"
            cell.emoticonImage.image = UIImage(systemName: "face.smiling")
            cell.layer.cornerRadius = 10
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CompletionCell.identifier, for: indexPath) as! CompletionCell
            let item = data[indexPath.row]
            
            cell.symbol.image = UIImage(systemName: item.symbol)
            cell.progressName?.text = item.title
            cell.inProgress?.text = String(item.inProgress)
            cell.notStarted?.text = String(item.notStarted)
            cell.done?.text = String(item.done)
            
            return cell

        }
        
    }


}

