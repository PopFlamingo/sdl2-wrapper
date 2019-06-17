import CSDL2

public class SDLFont {
    
    public init(path: String, pointSize: Int) {
        let font = path.withCString { cStr in
            return TTF_OpenFont(cStr, Int32(pointSize))
        }
        self.fontPtr = font!
    }
    
    deinit {
        TTF_CloseFont(fontPtr)
    }
    
    let fontPtr: OpaquePointer
    
    public var fontStyle: Style {
        get {
            return Style(rawValue: TTF_GetFontStyle(fontPtr))
        }
        set {
            TTF_SetFontStyle(fontPtr, newValue.rawValue)
        }
    }
    
    public func renderBlended(text: String, color: SDLColor) -> SDLSurface {
        let ptr = text.withCString { cString in
            TTF_RenderUTF8_Blended(fontPtr, cString, color.rawSDLColor)
        }
        return SDLSurface(pointer: ptr!)
    }
    
    public struct Style: OptionSet {
        
        public var rawValue: Int32
        
        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }
        
        
        static let normal = Style(rawValue: TTF_STYLE_NORMAL)
        static let bold = Style(rawValue: TTF_STYLE_BOLD)
        static let italic = Style(rawValue: TTF_STYLE_ITALIC)
        static let underline = Style(rawValue: TTF_STYLE_UNDERLINE)
        
    }
    
}
