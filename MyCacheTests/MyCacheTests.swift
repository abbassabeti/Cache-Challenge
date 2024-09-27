//
//  MyCacheTests.swift
//  MyCacheTests
//
//  Created by Abbas Sabeti on 19.09.24.
//

import XCTest
@testable import MyCache

final class LRUCacheTests: XCTestCase {

    func testInsertAndRetrieve() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 10)
        await cache.set(100, forKey: "a", size: 1)
        
        // When
        let value = await cache.get(forKey: "a")
        
        // Then
        XCTAssertEqual(value, 100, "Value for key 'a' should be 100.")
    }

    func testEvictionPolicy() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 2)
        await cache.set(1, forKey: "a", size: 1)
        await cache.set(2, forKey: "b", size: 1)
        
        // When
        await cache.set(3, forKey: "c", size: 1) // Should evict key "a"
        
        // Then
        let valueA = await cache.get(forKey: "a")
        let valueB = await cache.get(forKey: "b")
        let valueC = await cache.get(forKey: "c")

        XCTAssertNil(valueA, "Key 'a' should have been evicted.")
        XCTAssertEqual(valueB, 2, "Value for key 'b' should be 2.")
        XCTAssertEqual(valueC, 3, "Value for key 'c' should be 3.")
    }

    func testUpdateExistingKey() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 10)
        await cache.set(100, forKey: "a", size: 1)
        
        // When
        await cache.set(200, forKey: "a", size: 1)
        
        // Then
        let value = await cache.get(forKey: "a")
        XCTAssertEqual(value, 200, "Value for key 'a' should be updated to 200.")
    }

    func testAccessUpdatesLRUOrder() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 2)
        await cache.set(1, forKey: "a", size: 1)
        await cache.set(2, forKey: "b", size: 1)
        
        // When
        _ = await cache.get(forKey: "a") // Access "a" to make it most recently used
        await cache.set(3, forKey: "c", size: 1) // Should evict "b"
        
        // Then
        let valueA = await cache.get(forKey: "a")
        let valueB = await cache.get(forKey: "b")
        let valueC = await cache.get(forKey: "c")

        XCTAssertEqual(valueA, 1, "Value for key 'a' should be 1.")
        XCTAssertNil(valueB, "Key 'b' should have been evicted.")
        XCTAssertEqual(valueC, 3, "Value for key 'c' should be 3.")
    }

    func testCapacityZero() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 0)
        
        // When
        await cache.set(100, forKey: "a", size: 1)
        
        // Then
        let value = await cache.get(forKey: "a")
        XCTAssertNil(value, "Cache with capacity 0 should not store any items.")
    }

    func testItemLargerThanCapacity() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 5)
        
        // When
        await cache.set(100, forKey: "a", size: 10)
        
        // Then
        let value = await cache.get(forKey: "a")
        XCTAssertNil(value, "Item larger than capacity should not be stored.")
    }

    func testMultipleEvictions() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 5)
        await cache.set(1, forKey: "a", size: 2)
        await cache.set(2, forKey: "b", size: 2)
        
        // When
        await cache.set(3, forKey: "c", size: 2) // Should evict "a"
        
        // Then
        let valueA = await cache.get(forKey: "a")
        let valueB = await cache.get(forKey: "b")
        let valueC = await cache.get(forKey: "c")

        XCTAssertNil(valueA, "Key 'a' should have been evicted.")
        XCTAssertEqual(valueB, 2, "Value for key 'b' should be 2.")
        XCTAssertEqual(valueC, 3, "Value for key 'c' should be 3.")
    }

    func testSizeUpdateOnSet() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 5)
        await cache.set(1, forKey: "a", size: 2)
        await cache.set(2, forKey: "b", size: 2)
        
        // When
        await cache.set(3, forKey: "a", size: 1) // Update "a" with smaller size
        
        // Then
        let valueA = await cache.get(forKey: "a")
        let valueB = await cache.get(forKey: "b")

        XCTAssertEqual(valueA, 3, "Value for key 'a' should be updated to 3.")
        XCTAssertEqual(valueB, 2, "Value for key 'b' should be 2.")
    }

    func testRemovalOfNonExistentKey() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 5)
        await cache.set(1, forKey: "a", size: 1)
        await cache.set(2, forKey: "b", size: 1)
        
        // When
        let valueC = await cache.get(forKey: "c")
        
        // Then
        XCTAssertNil(valueC, "Value for key 'c' should be nil as it doesn't exist.")
    }

    func testConcurrentAccess() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 5)
        let totalKeys = 100
        let expectedCacheSize = min(5, totalKeys) // Since capacity is 5

        // When
        await withTaskGroup(of: Void.self) { group in
            for i in 0..<totalKeys {
                group.addTask {
                    await cache.set(i, forKey: "\(i)", size: 1)
                }
            }
        }

        // Then
        // Collect all values in the cache
        var cachedValues = [Int]()
        for i in 0..<totalKeys {
            if let value = await cache.get(forKey: "\(i)") {
                cachedValues.append(value)
            }
        }

        // Check that the cache contains the expected number of items
        XCTAssertEqual(cachedValues.count, expectedCacheSize, "Cache should contain \(expectedCacheSize) items.")
        
        // Verify that all cached values are within the expected range
        for value in cachedValues {
            XCTAssertTrue((0..<totalKeys).contains(value), "Value \(value) should be between 0 and \(totalKeys - 1).")
        }
    }

    func testCurrentSizeAccuracy() async {
        // Given
        let cache = LRUCache<String, Int>(capacity: 5)
        await cache.set(1, forKey: "a", size: 2)
        await cache.set(2, forKey: "b", size: 2)
        await cache.set(3, forKey: "c", size: 1)
        
        // When
        // Expose currentSize for testing purposes (if possible)
        let mirror = Mirror(reflecting: cache)
        if let currentSize = mirror.descendant("currentSize") as? Int {
            // Then
            XCTAssertEqual(currentSize, 5, "Current size should be 5.")
        } else {
            // Then
            XCTFail("Unable to access currentSize for testing.")
        }
    }
}
