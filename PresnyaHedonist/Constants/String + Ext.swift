//
//  String + Ext.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/21/21.
//
//
//import Foundation
//
//extension String {
//    func phoneFormatter() -> String {
//        let perfectPhone = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//        let format = "+ X (XXX) XXX-XX-XX"
//        var result = ""
//
//        var startIndex = perfectPhone.startIndex
//        var endIndex = perfectPhone.endIndex
//
//        for phone in format where startIndex < endIndex {
//            if phone == "X" {
//                result.append(perfectPhone[startIndex])
//                startIndex = perfectPhone.index(after: startIndex)
//            } else {
//                result.append(phone)
//            }
//        }
//        return result
//    }
//}
