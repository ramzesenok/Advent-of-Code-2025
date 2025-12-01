enum Day01: Day {
    static let input = ""

    static func part1() -> Int {
        input
            .split(separator: "\n")
            .map { Int($0.replacing("L", with: "-").replacing("R", with: "+"))! }
            .reduce((lastPointer: 50, zeroReached: 0)) { partialResult, rotation in
                let (lastPointer, zeroReached) = partialResult

                var newPointer = lastPointer + rotation

                if newPointer < 0 {
                    newPointer = 100 * (abs(newPointer) / 100 + 1) + newPointer
                }

                newPointer %= 100

                return (newPointer, newPointer == 0 ? zeroReached + 1 : zeroReached)
            }
            .zeroReached
    }

    static func part2() -> Int {
        input
            .split(separator: "\n")
            .map { Int($0.replacing("L", with: "-").replacing("R", with: "+"))! }
            .reduce((lastPointer: 50, zeroClicks: 0)) { partialResult, rotation in
                let lastPointer = partialResult.lastPointer

                var newPointer = lastPointer + rotation

                var zeroClicks = partialResult.zeroClicks

                switch newPointer {
                case 1...99:
                    break
                case 0:
                    zeroClicks += 1
                case 100...:
                    zeroClicks += newPointer / 100
                case ..<0:
                    let absPointer = abs(newPointer)

                    if lastPointer == 0 {
                        if absPointer >= 100 {
                            zeroClicks += absPointer / 100
                        }
                    } else {
                        zeroClicks += absPointer / 100 + 1
                    }
                default:
                    break
                }

                if newPointer < 0 {
                    newPointer = 100 * (abs(newPointer) / 100 + 1) + newPointer
                }

                return (newPointer % 100, zeroClicks)
            }
            .zeroClicks
    }
}
