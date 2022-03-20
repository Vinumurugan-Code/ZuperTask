//
//  ListViewModel.swift
//  ZuperTask
//
//  Created by vinumurugan E on 19/03/22.
//

import Foundation

class ListViewModel: NSObject {
        
    var page = 1
    
    var limit = 15
        
    var isFetching = false
        
    weak var dataSource : ListTableViewDataSource<Info>!
    
    init(dataSource : ListTableViewDataSource<Info>!) {
        self.dataSource = dataSource
    }
    
    func callFuncTodoList() {
        if isFetching {
            return
        }
        isFetching = true
        
        APIService().request(for: Todo.self, url: "\(APIService.shared.baseURL)?_page=\(page)&_limit=\(limit)&author=Ranjith", method: .get) { (result) in
            switch result {
            case let .success(list):
                self.page += 1
                self.dataSource?.data.value.append( contentsOf: list.data )
                self.isFetching = false
                print(list)
            case let .failure(Error):
                print(Error)
            }
        }
    }
}
