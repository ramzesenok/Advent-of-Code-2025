import Foundation

enum Day03: Day {
    static let input = ""

    static func part1() -> Int {
        var sum = 0

        for line in input.split(separator: "\n") {
            let lineArr = Array(line).map { Int(String($0))! }

            iterate(line: lineArr, prefixOffset: 0, suffixOffset: 1) { num1, i1, break1 in
                iterate(line: lineArr, prefixOffset: i1 + 1, suffixOffset: 0) { num2, i2, break2 in
                    sum += formFinalNumber(for: num1, num2)

                    break1()
                    break2()
                }
            }
        }

        return sum
    }

    static func part2() -> Int {
        var sum = 0

        for line in input.split(separator: "\n") {
            let lineArr = Array(line).map { Int(String($0))! }

            iterate(line: lineArr, prefixOffset: 0, suffixOffset: 11) { num1, i1, break1 in
                iterate(line: lineArr, prefixOffset: i1 + 1, suffixOffset: 10) { num2, i2, break2 in
                    iterate(line: lineArr, prefixOffset: i2 + 1, suffixOffset: 9) { num3, i3, break3 in
                        iterate(line: lineArr, prefixOffset: i3 + 1, suffixOffset: 8) { num4, i4, break4 in
                            iterate(line: lineArr, prefixOffset: i4 + 1, suffixOffset: 7) { num5, i5, break5 in
                                iterate(line: lineArr, prefixOffset: i5 + 1, suffixOffset: 6) { num6, i6, break6 in
                                    iterate(line: lineArr, prefixOffset: i6 + 1, suffixOffset: 5) { num7, i7, break7 in
                                        iterate(line: lineArr, prefixOffset: i7 + 1, suffixOffset: 4) { num8, i8, break8 in
                                            iterate(line: lineArr, prefixOffset: i8 + 1, suffixOffset: 3) { num9, i9, break9 in
                                                iterate(line: lineArr, prefixOffset: i9 + 1, suffixOffset: 2) { num10, i10, break10 in
                                                    iterate(line: lineArr, prefixOffset: i10 + 1, suffixOffset: 1) { num11, i11, break11 in
                                                        iterate(line: lineArr, prefixOffset: i11 + 1, suffixOffset: 0) { num12, i12, break12 in
                                                            sum += formFinalNumber(for: num1, num2, num3, num4, num5, num6, num7, num8, num9, num10, num11, num12)

                                                            break1()
                                                            break2()
                                                            break3()
                                                            break4()
                                                            break5()
                                                            break6()
                                                            break7()
                                                            break8()
                                                            break9()
                                                            break10()
                                                            break11()
                                                            break12()
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        return sum
    }

    static func iterate(
        line: [Int],
        prefixOffset: Int,
        suffixOffset: Int,
        onHit: (_ num: Int, _ i: Int, _ stop: () -> Void) -> Void
    ) {
        let stride = stride(from: 9, to: 0, by: -1)
        var shouldStop = false

        for num in stride where !shouldStop {
            for i in prefixOffset..<line.count-suffixOffset where !shouldStop {
                if num == line[i] {
                    onHit(num, i) {
                        shouldStop = true
                    }
                }
            }
        }
    }

    static func formFinalNumber(for numbers: Int...) -> Int {
        (0..<numbers.count)
            .reduce(0) { sum, i in
                sum + numbers[i] * Int(pow(10.0, Double(numbers.count - 1 - i)))
            }
    }
}
