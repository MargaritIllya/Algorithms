import Foundation

//MARK: - Hash Table

public struct HashTable<Key: Hashable, Value> {
    
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    private(set) public var count = 0
    public var isEmpty: Bool { return count == 0 }
    
    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeatElement([], count: capacity))
    }
    
    public subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            if let value = newValue {
                updateValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }
    
    public func value(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil
    }
    
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        //Do we already have this key in the bucket?
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                let oldValue = element.value
                buckets[index][i].value = value
                return oldValue
            }
        }
        //This key isn't in the bucket yet;
        //add it to the chain.
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
    }
    
    public mutating func removeValue(forKey key: Key) -> Value? {
        let index = self.index(forKey: key)
        //Find the element in the bucket's chain and remove it.
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index].remove(at: i)
                count -= 1
                return element.value
            }
        }
        return nil  //key not in hash table
    }
    
    private func index(forKey key: Key) -> Int {
        return abs(key.hashValue % buckets.count)
    }
}

//var hashTable = HashTable<String, String>(capacity: 5)

//MARK: - Hash Set

public struct HashSet<T: Hashable> {
    
    fileprivate var dictionary = Dictionary<T, Bool>()
    public init() { }

    public mutating func insert(_ element: T) {
        dictionary[element] = true
    }

    public mutating func remove(_ element: T) {
        dictionary[element] = nil
    }

    public func contains(_ element: T) -> Bool {
        return dictionary[element] != nil
    }

    public func allElements() -> [T] {
        return Array(dictionary.keys)
    }

    public var count: Int {
        return dictionary.count
    }

    public var isEmpty: Bool {
        return dictionary.isEmpty
    }
}

extension HashSet {
    
    public func union(_ otherSet: HashSet<T>) -> HashSet<T> {
        var combined = HashSet<T>()
        for obj in self.dictionary.keys {
            combined.insert(obj)
        }
        for obj in otherSet.dictionary.keys {
            combined.insert(obj)
        }
        return combined
    }
    
    public func intersect(_ otherSet: HashSet<T>) -> HashSet<T> {
        var common = HashSet<T>()
        for obj in dictionary.keys {
            if otherSet.contains(obj) {
                common.insert(obj)
            }
        }
        return common
    }
    
    public func difference(_ otherSet: HashSet<T>) -> HashSet<T> {
        var diff = HashSet<T>()
        for obj in dictionary.keys {
            if !otherSet.contains(obj) {
                diff.insert(obj)
            }
        }
        return diff
    }
}

/*
 1)
Задан массив чисел. Вывести все неразрывные подмассивы, которые не содержат повторяющихся элементов. (2 балла)
Например дано {1,2,1,3},
Ответ
1
2
3
12
21
13
213
 
 2)
У компании есть склад А, на котором есть N камер хранения разного объема от 1 до 10. Компания хочет закупить М единиц товара разного объема (от 1 до 10) для новогодней распродажи. В одной камере хранения может быть помещена только одна единица товара. Надо посчитать, сколько складов типа А понадобится компании, чтобы разместить весь товар.(3 балла)
 
 3)
Дано две строки. Найти минимальное количество удалений символов из строк, чтобы они стали анаграммами. (3 балла)
Например дано “abcd” и “baad”. Надо удалить из первой строки символ ‘c’ и из второй символ ‘a’, то есть ответ - 2.
 
 4)
Даны две разреженные матрицы одинаковой размерности в виде hash-таблицы. Каждая таблица содержит в качестве ключа номер строки, а в качестве значения список пар (колонка, значение). В списке присутствуют только ненулевые значения. В таблице присутствуют только строки с хотя бы одним ненулевым значением. Написать функцию, которая складывает две такие матрицы и выдает результирующую матрицу в таком же виде.(2 балла)
Например матрица
1 0 0 0
0 0 0 0
0 0 2 8
0 0 6 0
Будет представлена в виде
0 -> (0,1)
2 -> (2,2),(3,8)
3 -> (2,6)

 */


let array = [1, 2, 1, 3]
//Задан массив чисел. Вывести все неразрывные подмассивы, которые не содержат повторяющихся элементов.

func searchSubArrayCount(array: [Int]) -> Int {
    var hashSet = HashSet<Int>()
    var result = [HashSet<Int>]()
    var max = 1
    for i in 0...array.count - 1 {
        if hashSet.contains(array[i]) {
            hashSet.remove(array[i])
        } else {
            hashSet.insert(array[i])
            max = hashSet.count
        }
        result.append(hashSet)
    }
    print(result)
    return max
}


searchSubArrayCount(array: array)

//1
//2
//3
//12
//21
//13
//213
