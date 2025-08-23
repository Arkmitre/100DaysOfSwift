import UIKit

//let name = "Taylor"
//
//for letter in name {
//    print("Give me a \(letter)")
//}
//
//let letter = name[name.index(name.startIndex, offsetBy: 3)]
//
//
//extension String {
//    subscript(i: Int) -> String {
//        return String(self[index(startIndex, offsetBy: i)])
//    }
//}
//
//let letter2 = name[3]
//
//let password = "12345"
//password.hasPrefix("123")
//password.hasSuffix("345")
//
//extension String {
//    func deletingPrefix(_ prefix: String) -> String {
//        guard hasPrefix(prefix) else {
//            return self
//        }
//        return String(dropFirst(prefix.count))
//    }
//    
//    func deletingSuffix(_ suffix: String) -> String {
//        guard hasSuffix(suffix) else {
//            return self
//        }
//        return String(dropLast(suffix.count))
//    }
//}

//let weather = "it's going to rain"
//print(weather.capitalized)
//
//extension String {
//    var capitalizedFirst: String {
//        guard let firsLetter = self.first else {
//            return ""
//        }
//        return firsLetter.uppercased() + self.dropFirst()
//    }
//}
//weather.capitalizedFirst


//let input = "Swift is like Obective-C without C"
//input.contains("Swift")
//
//let languages = ["Python", "Ruby", "Swift", "JavaScript"]
//languages.contains("Swift")
//
//extension String {
//    func containsAny(of array: [String]) -> Bool {
//        for item in array {
//            if self.contains(item) {
//                return true
//            }
//        }
//        return false
//    }
//}
//input.containsAny(of: languages)
//
//languages.contains(where: input.contains)

//let string = "This is a test string"
//let attributes: [NSAttributedString.Key: Any] = [
//    .foregroundColor: UIColor.white,
//    .backgroundColor: UIColor.red,
//    .font: UIFont.boldSystemFont(ofSize: 36)
//]
//
//let attributedString = NSAttributedString(string: string, attributes: attributes)

//let attributedString = NSMutableAttributedString(string: string)
//
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
//attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

// MARK: Challenge 1.

//extension String {
//    func withPrefix(prefix: String) -> String {
//        if self.hasPrefix(prefix) {
//            return self
//        } else {
//            return prefix + self
//        }
//    }
//}
//let goodTestString = "carpet"
//let badTestString = "pet"
//goodTestString.withPrefix(prefix: "car")
//badTestString.withPrefix(prefix: "car")

// MARK: Challenge 2.

//extension String {
//    var isNumeric: Bool {
//        if !("0"..."9").contains(self) {
//            return false
//        }
//        return true
//    }
//}
//let numericString = "123542"
//let unNumericString = "asdf"
//let gibridString = "123asdf"
//numericString.isNumeric
//unNumericString.isNumeric
//gibridString.isNumeric

// MARK: Challenge 3.

extension String {
    var lines: [String] {
        return self.split(separator: "\n").map(String.init)
    }
}

let multiLineString = "this\nis\na\ntest\nstring"
multiLineString.lines




