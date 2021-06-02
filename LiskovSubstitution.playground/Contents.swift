import UIKit
import XCTest

// Child classes should never break the parent class type definitions

/*
 It means, we must make sure that new derived classes should extend the base classes without changing the base class behavior
 As simple as, a subclass should override the parent class methods in a way that doesnt break the funtionality of base class from client point of view.
 Lets see this with an example, we have two classes Rectangle and Square since Square is also a form of Rectangle, so Square is subclass of Rectangle
 */

class Rectangle {
    var width: Double = 0
    var height: Double = 0
}

class Square: Rectangle {
    override var width: Double {
        didSet {
            height = width
        }
    }
    
    override var height: Double {
        didSet {
            width = height
        }
    }
}

/*
 Here in the above block Square inherits the width and height property from Rectangle and overrides the width and height property to return the same height and width since it is Square.
 Since our requirement is to calculate the area of Rectangle and Square, we will to use the AreaCalculator class.
 */

class AreaCalculator {
    func area(rectangle: Rectangle) -> Double {
        return rectangle.width * rectangle.height
    }
}

/*
 Lets go a head and write Unit test cases to calulate the area of Rectangle and Square
 */

func testAreaOfRectangle4X3() {
    let rectangle: Rectangle = Rectangle()
    rectangle.height = 3
    rectangle.width = 4
    
    let areaCalculator = AreaCalculator()
    let areaOfRectangle = areaCalculator.area(rectangle: rectangle)
    XCTAssertEqual(areaOfRectangle, 12, "Area of rectangle not matching")
}

func testAreaOfSquare5X5() {
    let square: Square = Square()
    square.height = 3
    
    let areaCalculator = AreaCalculator()
    let areaOfRectangle = areaCalculator.area(rectangle: square)
    XCTAssertEqual(areaOfRectangle, 9, "Area of square not matching")
}

/*
 In above both test cases should pass since we have used instance of Rectangle to find area of retangle and instance of Square to find area of sqauare, now lets go a head and create a test case in which we will try to substitute object of Rectangle with object of Square, since Square inherits from Rectangle we should be able to find area of rectangle with Square instance.
 */

func testAreaOfRectangle4X3New() {
    let rectangle: Rectangle = Square()
    rectangle.height = 3
    rectangle.width = 4
    
    let areaCalculator = AreaCalculator()
    let areaOfRectangle = areaCalculator.area(rectangle: rectangle)
    XCTAssertEqual(areaOfRectangle, 12, "Area of rectangle not matching")
}

/*
 In the above test case we have used instance of Square class to find the area of rectangle, since square inherits from Rectangle, but its very unfortunate that the above test case fails, the AreaCalculator returns the value of 16, were as the expected area was 12, this violates the Liskov’s Principle of Derived class (Square) breaking the parent class (Rectangle) funtionality of caluculating the area.
 */

// We can solve this problem breaking the inheritance

protocol Shape {
    func area() -> Double
}

class RectangleSolid: Shape {
    var width: Double = 0
    var height: Double = 0
    
    func area() -> Double {
        width * height
    }
}

class SquareSolid: Shape {
    var side: Double = 0
    
    func area() -> Double {
        side * side
    }
}

/*
 The solution seems similar to Open Close Principle, so based on above example we can conclude that violating Liskov’s Principle violates Open Close Principle as well.
 */
