//
//  LRUCache.swift
//  MyCache
//
//  Created by Abbas Sabeti on 19.09.24.
//

import Foundation

actor LRUCache<Key: Hashable, Value> {
    private let capacity: Int
    private var dict: [Key: CacheNode<Key, Value>] = [:]
    private var head: CacheNode<Key, Value>?
    private var tail: CacheNode<Key, Value>?
    private var currentSize: Int = 0
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func get(forKey key: Key) -> Value? {
        
        guard let node = dict[key] else {
            return nil
        }
        
        moveToHead(node)
        return node.value
    }
    
    func set(_ value: Value, forKey key: Key, size: Int) {
        
        if let node = dict[key] {
            node.value = value
            node.size = size
            moveToHead(node)
        } else {
            let newNode = CacheNode(key: key, value: value, size: size)
            dict[key] = newNode
            addNodeToHead(newNode)
            currentSize += size
        }
        
        while currentSize > capacity {
            removeTail()
        }
    }
    
    private func moveToHead(_ node: CacheNode<Key, Value>) {
        if node === head { return }
        unchain(node)
        addNodeToHead(node)
    }
    
    private func addNodeToHead(_ node: CacheNode<Key, Value>) {
        node.next = head
        node.prev = nil
        head?.prev = node
        head = node
        if tail == nil {
            tail = head
        }
    }
    
    private func removeNode(_ node: CacheNode<Key, Value>) {
        unchain(node)
        dict.removeValue(forKey: node.key)
        currentSize -= node.size
    }
    
    private func unchain(_ node: CacheNode<Key, Value>) {
        if node === head {
            head = node.next
        }
        if node === tail {
            tail = node.prev
        }
        node.prev?.next = node.next
        node.next?.prev = node.prev
    }
    
    private func removeTail() {
        guard let tailNode = tail else { return }
        removeNode(tailNode)
    }
}
