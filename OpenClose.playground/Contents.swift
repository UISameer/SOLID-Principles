import UIKit

// Classes and Modules should be open for extension but closed for modification
/*
 Strive to write code that doesn't have to change every time the requirements change.
 To understand this principle easily lets take a basic example of calculating the area of geometry shape.
 Lets say we have requirement to calculate area of rectangle, so the rectangle and related area calculator class looks like shown below
 */

// Before
class Rectangle {
    let width: CGFloat = 0.0
    let height: CGFloat = 0.0
}

class AreaCalculator {
    func area(rectangle: Rectangle) -> CGFloat {
        return rectangle.height * rectangle.width
    }
}

// Now the requirement has come to calculate area of not only Rectangle even for Circle, so our AreaCalculator class will look something like

class Circle {
    let radius: CGFloat = 0.0
}

class AreaCalculatorModified {
    func area(shape: AnyObject) -> CGFloat {
        var area: CGFloat = 0.0
        if let rect =  shape as? Rectangle {
            area = rect.height * rect.width
        } else if let circle = shape as? Circle {
            area = .pi * circle.radius * circle.radius
        }
        return area
    }
}

/*
 This will work but what if tomorrow one more requirement comes to calculate the area of Triangle, area function inside AreaCalculator class keeps growing with if else conditions, according to Open Close Principle we should not modify the existing class rather extent it.
 One way of solving this problem is create a protocol (which is similar to Interface in Java) called Shape and declare area protocol method, implement the Shape protocols inside Rectangle or Circle or any other geometric shape class, if it is confusing still may be checking the code below may clear it.
 */

// After
protocol ShapeArea {
    func area() -> CGFloat
}

class RectangleSolid: ShapeArea {
    let width: CGFloat = 0.0
    let height: CGFloat = 0.0

    func area() -> CGFloat {
        return self.height * self.width
    }
}

class CircleSolid: ShapeArea {
    let radius: CGFloat = 0.0

    func area() -> CGFloat {
        return .pi * self.radius * self.radius
    }
}

class AreaCalculatorSolid {
    func area(shape: ShapeArea) -> CGFloat {
        return shape.area()
    }
}
