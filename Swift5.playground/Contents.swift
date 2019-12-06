import Foundation

/// Result

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









//// Raw Strings

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
