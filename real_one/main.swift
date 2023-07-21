import Foundation

protocol Operation {
    func perform(_ num1: Double, _ num2: Double) -> Double
}

class Add: Operation {
    func perform(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
    }
}

class Subtract: Operation {
    func perform(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
}

class Multiply: Operation {
    func perform(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
}

class Divide: Operation {
    func perform(_ num1: Double, _ num2: Double) -> Double {
        return num1 / num2
    }
}


class Calculator {
    let operators: [Character: Operation] = ["+": Add(),
                                             "-": Subtract(),
                                             "*": Multiply(),
                                             "/": Divide()]

    func calculate(_ input: String) -> Double? {
        var numbers = [Double]()
        var operations = [Operation]()

        let components = input.components(separatedBy: " ")
        for component in components {
            if let number = Double(component) {
                numbers.append(number)
            } else if let operation = component.first, let operatorObject = operators[operation] {
                operations.append(operatorObject)
            } else {
                print("입력값을 확인해주세요.: \(component)")
                return nil
            }
        }

        if numbers.count - 1 != operations.count {
            print("입력값을 확인해주세요: 피연산자와 연산자의 개수가 맞지 않습니다")
            return nil
        }

        let result = calculateExpression(numbers, operations)
        return result
    }

    private func calculateExpression(_ numbers: [Double], _ operations: [Operation]) -> Double {
        var result = numbers[0]
        for i in 0..<operations.count {
            let number = numbers[i+1]
            let operation = operations[i]

            result = operation.perform(result, number)
        }
        return result
    }
}

let calculator = Calculator()

if let input = readLine() {
    if let result = calculator.calculate(input) {
        print("\(result) 입니다.")
    }
}
