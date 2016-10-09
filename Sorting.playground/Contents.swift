

import Foundation

/**
    Selection sort
    
    1. Get the first element in an array
    2. Create a subset that excludes the first element
    3. Compare each element in the subset with the first element from the original array
    4. Swap the first element of the original array
    5. Recursively sort with the modified array
    6. End recursion when either the end index or the array bounds has been reached
*/

public enum Order {
    case ascending, descending
}


/**
    The fields track the number of necessary swaps and compares. According to Algorithms, 
    4th ed. by Sedgewick, there should be ~(N^2)/2 compares and N swaps for an array of 
    size N.
*/
func selectionSort<T>(array arr: [T], startingAt startIndex: Int = 0, endingAt endIndex: Int = arr.count - 1, order: Order) -> [T] where T: Comparable {
    
    var numSwaps = 0
    var numCompares = 0
    
    // The primary recursive function for sorting
    func sort<T>(array arr: [T], startingAt startIndex: Int = 0, endingAt endIndex: Int = arr.count - 1, order: Order) -> [T] where T: Comparable {
        
        // End recursion as needed
        let atEndIndex = startIndex == endIndex
        let atEndOfArray = arr.count - 1 == startIndex
        if atEndIndex || atEndOfArray {
            
            // Report on the number of compares and swaps
            reportStats()
        
            // Clean up the fields
            numSwaps = 0
            numCompares = 0
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
    
    // A helper function that peforms a compare
    func shouldSwap<T>(value: T, withValue testVal: T, order: Order) -> Bool where T: Comparable {
        
        numCompares += 1
        
        // Compare via order
        switch order {
        case .ascending: return value >= testVal
        case .descending: return value <= testVal
        }
    }

    // A helper function that peforms a swap
    func swap<T>(arr: [T], first: Int, second: Int) -> [T] where T: Comparable {
    
        numSwaps += 1
    
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
    
    func reportStats() {
        
        let expCompares = pow(Double(numCompares), 2)/2
        let errCompares = 100 * (expCompares - Double(numCompares)) / Double(numCompares)
        let errSwaps = 100 * Double(arr.count - numSwaps) / Double(numSwaps)
    
        print("Expected Compares = ~\(expCompares)")
        print("Actual Compares = \(numCompares)")
        print("Error in Compares = \(errCompares)%\n")
        print("Expected Swaps = \(arr.count)")
        print("Actual Swaps = \(numSwaps)")
        print("Error in Swaps = \(errSwaps)%")
    }
    
    return sort(array: arr, startingAt: startIndex, endingAt: endIndex, order: order)
}


let arr = [0,4,5,3,5]
let arr2 = [4,5,3,5]
let sortedArr = selectionSort(array: arr, order: .ascending)
let sortedArr2 = selectionSort(array: arr2, order: .ascending)
arr.count
sortedArr.count

