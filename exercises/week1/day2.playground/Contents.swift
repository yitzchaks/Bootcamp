import UIKit

//Slice Sizing 1
func sliceSize(diameter: Double?, slices: Int?) -> Double?{
    switch (diameter, slices) {
    case let (d?, s?):
        return pow(d / 2, 2) * Double.pi / Double(s)
    default:
        return nil
    }
}

sliceSize(diameter: 16, slices: 12)
sliceSize(diameter: nil, slices: 8)

//Slice Sizing 2
func biggestMessage(_ biggest: String) -> String{
    return "Slice \(biggest) is bigger"
}

func biggestSlice(diameterA: String, slicesA: String, diameterB: String, slicesB: String) -> String{
    let sizeA: Double? = sliceSize(diameter: Double(diameterA), slices: Int(slicesA))
    let sizeB: Double? = sliceSize(diameter: Double(diameterB), slices: Int(slicesB))
    switch (sizeA, sizeB) {
    case let (a?, b?):
        if a > b {
            return biggestMessage("A")
        }
        return biggestMessage("B")
    case (_?, _):
        return biggestMessage("A")
    case (_, _?):
        return biggestMessage("B")
    default:
        return "Neither slice is bigger"
    }
}

biggestSlice(diameterA: "10", slicesA: "6", diameterB: "14", slicesB: "12")
biggestSlice(diameterA: "10", slicesA: "6", diameterB: "12", slicesB: "8")
biggestSlice(diameterA: "Pepperoni", slicesA: "6", diameterB: "hhh", slicesB: "12")

//K times (exercise 3)
func applyKTimes(_ K: Int, _ closure: () -> ()){
    for _ in 0..<K {
        closure()
    }
}

applyKTimes(3) {
    print("We Heart Swift")
}


//Game (exercise 4)
enum Direction {
    case up, down, right, left
}

func finalLocation(startLocation: (x: Int, y: Int), steps: [Direction]) -> (Int, Int) {
    var location = startLocation
   
    for step in steps {
        switch step {
        case .up:
            location.y += 1
        case .down:
            location.y -= 1
        case .right:
            location.x += 1
        case .left:
            location.x -= 1
        }
    }
    
    return location
}

var location = (x: 0, y: 0)
var steps: [Direction] = [.up, .up, .left, .down, .left]

finalLocation(startLocation: location, steps: steps)
