//
//  Extension.swift
//  URLShortner
//
//  Created by Timotius Leonardo Lianoto on 03/08/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
