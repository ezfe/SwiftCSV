//
//  String+Lines.swift
//  SwiftCSV
//
//  Created by Naoto Kaneko on 2/24/16.
//  Copyright © 2016 Naoto Kaneko. All rights reserved.
//

extension String {
    var firstLine: String {
        var index = startIndex
        while index < endIndex && self[index] != "\r\n" && self[index] != "\n" && self[index] != "\r" {
            index = self.index(index, offsetBy: 1)
        }
        return String(self[..<index])
    }
}
