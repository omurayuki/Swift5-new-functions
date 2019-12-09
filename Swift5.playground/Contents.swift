import Foundation

/// Result
/// Reference materials: https://qiita.com/guitar_char/items/84477337b11c11a4f5f6

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

fetchUnreadCount(from: "https://www.hackingwithswift.com") { result in
    switch result {
    case .success(let count):
        print("\(count) unread messages.")
    case .failure(let error):
        print(error.localizedDescription)
    }
}

fetchUnreadCount(from: "https://www.hackingwithswift.com") { result in
    if let count = try? result.get() {
        print("\(count) unread messages.")
    }
}





/// Raw Strings
/// Reference materials: https://medium.com/@d_date/whats-new-in-swift-5-70225f063b87

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






/// @dynamicMemberLookup
/// Reference materials: https://dev.classmethod.jp/smartphone/playground-dynamic-member-lookup-dynamiccallable/

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






/// @dynamicCallable
/// Reference materials: https://qiita.com/tamappe/items/64fbe4d0991cd222540e

@dynamicCallable
struct RandomNumberGenerator {
    func dynamicallyCall(withArguments args: [Int]) -> Double {
        let numberOfZeroes = Double(args[0])
        let maximum = pow(10, numberOfZeroes)
        return Double.random(in: 0...maximum)
    }
}

let random = RandomNumberGenerator()
let result = random(0)
