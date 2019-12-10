## 学習資料
##### [Swift5.1のattribute全解説｜全27種](https://qiita.com/shtnkgm/items/2cba98b545c913d990bc)
##### [時代の変化に応じて進化するCollectionView ~Compositional LayoutsとDiffable Data Sources~](https://qiita.com/shiz/items/a6032543a237bf2e1d19)


## Result
##### Reference materials: https://qiita.com/guitar_char/items/84477337b11c11a4f5f6

```Swift
enum NetworkError: Error {
    case badURL
}

func fetchUnreadCount(from urlString: String, completionHandler: @escaping (Result<Int, NetworkError>) -> Void) {
    guard let url = URL(string: urlString) else {
        completionHandler(.failure(.badURL))
        return
    }
    print("fetching \(url.absoluteString)")
    completionHandler(.success(5))
}

print("==if case==")

fetchUnreadCount(from: "https://www.hackingwithswift.com") { result in
    switch result {
    case .success(let count):
        print("\(count) unread messages.")
    case .failure(let error):
        print(error.localizedDescription)
    }
}

print("==if .get()==")

fetchUnreadCount(from: "https://www.hackingwithswift.com") { result in
    if let count = try? result.get() {
        print("\(count) unread messages.")
    }
}
```

## Raw Strings
##### Reference materials: https://medium.com/@d_date/whats-new-in-swift-5-70225f063b87
```Swift
let rain = #"the "rain" in "Spain" falls mainly on the Spaniards."#

let answer = 43
let dontpanic = #"the answer to life, the universe, and everything is \#(answer)."#

let str = ##"My dog said "woof"#gooddog"##

let multiline = #"""
    the answer to life,
    the universe,
    and everything is \#(answer).
"""#

let regex1 = "\\\\[A-Z]+[A-Za-z]+\\.[a-z]+"
// ↓
let regex2 = #"\\[A-Z]+[A-Za-z]+\.[a-z]+"#
```





## @dynamicMemberLookup
##### Reference materials: https://dev.classmethod.jp/smartphone/playground-dynamic-member-lookup-dynamiccallable/
```Swift
enum KeySwitch {
    case linear
    case tactile
    case clicky
}
 
@dynamicMemberLookup
class MechanicalKeyboard {
    let keySwitch: KeySwitch
    let name: String
    let numberOfKeys: Int
 
    init(keySwitch: KeySwitch, name: String, number: Int) {
        self.keySwitch = keySwitch
        self.name = name
        self.numberOfKeys = number
    }
 
    subscript(dynamicMember key: String) -> Any {
        switch key {
        case "switch":
            return keySwitch
        case "type":
            return "This keyboarwd is \(name)"
        case "numbers":
            return numberOfKeys
        default:
            return ""
        }
    }
}
 
let keyboard = MechanicalKeyboard(keySwitch: .tactile, name: "kbd67", number: 67)
print(keyboard.switch)
print(keyboard.type)
print(keyboard.numbers)
```





## @dynamicCallable
##### Reference materials: https://qiita.com/tamappe/items/64fbe4d0991cd222540e
```Swift
@dynamicCallable
struct Sum {
    func dynamicallyCall(withArguments args: [Int]) -> Int {
        return args.reduce(0, +)
    }

    func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Int>) -> Int {
        return args.map { $0.value }.reduce(0, +)
    }
}

let sum = Sum()
print(sum(1, 2, 3))
print(sum(first: 1, second: 2, third: 3))
```





## @unknown
##### Reference materials: https://medium.com/swiftify/enum-in-swift-5-19b324b25f94
```Swift
enum PasswordError: Error {
    case short
    case obvious
    case simple
}

func showOld(error: PasswordError) {
    switch error {
    case .short:
        print("Your password was too short.")
    case .obvious:
        print("Your password was too obvious.")
    @unknown default:
        print("Your password was too old.")
    }
}

showOld(error: .obvious)
```





## isMultiple
##### Reference materials: https://developer.apple.com/documentation/swift/int/3127688-ismultiple
```Swift
let rowNumber = 4

if rowNumber.isMultiple(of: 2) {
    print("Even")
} else {
    print("Odd")
}
```





## compactMapValues
##### Reference materials: https://qiita.com/narum-29/items/a9fd7ff8a94c4d5a9b46
```Swift
let times = [
    "Hudson": "38",
    "Clarke": "42",
    "Robinson": "35",
    "Hartis": "DNF"
]

let finishers1 = times.compactMapValues { Int($0) }
print(finishers1)
let finishers2 = times.compactMapValues(Int.init)
print(finishers2)

let people = [
    "Paul": 38,
    "Sophie": 8,
    "Charlotte": 5,
    "William": nil
]

let knownAges = people.compactMapValues { $0 }
print(knownAges)
```





## Ordered Collection Diffing
##### Reference materials: https://qiita.com/shiz/items/0e363219a0151d790d03
```Swift
print("==If deleted==")
let oldArrayInDeleted = ["a", "b", "c", "d"]
let newArrayInDeleted = ["a", "b", "d"]

let differenceInDeleted = newArrayInDeleted.difference(from: oldArrayInDeleted)
print(differenceInDeleted)

print("")
print("==If inserted==")

let oldArrayInInserted = ["a", "b", "c", "d"]
let newArrayInInserted = ["a", "b", "c", "d", "e"]

let differenceInInserted = newArrayInInserted.difference(from: oldArrayInInserted)

print(differenceInInserted)

print("==Move value for delete / insert==")

let oldArrayWithInferringMoves = ["a", "b", "d", "e", "c"]
let newArrayWithInferringMoves = ["a", "b", "c", "d", "e"]
let differenceWithInferringMoves = newArrayWithInferringMoves.difference(from: oldArrayWithInferringMoves)

let differenceWithMovesWithInferringMoves = differenceWithInferringMoves.inferringMoves()
print(differenceWithMovesWithInferringMoves)

print("==Order of elements in CollectionDifference==")

let oldArrayOrderOfElements = ["a", "b", "c", "d"]
let newArrayOrderOfElements = ["x", "a", "e", "c"]

var anotherArrayOrderOfElements = oldArrayOrderOfElements

let differenceOrderOfElements = newArrayOrderOfElements.difference(from: oldArrayOrderOfElements)

for change in differenceOrderOfElements {
  switch change {
  case let .remove(offset, _, _):
    anotherArrayOrderOfElements.remove(at: offset)
    print(anotherArrayOrderOfElements)
  case let .insert(offset, newElement, _):
    anotherArrayOrderOfElements.insert(newElement, at: offset)
    print(anotherArrayOrderOfElements)
  }
  // ["a", "b", "c", "d"] 初期状態
  // ["a", "b", "c"] "d"をindex 3から削除
  // ["a", "c"] "b"をindex 1から削除
  // ["x", "a", "c"] "x"をindex 0へ挿入
  // ["x", "a", "e", "c"] "e"をindex 2へ挿入
}

print("==applying==")

let oldArrayApplying = ["a", "b", "c", "d"]
let newArrayApplying = ["x", "a", "e", "c"]

var anotherArrayApplying = oldArrayApplying

let differenceApplying = newArrayApplying.difference(from: oldArrayApplying)

anotherArrayApplying = anotherArrayApplying.applying(differenceApplying)!

print(anotherArrayApplying)
```
