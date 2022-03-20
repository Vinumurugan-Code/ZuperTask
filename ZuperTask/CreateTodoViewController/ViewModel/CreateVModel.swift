//
//  CreateVModel.swift
//  ZuperTask
//
//  Created by vinumurugan E on 19/03/22.
//

import Foundation

class CreateVModel: NSObject {
    
    func crateTodo(withInfo newTodo: Info, completion : @escaping(Info)->()) {
        do {
            let jsonData = try JSONEncoder().encode(newTodo)
            let jsonDic = try jsonData.dicValues(withData: jsonData)
            APIService.shared.request(for: Info.self, url: APIService.shared.baseURL, method: .post, body: jsonDic) { result in
                switch result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }

        } catch (let error) {
            print(error)
        }
    }

}

