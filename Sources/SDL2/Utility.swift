//
//  Utility.swift
//  SDL2
//
//  Created by Trevör Anne Denise on 09/11/2018.
//

import Foundation

func withUnsafePointerCascadingNil<T, Result>(of value: T?, body: ((UnsafePointer<T>?) throws -> Result)) rethrows -> Result {
    if let value = value {
        return try withUnsafePointer(to: value) { ptr in
            return try body(ptr)
        }
    } else {
        return try body(nil)
    }
}
