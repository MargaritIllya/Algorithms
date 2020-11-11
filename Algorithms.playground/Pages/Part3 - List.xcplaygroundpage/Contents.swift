import Foundation

//MARK: - Initial Flow

class ListNode {
    var value: Int?
    var next: ListNode?
    
    init(value: Int? = nil, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

func createList(capacity: Int) -> ListNode? {
    if capacity <= 0 {
        return nil
    }
    let firseNode = ListNode()
    firseNode.value = 1
    var currentNode = firseNode
    for i in 1..<capacity {
        let newNode = ListNode()
        newNode.value = i + 1
        currentNode.next = newNode
        currentNode = newNode
    }
    return firseNode
}

//MARK: - Additional

func printList(prtNode: ListNode?) {
    var node = prtNode
    while node != nil {
        print(node!.value!)
        node = node!.next
    }
}

func reverseList(list: ListNode?) -> ListNode? {
    if list == nil || list?.next == nil { return list }
    var curr = list!.next
    var prev = list!
    prev.next = nil
    while curr != nil {
        let next = curr?.next
        curr?.next = prev
        prev = curr!
        curr = next
    }
    return prev
}

func middleList(list: ListNode?) -> Int? {
    if list == nil { return nil }
    if list?.next == nil { return list?.value }
    var fast = list
    var slow = list
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    return slow?.value
}

func listInLoop(list: ListNode?) -> ListNode? {
    var currentList = list
    let firstNode = list
    while currentList != nil {
        
        if currentList!.next == nil {
            currentList!.next = firstNode
            break
        } else {
            currentList = currentList!.next
        }
    }
    currentList = firstNode
    return currentList
}

//MARK: - 1) Повернуть односвязный список

func rotateList(list: ListNode) -> ListNode? {
    var currentList: ListNode? = list
    var prev: ListNode?
    var next: ListNode?
    while currentList != nil {
        next = currentList?.next
        currentList?.next = prev
        prev = currentList
        currentList = next
    }
    return prev
}

//let thirdNode = ListNode(value: 5, next: nil)
//let secondNode = ListNode(value: 3, next: thirdNode)
//let firstNode = ListNode(value: 1, next: secondNode)
//printList(prtNode: rotateList(list: firstNode))

//MARK: - 2) Повернуть односвязный список на К элементов

func rotateList(list: ListNode, on element: Int) -> ListNode? {
    var count = 0
    var node: ListNode? = list
    let firstNode = node
    if element == 0 { return firstNode }
    while node != nil {
        count += 1
        if node!.next == nil {
            node!.next = firstNode
            break
        } else {
            node = node!.next
        }
    }
    node = firstNode
    let k = element % count
    var newFirstNode = node
    var prevNode: ListNode?
    let index = count - k
    for _ in 1...index {
        prevNode = newFirstNode
        newFirstNode = newFirstNode?.next
    }
    prevNode?.next = nil
    return newFirstNode
}

//let list = createList(capacity: 5)
//print("before")
//printList(prtNode: list)
//let rotate = rotateList(list: list!, on: 3)
//print("after")
//printList(prtNode: rotate)

//MARK: - 3) Объединить два отсортированных Linked List

func mergeSortedLists(first: ListNode?, second: ListNode?) -> ListNode? {
    guard first != nil else { return second }
    guard second != nil else { return first }
    
    let dummyHead: ListNode = ListNode(value: 0, next: nil)
    var l1 = first, l2 = second
    var endOfSortedList: ListNode? = dummyHead
    
    while l1 != nil && l2 != nil {
        if l1!.value! <= l2!.value! {
            endOfSortedList?.next = l1
            l1 = l1?.next
        } else {
            endOfSortedList?.next = l2
            l2 = l2?.next
        }
        endOfSortedList = endOfSortedList?.next
    }
    endOfSortedList?.next = l1 == nil ? l2 : l1
    return dummyHead
}

//let thirdNode = ListNode(value: 15, next: nil)
//let secondNode = ListNode(value: 10, next: thirdNode)
//let first = ListNode(value: 7, next: secondNode)
//let second = createList(capacity: 5)
//let result = mergeSortedLists(first: first, second: second)
//printList(prtNode: result)
//n = O(m + n)

//MARK: - 4) Проверить имеет ли односвязный список цикл

func detectLoop(in list: ListNode?) -> Bool {
    var slowPtr = list
    var fastPtr = list
    while slowPtr != nil && fastPtr != nil && fastPtr?.next != nil {
        slowPtr = slowPtr?.next
        fastPtr = fastPtr?.next?.next
        if slowPtr === fastPtr { return true }
    }
    return false
}

//let listWithoutLoop = createList(capacity: 5)
//let listWithLoop = listInLoop(list: createList(capacity: 5))
//let test1 = detectLoop(in: listWithoutLoop)
//let test2 = detectLoop(in: listWithLoop)


//MARK: - 5) Ханойские башни

func hanoi(count: Int,      //count - Number of discs to move
           from: String,    //from - original pin
           to: String,      //to - destination pin
           other: String,   //other - third pin
           move: (String, String) -> ()) {
    if count > 0 {
        hanoi(count: count - 1, from: from, to: other, other: to, move: move)
        move(from, to)
        hanoi(count: count - 1, from: other, to: to, other: from, move: move)
    }
}

func hanoiTest() {
    /*
          |-|-|             |           |
        |---|---|           |           |
       |----|----|          |           |
      |-----|-----|         |           |
     |------|------|        |           |
     */
    var moveCount = 0
    hanoi(count: 5, from: "Left", to: "Right", other: "Middle") {
        moveCount += 1
        print("\(moveCount): Move from \($0) to \($1).")
    }
}

//hanoiTest()
