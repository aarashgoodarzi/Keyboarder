//
//  AtomicValue.swift
//  Keyboarder
//
//  Created by Arash Goodarzi on 1/23/20.
//

import Foundation

import Foundation

final class Atomic<T> {
    
    private let queue = DispatchQueue(label: "atomic.serial.queue")
    private var _value: T {
        didSet {
            didSetValue?()
        }
    }
    var didSetValue: (() -> Void)?
    var value: T {
        get {
            return queue.sync {
                return _value
            }
        }
        
        set (value) {
            queue.sync {
                _value = value
                
            }
        }
    }
    
    init (_ value: T) { _value = value }

}
