

import Foundation



/**
    Selection sort
    
    1. Get the first element in an array
    2. Create a subset that excludes the first element
    3. Compare each element in the subset with the first element from the original array
    4. Swap the first element of the original array
 
    2. Swap it with the first element the first element
    3. Repeat on subset of the array
*/

public enum Order {
    case ascending, descending
}

/**
    A static struct that exposes a single method for peforming a selection sort.
*/
public struct Selection {
    
    /**
        Sorts an array of comparable elements
    */
    public static func sort<T>(array arr: [T], startingAt startIndex: Int = 0, endingAt endIndex: Int = 0, order: Order) -> [T] where T: Comparable {
    
        // End recursion as needed
        let atEndIndex = startIndex == endIndex
        let atEndOfArray = arr.count - 1 == startIndex
        if atEndIndex || atEndOfArray {
            return arr
        }
    
        // Create a mutable integer that holds the index of the smallest value
        var min: Int = startIndex
        
        // Create a subset of the array of values to compare to
        let nextIndex = startIndex + 1
        let subArr = arr[nextIndex...arr.count - 1]
        
        // Loop through the subset array and compare values with the first
        for i in subArr.indices {
        
            if shouldSwap(value: arr[startIndex], withValue: arr[i], order: order) {
                min = i
            }
        }
        
        // Swap the elements and recurse
        let modifiedArr = swap(arr: arr, first: startIndex, second: min)
        return sort(array: modifiedArr, startingAt: nextIndex, endingAt: endIndex, order: order)
    }
    
    private static func shouldSwap<T>(value: T, withValue testVal: T, order: Order) -> Bool where T: Comparable {
    
        // Compare via order
        switch order {
        case .ascending: return value >= testVal
        case .descending: return value <= testVal
        }
    }
    
    private static func swap<T>(arr: [T], first: Int, second: Int) -> [T] where T: Comparable {
    
        // Create a mutable copy to return
        var ret = arr
        
        // Get the values
        let firstVal = arr[first]
        let secondVal = arr[second]
        
        // Swap the values
        ret[first] = secondVal
        ret[second] = firstVal
        
        return ret
    }
}

let arr = [1,6,43,50,3,2,2,5,67,54,0,9,5]
let sortedArr = Selection.sort(array: arr, endingAt: 3, order: .ascending)

arr.count
sortedArr.count

