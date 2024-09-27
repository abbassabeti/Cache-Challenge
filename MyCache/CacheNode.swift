//
//  CacheNode.swift
//  MyCache
//
//  Created by Abbas Sabeti on 19.09.24.
//

import Foundation

class CacheNode<Key: Hashable, Value> {
    var key: Key
    var value: Value
    var size: Int
    var prev: CacheNode?
    var next: CacheNode?
    
    init(key: Key, value: Value, size: Int) {
        self.key = key
        self.value = value
        self.size = size
    }
}
