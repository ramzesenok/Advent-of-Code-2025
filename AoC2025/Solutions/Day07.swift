enum Day07: Day {
    static let input = ""

    struct Position: Hashable {
        let row: Int
        let column: Int
    }

    static func part1() -> Int {
        var currentBeamPositions = Set<Position>()
        var matrix = [[String]]()

        let lines = input.split(separator: "\n")

        for line in lines {
            matrix.append(Array(line.map { String($0) }))
        }

        for i in 0..<matrix.count {
            if let idx = matrix[i].firstIndex(of: "S") {
                currentBeamPositions.insert(Position(row: i, column: idx))
                break
            }
        }

        var splittersMet = Set<Position>()

        while !currentBeamPositions.isEmpty {
            let beam = currentBeamPositions.removeFirst()

            if beam.row == matrix.count - 1 {
                continue
            }

            let nextPosition = Position(row: beam.row + 1, column: beam.column)
            let nextChar = matrix[nextPosition]

            switch nextChar {
            case ".":
                currentBeamPositions.insert(nextPosition)
            case "|":
                break
            case "^":
                if !splittersMet.contains(nextPosition) {
                    splittersMet.insert(nextPosition)

                    if beam.column > 0 {
                        currentBeamPositions.insert(Position(row: beam.row + 1, column: beam.column - 1))
                    }

                    if beam.column < matrix[0].count - 1 {
                        currentBeamPositions.insert(Position(row: beam.row + 1, column: beam.column + 1))
                    }
                }
            default:
                fatalError()
            }
        }

        return splittersMet.count
    }

    static func part2() -> Int {
        var matrix = [[String]]()

        let lines = input.split(separator: "\n")

        for line in lines {
            matrix.append(Array(line.map { String($0) }))
        }

        for i in 0..<matrix.count {
            if let idx = matrix[i].firstIndex(of: "S") {
                return doStep(matrix: matrix, position: Position(row: i, column: idx))
            }
        }

        fatalError()
    }

    static var cache = [Position: Int]()

    static func doStep(matrix: [[String]], position: Position) -> Int {
        if position.row == matrix.count - 1 {
            return 1
        }

        if let cached = cache[position] {
            return cached
        }

        switch matrix[position] {
        case ".", "S":
            cache[position] = doStep(matrix: matrix, position: Position(row: position.row + 1, column: position.column))
        case "^":
            var left = 0
            var right = 0

            if position.column > 0 {
                left = doStep(matrix: matrix, position: Position(row: position.row + 1, column: position.column - 1))
            }

            if position.column < matrix[0].count - 1 {
                right = doStep(matrix: matrix, position: Position(row: position.row + 1, column: position.column + 1))
            }

            cache[position] = left + right
        default:
            fatalError()
        }

        return cache[position]!
    }
}

private extension [[String]] {
    subscript(_ position: Day07.Position) -> String {
        get {
            self[position.row][position.column]
        }

        set {
            self[position.row][position.column] = newValue
        }
    }
}
