import Foundation

//MARK: - 1) Сортировка подсчетом (Counting Sort)

func countingSort(array: Array<Int>) -> Array<Int> {
    let maxElement = array.max() ?? 0
    var countArray = Array<Int>(repeating: 0, count: Int(maxElement + 1))
    for element in array {
      countArray[element] += 1
    }
    for index in 1 ..< countArray.count {
      let sum = countArray[index] + countArray[index - 1]
      countArray[index] = sum
    }
    var sortedArray = Array<Int>(repeating: 0, count: array.count)
    for element in array {
      countArray[element] -= 1
      sortedArray[countArray[element]] = element
    }
    return sortedArray
}

//let array = [1, 2, 1, 7, 8, 0, 17, 2, 1, 8, 7]
//let sortArray = countingSort(array: array)
//print("counting sort \(sortArray)")

//MARK: - 2) Блочная сортировка (Bucket sort)

func bucketSort(array: Array<Int>) -> Array<Int> {
    guard array.count > 0 else { return [] }
    let max = array.max()!
    var buckets = Array<Int>(repeating: 0, count: (max + 1))
    var sortArray = Array<Int>()
    for i in 0..<array.count {
        buckets[array[i]] = buckets[array[i]] + 1
    }
    buckets.enumerated().forEach { index, value in
        guard value > 0 else { return }
        sortArray.append(contentsOf: Array<Int>(repeating: index, count: value))
    }
    return sortArray
}

//let array = [1, 2, 1, 7, 8, 0, 17, 2, 1, 8, 7]
//let sortArray = bucketSort(array: array)
//print("bucket sort \(sortArray)")


//MARK: - 3) Сортировка слиянием (Merging Sort)

func mergeSort(_ resultArray: Array<Int>) -> Array<Int> {
    
    guard resultArray.count > 1 else { return resultArray }
    let middleIndex = resultArray.count / 2
    let leftArray = mergeSort(Array(resultArray[0..<middleIndex]))
    let rightArray = mergeSort(Array(resultArray[middleIndex..<resultArray.count]))
    
    func merge(leftPartArray: Array<Int>, rightPartArray: Array<Int>) -> Array<Int> {
        var leftIndex = 0; var rightIndex = 0
        var orderedPile = Array<Int>()
        orderedPile.reserveCapacity(leftPartArray.count + rightPartArray.count)
        while leftIndex < leftPartArray.count && rightIndex < rightPartArray.count {
            if leftPartArray[leftIndex] < rightPartArray[rightIndex] {
                orderedPile.append(leftPartArray[leftIndex])
                leftIndex += 1
            } else if leftPartArray[leftIndex] > rightPartArray[rightIndex] {
                orderedPile.append(rightPartArray[rightIndex])
                rightIndex += 1
            } else {
                orderedPile.append(leftPartArray[leftIndex])
                leftIndex += 1
                orderedPile.append(rightPartArray[rightIndex])
                rightIndex += 1
            }
        }
        while leftIndex < leftPartArray.count {
            orderedPile.append(leftPartArray[leftIndex])
            leftIndex += 1
        }
        while rightIndex < rightPartArray.count {
            orderedPile.append(rightPartArray[rightIndex])
            rightIndex += 1
        }
        return orderedPile
    }
    return merge(leftPartArray: leftArray, rightPartArray: rightArray)
}

//let array1 = [1, 4, 2, 7, 8, 17, 18]
//let array2 = [3, 6, 21, 22, 29, 13]
//let sortArray = mergeSort(array1 + array2)
//print("merge sort \(sortArray)")

//MARK: - 4) Быстрая сортировка (Quick Sort)

func quickSort<T: Comparable>(array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    let pivot = array[array.count / 2]
    let less    = array.filter   { $0 < pivot }
    let equal   = array.filter   { $0 == pivot }
    let greater = array.filter   { $0 > pivot }
    return quickSort(array: less) + equal + quickSort(array: greater)
}

//let array = [37, 1, 2, 1, -7 ,7, 8, 0, -2, 17, 2, 20, 1, 8, 7]
//let sortArray = quickSort(array: array)
//print("quick sort: \(sortArray)")

//MARK: - 5) Bubble Sort

func bubbleSort(sortArray: Array<Int>) -> Array<Int> {
    
    var array = sortArray
    for i in 0..<array.count {
        var isSorted = true
        for j in 1..<array.count - i {
            if array[j] < array[j-1] {
                let tmp = array[j-1]
                array[j-1] = array[j]
                array[j] = tmp
                isSorted = false
            }
        }
        if isSorted { break }
    }
    return array
}
//var bubbleSortArray = [1, 5, 0, 2, 9, 12]
//let newArray = bubbleSort(sortArray: bubbleSortArray)
//print(newArray)
//O(n^2)
