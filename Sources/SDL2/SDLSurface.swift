import CSDL2

public class SDLSurface {
    
    public init(imagePath: String) {
        let cStr = imagePath.cString(using: .utf8)!
        
        self.surfacePointer = IMG_Load(cStr)
    }
    
    init(pointer: UnsafeMutablePointer<SDL_Surface>) {
        self.surfacePointer = pointer
    }
    
    var surfacePointer: UnsafeMutablePointer<SDL_Surface>
    
    public func fillWith(color: SDLColor, rectangle: SDLRectangle? = nil) {
        if let rectangle = rectangle {
            withUnsafePointer(to: rectangle.rawRect) { rectPtr in
                let res = SDL_FillRect(surfacePointer, rectPtr, color.map(to: surfacePointer.pointee.format))
                assert(res == 0)
                
            }
        } else {
            let res = SDL_FillRect(surfacePointer, nil, color.map(to: surfacePointer.pointee.format))
            assert(res == 0)
        }
    }
    
}
