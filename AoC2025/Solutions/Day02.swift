enum Day02: Day {
    static let input = ""

    static func part1() -> Int {
        let ranges = input
            .split(separator: ",")
            .map({ $0.split(separator: "-").map({ Int($0)! }) })

        var result = 0

        for range in ranges {
            for id in range[0]...range[1] {
                let str = String(id)

                if str.count.isMultiple(of: 2) {
                    let midIdx = str.index(str.startIndex, offsetBy: str.count / 2)

                    if str.prefix(upTo: midIdx) == str.suffix(from: midIdx) {
                        result += id
                    }
                }
            }
        }

        return result
    }

    static func part2() -> Int {
        let ranges = input
            .split(separator: ",")
            .map({ $0.split(separator: "-").map({ Int($0)! }) })

        var result = 0

        for range in ranges {
            for id in range[0]...range[1] {
                let str = String(id)

                for i in 0...str.count / 2 where str.count.isMultiple(of: i) {
                    let components = str.components(withMaxLength: i)

                    if Set(components).count == 1 {
                        result += id
                        break
                    }
                }
            }
        }

        return result
    }
}

private extension String {
    func components(withMaxLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}
