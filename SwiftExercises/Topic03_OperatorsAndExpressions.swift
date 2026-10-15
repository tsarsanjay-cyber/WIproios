import Foundation

let itemPrice = 450.0
let quantity = 3
let subtotal = itemPrice * Double(quantity)
let hasCoupon = true
let discount = (hasCoupon && subtotal > 1000) ? subtotal * 0.10 : 0.0
let discountedAmount = subtotal - discount
let gst = discountedAmount * 0.18
let total = discountedAmount + gst
let people = 4
let eachShare = total / Double(people)

print("Subtotal: \(subtotal)")
print("Discount: \(discount)")
print("GST: \(gst)")
print("Total: \(total)")
print("Each person pays: \(String(format: "%.2f", eachShare))")

let amount = 1234
let hundreds = amount / 100
let remainder = amount % 100
print("\(amount) rupees = \(hundreds) hundreds and \(remainder) rupees")

let isLeapYear = { (year: Int) -> Bool in
    (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
}

for year in [1900, 2000, 2024, 2026] {
    print("\(year) leap year: \(isLeapYear(year))")
}

let number = 64
print("Between 1 and 100: \((1...100).contains(number))")
print("Even and not a multiple of 10: \(number % 2 == 0 && number % 10 != 0)")

let nickname: String? = nil
print(nickname ?? "Guest")

print(7 / 2)
print(7 % 2)
print(-7 % 3)
print(7.0 / 2)
print(10 - 2 * 3 + 4 / 2)
print(5 > 3 && 2 > 4 || true)
print(1 << 3)
print(6 & 3, 6 | 3, 6 ^ 3)
let x: UInt8 = 255
print(x &+ 1)
