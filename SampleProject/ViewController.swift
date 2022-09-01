//
//  ViewController.swift
//  SampleProject
//
//  Created by Bhagyalakshmi on 31/08/22.
//

import UIKit

class Group {
   var groupName: String?
   var typeName: [String]?
    var members: String?
   
     
    init(grpName: String, typName: [String], member: String) {
       self.groupName = grpName
       self.typeName = typName
        self.members = member
   }
}

class ViewController: UIViewController {
    
    var group = [Group]()
    var filteredGroup = [Group]()
    var searching = false

    @IBOutlet weak var srchShare: UISearchBar!
    @IBOutlet weak var btnGroup: UIButton!
    @IBOutlet weak var btnEvent: UIButton!
    @IBOutlet weak var tblData: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        group.append(Group.init(grpName: "Test Group", typName: ["Media Test","Group Chat"],member: "2 Participants"))
        group.append(Group.init(grpName: "Group 'crash test'", typName: ["Group Chat"],member: "5 Participants"))
        group.append(Group.init(grpName: "Comment Time Test", typName: ["Group Chat"],member: "5 Participants"))
        group.append(Group.init(grpName: "Event Push Issue Test", typName: ["Time Test","Group Chat"],member: "5 Participants"))
        
        hideKeyboardWhenTappedAround()
        
    }

    
    
    @IBAction func btnGrooupPressed(_ sender: UIButton) {
    }
   
    @IBAction func btnEventPressed(_ sender: Any) {
    }
   
}
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return searching ? filteredGroup.count : group.count
        //           return group.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
           view.backgroundColor =  UIColor .lightGray
           
           let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
           lbl.font = UIFont.boldSystemFont(ofSize: 15)
           lbl.text = group[section].groupName
 
        let lblSub = UILabel(frame: CGRect(x: 16, y: 15, width: view.frame.width - 15, height: 40))
        lblSub.font = UIFont.systemFont(ofSize: 10)
        lblSub.text = group[section].members
        
           view.addSubview(lbl)
        view.addSubview(lblSub)
           return view
         }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group[section].typeName?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = group[indexPath.section].typeName?[indexPath.row]
              return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50
    }
         
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 50
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
           searching = false
            filteredGroup.removeAll()
        } else {
           searching = true
            filteredGroup = group.filter{$0.groupName?.range(of: searchText, options: .caseInsensitive) != nil}
        }
        tblData.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

