//
//  SortingViewController.swift
//  GithubRepoAppSwift
//
//  Created by Raj Shekhar on 02/06/24.
//

import UIKit

class SortingViewController: UIViewController {
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var sortingTypeButton: UIButton!
    var selectedIndexes = [IndexPath.init(row: 0, section: 0)]
    var buttonTag:Int = 0
    var indexSelected:Int = 0
    var isFilter:Bool = false
    var repoVM = RepoListViewModel()
    var selectedSorting:((Sorting, Int)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.tableFooterView = UIView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        spaceView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
}

//MARK:- UITableViewDataSource, UITableViewDelegate Methods
extension SortingViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoVM.sortingItem.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SortingTVCell", for: indexPath) as? SortingTVCell {
            if(indexPath.row == indexSelected) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
             cell.titleLabel.text = repoVM.sortingItem[indexPath.row].rawValue
            return cell
        }
        return UITableViewCell()
    }
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        self.mainTableView.reloadData()
        selectedSorting?(repoVM.sortingItem[indexPath.item], indexSelected)
        dismiss(animated: true, completion: nil)
        
    }
  
    
}

