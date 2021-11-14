//
//  ReusableProtocol.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 20.05.21.
//

import Foundation

public protocol ReuseIdProtocol: NSObjectProtocol {
    static func reuse_id() -> String
}
