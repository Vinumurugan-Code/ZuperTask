//
//  TodoTableViewController.swift
//  ZuperTask
//
//  Created by vinumurugan E on 18/03/22.
//

import UIKit

class TodoTableViewController: UITableViewController,UISearchResultsUpdating, UISearchControllerDelegate, UIPopoverPresentationControllerDelegate, UISearchBarDelegate, Createprotocol {
    
    let searchVC: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search by todo.."
        let scb = searchController.searchBar
        scb.tintColor = UIColor.lightGray
        scb.barTintColor = UIColor.lightGray
        if let textfield = scb.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        return searchController
    }()
    
    lazy var loaderMoreView: UIView = {
        let loaderView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        loaderView.color = UIColor.gray
        loaderView.startAnimating()
        return loaderView
    }()
    
    
    lazy var dataSource : ListTableViewDataSource<Info> = {
        let dataSource = ListTableViewDataSource<Info>()
        dataSource.mode = .Todo
        return dataSource
    }()
    
    lazy var viewModel : ListViewModel = {
        let viewModel = ListViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC.delegate = self
        searchVC.searchBar.delegate = self
        self.tableView.dataSource = self.dataSource
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = UIColor.white
        }
        navigationItem.searchController = searchVC
        navigationItem.hidesSearchBarWhenScrolling = false
        self.viewModel.callFuncTodoList()
        self.dataSource.data.addAndNotify(observer: self) {  _ in
            self.updateDataSource()
        }
    }
    
    
    //MARK:- UI Update
    
    func updateDataSource(_ searchText: String? = nil) {
        var infoArr : [Info] = [Info]()
        if let searchTex = searchText, !searchTex.isEmpty {
            infoArr = self.dataSource.data.value.filter({($0.title ?? "").lowercased().contains(searchTex.lowercased()) })
        } else {
            infoArr = self.dataSource.data.value
        }
        self.dataSource.local.value = infoArr
        
        DispatchQueue.main.async { [weak self] in
            if infoArr.count > 0 {
                self?.searchVC.obscuresBackgroundDuringPresentation = false
            } else {
                self?.searchVC.obscuresBackgroundDuringPresentation = true
            }
                self?.tableView.reloadData()
        }
    }
    
    
    func updateValue(info :Info) {
        self.dataSource.data.value.append(info)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.updateDataSource(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.updateDataSource()
    }
    
    //MARK:- UI UIScrollView
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            self.setUpLoaderView(toShow: true)
            self.viewModel.callFuncTodoList()
        }
    }
    
    func setUpLoaderView(toShow: Bool) {
        if toShow {
            self.tableView.tableFooterView?.isHidden = false
            self.tableView.tableFooterView = self.loaderMoreView
        } else {
            self.tableView.tableFooterView = UIView()
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        print("hello")
    }
    
    
    @IBAction func AddAction(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateViewController") as! CreateViewController
        vc.idelegate = self
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height/2)
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popover.sourceView = self.view
        popover.sourceRect = CGRect(x: 0, y: self.view.bounds.midY, width: self.view.frame.width, height: self.view.frame.height/2)
        self.present(vc, animated: true, completion:nil)
    }
    
}



