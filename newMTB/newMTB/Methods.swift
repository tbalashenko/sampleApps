//
//  Methods.swift
//  newMTB
//
//  Created by Tatyana Balashenko on 13.05.21.
//

import Foundation

public func typeName(_ some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}
