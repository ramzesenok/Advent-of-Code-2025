enum Day06: Day {
    static let input = ""

    static func part1() -> Int {
        var sum = 0

        let lines = input.split(separator: "\n").map { $0.split(separator: " ") }

        var elements = [Int: [Int]]()

        for i in 0..<lines.count-1 {
            for j in 0..<lines[i].count {
                let el = Int(String(lines[i][j]))!

                elements[j, default: []].append(el)
            }
        }

        for (idx, numbers) in elements {
            let operation = lines.last![idx]

            if operation == "+" {
                sum += numbers.reduce(0, +)
            } else if operation == "*" {
                sum += numbers.reduce(1, *)
            }
        }

        return sum
    }

    static func part2() -> Int {
        var sum = 0
        let lines = input.split(separator: "\n")

        var columnsWidths = [Int: Int]()

        // Calculate column width
        do {
            var iterator = -1
            var counter = 0

            for i in 0..<lines.last!.count {
                if lines.last![i] != " " {
                    if iterator != -1 {
                        columnsWidths[iterator] = counter
                        counter = 0
                    }

                    iterator += 1
                } else {
                    counter += 1
                }
            }

            columnsWidths[iterator] = counter + 1
        }

        var elements = [Int: [String]]()

        // Assign elements from rows
        do {
            for line in lines.dropLast() {
                var i = 0
                var counter = 0

                while i < line.count {
                    let lineStr = String(line)
                    let currentWidth = columnsWidths[counter, default: 0]
                    let substring = lineStr[lineStr.index(lineStr.startIndex, offsetBy: i)...lineStr.index(lineStr.startIndex, offsetBy: i + currentWidth - 1)]

                    elements[counter, default: []].append(String(substring))

                    i += currentWidth + 1
                    counter += 1
                }

            }
        }

        for (idx, strs) in elements {
            let width = strs[0].count

            var transposedStrs = [String]()

            for i in 0..<width {
                var transposed = ""

                for j in 0..<strs.count {
                    let current = strs[j]
                    transposed += String(Array(current)[i])
                }

                transposedStrs.append(transposed)
            }

            let operation = lines.last!.split(separator: " ")[idx]
            let numbers = transposedStrs.map { Int($0.replacingOccurrences(of: " ", with: ""))! }

            if operation == "+" {
                sum += numbers.reduce(0, +)
            } else if operation == "*" {
                sum += numbers.reduce(1, *)
            }
        }

        return sum
    }
}
