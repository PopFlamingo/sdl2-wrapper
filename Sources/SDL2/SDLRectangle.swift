import CSDL2

public struct SDLRectangle {
    
    public init(x: Int, y: Int, width: Int, height: Int) {
        self.rawRect = SDL_Rect(x: Int32(x), y: Int32(y), w: Int32(width), h: Int32(height))
    }
    
    init(rawRect: SDL_Rect) {
        self.rawRect = rawRect
    }
    
    public var x: Int {
        get {
            return Int(rawRect.x)
        }
        set {
            rawRect.x = Int32(newValue)
        }
    }
    
    public var y: Int {
        get {
           return Int(rawRect.y)
        }
        set {
            rawRect.y = Int32(newValue)
        }
    }
    
    public var width: Int {
        get {
           return Int(rawRect.w)
        }
        set {
            rawRect.w = Int32(newValue)
        }
    }
    
    public var height: Int {
        get {
            return Int(rawRect.h)
        }
        set {
            rawRect.h = Int32(newValue)
        }
    }
    
    var rawRect: SDL_Rect
}
