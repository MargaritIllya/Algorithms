import Foundation

//MARK: - 1) Реализовать бинарный поиск числа в массиве.

func binarySearch<T:Comparable>(inputArray:Array<T>,
                                searchNumber: T,
                                completion: @escaping (Int?, Bool) -> Void) {
    var beginIndex = 0;
    var endIndex = inputArray.count - 1
    while beginIndex <= endIndex {
        let middleIndex = Int((beginIndex + endIndex) / 2)
        if inputArray[middleIndex] == searchNumber { completion(middleIndex, true); return }
        if searchNumber < inputArray[middleIndex] {
            endIndex = middleIndex - 1
            continue
        } else if searchNumber > inputArray[middleIndex] {
            beginIndex = middleIndex + 1
            continue
        }
    }
    completion(nil, false)
}

//var testBinarySearchArray = [1, 2, 3, 4, 5, 6, 7, 9, 10, 11];
//let searchNumber = 7
//binarySearch(inputArray: testBinarySearchArray,
//             searchNumber: searchNumber) { (index, success) in
//    if success {
//        print("the number \(searchNumber) is at the index \(index!) in the array")
//    } else {
//        print("there is no such number in the array")
//    }
//}
// n: O(log2 n)
// m: O(1)


//MARK: - //2) Задан массив целых чисел и искомое число Т. Найти в массиве два числа, сумма которых равна Т.

//MARK: Example 1

func searchNumbersForSum(inputArray: Array<Int>,
                         sum: Int,
                         completion: @escaping (Int?, Int?, Bool) -> Void) {
    
    let sortArray = inputArray.sorted()
    var firstIndex: Int = 0
    var lastIndex: Int = sortArray.count - 1
    while firstIndex < lastIndex {
        
        let num1 = sortArray[firstIndex]
        let num2 = sortArray[lastIndex]
        let currentSum = num1 + num2
        if currentSum == sum {
            completion(num1, num2, true); return
        } else {
            if currentSum < sum {
                firstIndex += 1
            } else if currentSum > sum {
                lastIndex -= 1
            }
        }
    }
    completion(nil, nil, false); return
}

//MARK: Example 2

func searchNumbersForSum(inputArray: Array<Int>, sum: Int) -> Array<Int> {
    var dict: [Int: Int] = [:]
    var result: [Int] = []
    for (i, j) in inputArray.enumerated() {
        if let index = dict[sum - j] {
            result.append(index)
            result.append(i)
            return result
        }
        dict[j] = i
    }
    return result
}

/*
 //Test Example 1
 
 let testSearchSumArray = [3, 7, 8, 1, 2, 4, 5, 6, 9, 10, 11, 48, 52];
 let sum = 10
 searchNumbersForSum(inputArray: testSearchSumArray,
                     sum: sum) { (num1, num2, success) in
     if success {
         print("\(sum) = \(num1!) + \(num2!)")
     } else {
         print("fail")
     }
 }
  n: О(n*log2(n))
  m: O(1)
 
 //Test Example 2

 let testSearchSumArray = [3, 7, 8, 1, 2, 4, 5, 6, 9, 10, 11, 48, 52];
 let sum = 5
 print(searchNumbersForSum(inputArray: testSearchSumArray, sum: sum))
 */


//MARK: - 3) Транспонировать матрицу

func matrixTask3() {

    typealias Matrix = [[Int]]
    var matrix: Matrix = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    matrix[0][0] = 1
    matrix[0][1] = 2
    matrix[1][0] = 3
    matrix[1][1] = 4
    print("before: \(matrix)")
    for i in 0..<matrix.count {
        for j in 0..<i {
            let tmp = matrix[i][j]
            matrix[i][j] = matrix[j][i]
            matrix[j][i] = tmp
        }
    }
    print("after: \(matrix)")
}
//matrixTask3()
//c - кол-во столбцов или рядов
// n: O(n^c)


//MARK: - 4) Задан одномерный массив чисел. Перенести все нули в конец массива. Порядок остальных чисел не важен.

func oneDimensionalArrayTest() {
    
    var array = [0, 4, 6, 0, 8, 9, 0, 3]
    var numZeros = 0
    for (index, value) in array.enumerated() {
        //index - represents a consecutive integer starting at zero and
        //value - represents an element of the sequence
        if value == 0 {
            numZeros += 1
        } else if numZeros > 0 {
            // move every non-zero element left
            array[index - numZeros] = value
            array[index] = 0
        }
    }
    print(array)
}

//oneDimensionalArrayTest()
// n: O(n)
// m: O(1)


//MARK: - 5) Перемножить две матрицы

func matrixTask5() {

    typealias Matrix = [[Int]]
    let n = 3
    var matrixA: Matrix = Array(repeating: Array(repeating: 0, count: n), count: n)
    matrixA[0][0] = 0; matrixA[0][1] = 9; matrixA[0][2] = 1
    matrixA[1][0] = 1; matrixA[1][1] = 3; matrixA[1][2] = 7
    matrixA[2][0] = 2; matrixA[2][1] = 7; matrixA[2][2] = 0
    var matrixB: Matrix = Array(repeating: Array(repeating: 0, count: n), count: n)
    matrixB[0][0] = 0; matrixB[0][1] = 9; matrixB[0][2] = 8
    matrixB[1][0] = 0; matrixB[1][1] = 9; matrixB[1][2] = 9
    matrixB[2][0] = 1; matrixB[2][1] = 9; matrixB[2][2] = 6
    var matrixC: Matrix = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    print("matrixA: \(matrixA), matrixB: \(matrixB)")
    
    for i in 0..<matrixA.count {
        for j in 0..<matrixB.count {
            matrixC[i][j] = 0
            for k in 0..<n {
                matrixC[i][j] += matrixA[i][k] * matrixB[k][j]
            }
        }
    }
    print("result: \(matrixC)")
}
//matrixTask5()
// n: O(n^c) //c = 3
// m: O(1)


//MARK: - 6) Есть два массива цифр А и В. Узнать сколько раз встречается в массиве В числа из массива А. Например: А = {1,3,5,1,3,8} B = {1 4 1 4 6 3 7 5} => ответ 4

func taskSix() {
    let arrayA = [1, 3, 5, 1, 3, 8]
    let arrayB = [1, 4, 1, 4, 6, 3, 7, 5]
    let setA = Set(arrayA)
    var coincidence = 0
    for num in setA {
        for i in arrayB {
            if i == num {
                coincidence += 1
            }
        }
    }
    print("coincidence: \(coincidence)")
}

//taskSix()
// n: O(n^2) || O(Na*Nb)
// m: О(Na)

//MARK: - 7) Дано два положительных целых числа. Найти расстояние Хэмминга  для двоичного и для десятичного представления чисел.

func hammingDistance(x: Int, y: Int) -> Int {
    let signedDifferentBits = x ^ y
    var differentBits: Int = signedDifferentBits
    var counter = 0
    while differentBits > 0 {
        let maskedBits = differentBits & 1
        if maskedBits != 0 { counter += 1 }
        differentBits = differentBits >> 1
    }
    return counter
}

//let x = 3
//let y = 7
//let hd = hammingDistance(x: x, y: y)
//print("Hamming Distance between \(x) and \(y) = \(hd)")

// n: O(n) //n - differentBits
// m: О(1)

//MARK: - 8) Удалить дубликаты из отсортированного массива.

func removeDuplicates(array: inout [Int]) -> [Int] {
    var index: Int = 0
    var last: Int?
    while index < array.count {
        if array[index] == last {
            array.remove(at: index)
        } else {
            last = array[index]
            index += 1
        }
    }
    return array
}

//var array = [0, 0, 1, 2, 2, 2, 3]
//let result = removeDuplicates(array: &array)
//print(result)
// O(n)

//MARK: - 9) Найти самый короткий несортированный непрерывный подмассив
/*
 На вход подается массив, в этом массиве нужно найти такой подмассив, который,
 если вы отсортируете в порядке возрастания, отсортирует весь массив в порядке возрастания
 */

func unsortedSubarrayLength(array: [Int]) -> Int {
    let n = array.count
    if n == 0 { return 0 }
    var maxNum = array[0]
    var minNum = array[n - 1]
    var start = 1
    var end = 0
    for (index, currentItem) in array.enumerated() {
        maxNum = max(maxNum, currentItem)
        minNum = min(minNum, array[n - 1 - index])
        if currentItem < maxNum {
            end = index
        }
        if array[n - 1 - index] > minNum {
            start = n - 1 - index
        }
    }
    return end - start + 1
}

//let result = unsortedSubarrayLength(array: [1, 6, 6, 2, 3, 8])
//print(result)

//MARK: - 10) Обратная строка

func reverseString(_ string: inout [Character]) {
    var last = string.count - 1
    var first: Int = 0
    while first < last {
        (string[first], string[last]) = (string[last], string[first])
        first += 1
        last -= 1
    }
}

//var charArray: [Character] = ["H", "e", "l", "l", "o", "!"]
//reverseString(&charArray)
// n: O(n)
// m: О(1)

//MARK: - 11) Вернуть true, если в двух строках между ними будет не более одного отличия

func isOneAwaySomeLength(first: String, second: String) -> Bool {
    var countDifferent = 0
    for i in 0...first.count - 1 {
        let firstIndex = first.index(first.startIndex, offsetBy: i)
        let secondIndex = second.index(second.startIndex, offsetBy: i)
        if first[firstIndex] != second[secondIndex] {
            countDifferent += 1
            if countDifferent > 1 {
                return false
            }
        }
    }
    return countDifferent == 0 ? false : true
}

func isOneAwayDiffLength(first: String, second: String) -> Bool {
    var countDifferent = 0
    var i = 0
    while i < second.count {
        let firstIndex = first.index(first.startIndex, offsetBy: i + countDifferent)
        let secondIndex = second.index(second.startIndex, offsetBy: i)
        if first[firstIndex] == second[secondIndex] {
            i += 1
        } else {
            countDifferent += 1
            if countDifferent > 1 {
                return false
            }
        }
    }
    return true
}

func isOneAway(first: String, second: String) -> Bool {
    if first.count - second.count >= 2 ||
        second.count - first.count >= 2 {
        return false
    } else if first.count == second.count {
        return isOneAwaySomeLength(first: first, second: second)
    } else if first.count > second.count {
        return isOneAwayDiffLength(first: first, second: second)
    } else {
        return isOneAwayDiffLength(first: second, second: first)
    }
}

//isOneAway(first: "hello", second: "hello")
//isOneAway(first: "hello", second: "hell")
//isOneAway(first: "hello", second: "hel")
//isOneAway(first: "he", second: "hello")
//isOneAway(first: "heljo", second: "hello")
//isOneAway(first: "olleh", second: "hello")
