import CSDL2

public struct SDLColor {
    
    public init(red: Double, green: Double, blue: Double, alpha: Double = 1) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    public var red: Double
    public var green: Double
    public var blue: Double
    public var alpha: Double
    
    func map(to pixelFormat: UnsafePointer<SDL_PixelFormat>!) -> UInt32 {
        return SDL_MapRGBA(pixelFormat, UInt8(red*255), UInt8(green*255), UInt8(blue*255), UInt8(alpha*255))
    }
    var rawSDLColor: SDL_Color {
        return SDL_Color(r: UInt8(red*255), g: UInt8(green*255), b: UInt8(blue*255), a: UInt8(alpha*255))
    }
    
}
