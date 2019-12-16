import Foundation

//MARK: - Recursion

//MARK: 1) Factorial Cycle

func factorialWithCycle(c: Int) -> Int {
    var res = 1
    for i in 2...c { res = res * i }
    return res
}

//MARK: 2) Factorial Recursion

func factorialRecursion(c: Int) -> Int {
    if c == 2 { return c }
    return factorialRecursion(c: c - 1) * c
}

//MARK: 3) Factorial (Хвостовая Рекурсия)

func factRecursion(c: Int, p: Int) -> Int {
    if c == 2 { return c * p }
    return factRecursion(c: c - 1, p: c * p)
}

//MARK: 4) Min Array (Recursion)

func min(arr: [Int], index: Int) -> Int {
    if index == arr.count - 1 { return arr[index] }
    let n = min(arr: arr, index: index + 1)
    return n <= arr[index] ? n : arr[index]
}

func min(arr: [Int]) -> Int {
    return min(arr: arr, index: 0)
}

//let array = [2,4,-6,1,5,32,3]
//array.min()
//min(arr: array)

//MARK: 5) Aлгоритм Евклида

//example 1
func gcd1(x: Int, y: Int) -> Int {
    func test(a: Int, b: Int) -> Int {
        let result = a % b
        if result == 0 {
            return b
        } else {
            return test(a: b, b: result)
        }
    }
    let a = max(x, y)
    let b = min(x, y)
    return test(a: a, b: b)
}
//gcd1(x: 10, y: 16)

//example 2
func gcd2(a: Int, b: Int) -> Int {
    if a == 0 { return b }
    if b == 0 { return a }
    return a <= b ? gcd2(a: a, b: b % a) : gcd2(a: b, b: a % b)
}
//gcd2(a: 10, b: 16)

//MARK: - 6) Вычислить 10е число ряда Фибоначчи обычной и хвостовой рекурсией

//Обычная рекурсия
func fibonacchi(n: Int) -> Int {
    if n == 0 { return 0 }
    if n == 1 || n == 2 { return 1 }
    return fibonacchi(n: n - 2) + fibonacchi(n: n - 1)
}
//fibonacchi(n: 10)

//Хвостовая рекурсия
func fib(n: Int) -> Int {
    func fib(n: Int, a: Int, b: Int) -> Int {
        return n > 0 ? fib(n: n - 1, a: b , b: a + b) : a;
    }
    return fib(n: n, a: 0 , b: 1)
}
//fib(n: 10)

//MARK: - 7) Вычислить сумму 10 чисел ряда Фибоначчи с помощью рекурсии.

func sumFib(n: Int) -> Int {
    var s = 0
    func fib(sum: Int, n: Int, a: Int, b: Int) -> Int {
        s += a
        return n > 0 ? fib(sum: s, n: n - 1, a: b , b: a + b) : s;
    }
    return fib(sum: s, n: n, a: 0 , b: 1)
}
//sumFib(n: 10)

//MARK: - 8) Узнать можно ли пройти по двумерному массиву от нулевой ячейки до последней. 1 - можно идти, 0 - нельзя. Можно двигаться только вправо и вниз.

let m = [/*start --> */[1, 0, 0, 0, 1],
                       [1, 1, 0, 0, 0],
                       [0, 1, 0, 0, 0],
                       [0, 1, 1, 1, 1],
                       [1, 1, 0, 0, 1]/* <-- finish*/]
func printm(m: [[Int]]) {
    var dsc = ""
    for row in 0..<m.count {
        for col in 0..<m[0].count { let s = String(m[row][col]); dsc += s + " " }
        dsc += "\n"
    }
    print(dsc)
}

func findPath(grid: [[Int]], row: Int, col: Int) -> Bool {
    var grid: [[Int]] = grid
    if row < 0 || row >= grid.count ||
       col < 0 || col >= grid[row].count { return false }
    if row == grid.count - 1 &&
       col == grid[row].count - 1 { return true }
    if grid[row][col] != 0 {
        grid[row][col] = -1
    } else {
        return false
    }
    printm(m: grid)
    return findPath(grid: grid, row: row, col: col + 1) ||
           findPath(grid: grid, row: row + 1, col: col)
}
//let startIndex = 0
//findPath(grid: m, row: startIndex, col: startIndex)


//MARK: - 9) Дан двумерный массив. 1 обозначает землю, 0 - воду. Найти количество островов. Земля соединяется только рядом стоящими ячейками. По диагонали земля не соединяется.

let matrix = [[1, 0, 0, 0, 1],
              [1, 1, 0, 1, 0],
              [0, 0, 0, 0, 0],
              [0, 1, 0, 0, 0],
              [1, 1, 0, 0, 1]]

func locateIsland(matrix: [[Int]], i: Int, j: Int) -> Bool {

    var matrix = matrix
    if i < 0 || i >= matrix.count ||
       j < 0 || j >= matrix[i].count { return false }
    let island = matrix[i][j] == 1
    matrix[i][j] = 0
    if island {
        locateIsland(matrix: matrix, i: i, j: j + 1)
        locateIsland(matrix: matrix, i: i, j: j - 1)
        locateIsland(matrix: matrix, i: i + 1, j: j)
        locateIsland(matrix: matrix, i: i - 1, j: j)
    }
    return island
}

func findIslandsCount(m: [[Int]]) -> Int {
    var islands = 0
    for i in 0..<m.count {
        for j in 0..<m[i].count {
            if locateIsland(matrix: m, i: i, j: j) {
                
                islands += 1
            }
        }
    }
    return islands
}
//findIslandsCount(m: matrix)





