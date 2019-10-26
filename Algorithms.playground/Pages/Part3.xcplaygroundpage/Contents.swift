import Foundation

//MARK: - Initial Flow

class ListNode {
    var value: Int?
    var next: ListNode?
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

//MARK: - 1) Повернуть односвязный список на К элементов

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

//MARK: - 2) Проверить имеет ли односвязный список цикл

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


//MARK: - 4) Ханойские башни

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
