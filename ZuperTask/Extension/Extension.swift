//
//  Extension.swift
//  ZuperTask
//
//  Created by vinumurugan E on 18/03/22.
//

import Foundation
import UIKit

enum AlertInfo: String {
    case info
    case warning
    case error
    
}

extension UIViewController {
    
    func showAlert(WithMessage message:String, AlertType type:AlertInfo = .info) {
        let alert = UIAlertController.init(title: type.rawValue, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension Data {
    
    func dicValues(withData data: Data) throws -> [String:Any]? {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
    }
}



struct Priority {
    static let low = "LOW"
    static let medium = "MEDIUM"
    static let high = "HIGH"
}

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
