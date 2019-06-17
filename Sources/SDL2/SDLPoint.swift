import CSDL2

public struct SDLPoint {
    
    public init(x: Int, y: Int) {
        self.rawPoint = SDL_Point(x: Int32(x), y: Int32(y))
    }
    
    var x: Int {
        get {
            return Int(rawPoint.x)
        }
        set {
            rawPoint.x = Int32(newValue)
        }
    }
    
    var y: Int {
        get {
            return Int(rawPoint.y)
        }
        set {
            rawPoint.y = Int32(newValue)
        }
    }
    
    var rawPoint: SDL_Point
}
