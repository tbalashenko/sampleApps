//
//  String+Ex.swift
//  MTBScreen
//
//  Created by Татьяна Балашенко on 26.04.21.
//

import Foundation

extension String {
    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
}
