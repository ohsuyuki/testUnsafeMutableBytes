//
//  main.swift
//  testUnsafeMutableBytes
//
//  Created by osu on 2018/10/20.
//  Copyright © 2018 osu. All rights reserved.
//

import Foundation

var str = "ABC"
var data1 = str.data(using: String.Encoding.utf8)!
var data2 = Data(count: str.count * 2 + 3)
data2.withUnsafeMutableBytes {(bytes: UnsafeMutablePointer<UInt8>)->Void in
    let buffer = UnsafeMutableBufferPointer(start: bytes, count: str.count)
    data1.copyBytes(to: buffer)
}

data2.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<UInt8>)->Void in
    do {
        let rhs = UnsafeMutableRawPointer(bytes)
        let lhs = UnsafeMutableRawPointer(bytes+5)
        memcpy(lhs, rhs, 3)
    }

    do {
        let rhs = UnsafeMutableRawPointer(bytes)
        let lhs = UnsafeMutableRawPointer(bytes+1)
        memcpy(lhs, rhs, 3)
    }

    bytes[0] = 0x41 //A
    bytes[4] = 0x42 //B
    bytes[8] = 0x43 //C
}

print(String(data: data2, encoding: .utf8)!)
