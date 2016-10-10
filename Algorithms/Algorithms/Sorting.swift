
import Foundation

/**
    Categorizes the output of a sorting algorithm.
*/
public enum Order {
    case ascending, descending
}


/**
    A collection of sorting algorithms.
*/
public struct Sorts {
    
    /**
        Array size:     N
        Compares:       ~(N^2) / 2
        Exchanges:      N
    */
    static func selectionSort<T>(array arr: [T], withOrder order: Order) -> [T] where T: Comparable {
        
        // Make a mutable copy and stats fields
        var retArr = arr
        var numCompares = 0
        var numExchanges = 0
        
        func compare<T>(value val: T, withValue testVal: T) -> Bool where T: Comparable {
        
            // Increment the stats
            numCompares += 1
        
            // Compare via order
            switch order {
            case .ascending: return testVal < val
            case .descending: return testVal > val
            }
        }
        
        func exchange(valueAtIndex index: Int, withValueAtIndex otherIndex: Int) {
            
            // Increment the stats
            numExchanges += 1
            
            // Copy the values
            let val = retArr[index]
            let otherVal = retArr[otherIndex]
            
            // Exchange the values
            retArr[index] = otherVal
            retArr[otherIndex] = val
        }
        
        func reportStats() {
            
            let expCompares = pow(Double(arr.count), 2)/2
            let errCompares = 100 * (expCompares - Double(numCompares)) / Double(numCompares)
            let errSwaps = 100 * Double(arr.count - numExchanges) / Double(numExchanges)
        
            print("\nExpected Compares = ~\(expCompares)")
            print("Actual Compares = \(numCompares)")
            print("Error in Compares = 0% - \(errCompares)%\n")
            
            print("Expected Swaps = \(arr.count)")
            print("Actual Swaps = \(numExchanges)")
            print("Error in Swaps = \(errSwaps)%")
            
            print("Unsorted array = \(arr)")
            print("Sorted array = \(retArr)\n")
        }
        
        // Operate on every single element in the array
        for i in retArr.indices where i < retArr.count - 1 {
            
            // Create a holder for the index of the current smallest/largest value
            var min: Int = i
            let unsortedArr = retArr[i...retArr.count - 1]
            
            // Loop through the unsorted array and find the smallest/largest value to exchange with
            for j in unsortedArr.indices {
                
                // Check if the current index in the unsorted array should be exchanged with its first index
                if compare(value: retArr[min], withValue: retArr[j]) {
                    min = j
                }
            }
            
            // Exchange the values, or exchange in place if there were no smaller/larger values
            exchange(valueAtIndex: i, withValueAtIndex: min)
        }
        
        // Close the function
        reportStats()
        return arr
    }
}

let arr = [6, 5, 4, 3, 2, 0, 1]
let _ = Sorts.selectionSort(array: arr, withOrder: .ascending)
