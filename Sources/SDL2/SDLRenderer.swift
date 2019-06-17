import CSDL2

public class SDLRenderer {
    
    public init(window: SDLWindow, options: Options) {
        
        
        #if os(macOS)
        SDL_SetHint(SDL_HINT_RENDER_DRIVER, "metal")
        #endif
 
        self.rendererPointer = SDL_CreateRenderer(window.windowPointer, -1, options.rawValue)
    }
    
    deinit {
        SDL_DestroyRenderer(rendererPointer)
    }
    
    var rendererPointer: OpaquePointer
    
    public func present() {
        SDL_RenderPresent(rendererPointer)
    }
    
    public func set(drawColor: SDLColor) {
        SDL_SetRenderDrawColor(rendererPointer,
                               UInt8(drawColor.red * 255),
                               UInt8(drawColor.green * 255),
                               UInt8(drawColor.blue * 255),
                               UInt8(drawColor.alpha * 255))
    }
    
    public func clear() {
        SDL_RenderClear(rendererPointer)
    }
    
    public func render(texture: SDLTexture, source: SDLRectangle? = nil, destination: SDLRectangle? = nil) {
        withUnsafePointerCascadingNil(of: source?.rawRect) { srcPtr in
            withUnsafePointerCascadingNil(of: destination?.rawRect) { destPtr in
                if SDL_RenderCopy(rendererPointer, texture.texturePointer, srcPtr, destPtr) != 0 {
                    fatalError("Couldn't render copy")
                }
            }
        }
    }
    
    public func render(texture: SDLTexture, source: SDLRectangle?, destination: SDLRectangle?, angle: Double, center: SDLPoint, flipOptions: FlipOptions) {
        
        withUnsafePointerCascadingNil(of: source?.rawRect) { srcPtr in
        withUnsafePointerCascadingNil(of: destination?.rawRect) { destPtr in
        withUnsafePointer(to: center.rawPoint) { centerPtr in
            if SDL_RenderCopyEx(rendererPointer, texture.texturePointer, srcPtr, destPtr, angle, centerPtr, SDL_RendererFlip(rawValue: flipOptions.rawValue)) != 0 {
                fatalError("Couldn't render texture")
            }
        }
        }
        }
        
    }
    
    public func setLogicalSize(width: Int, height: Int) {
        SDL_RenderSetLogicalSize(rendererPointer, Int32(width), Int32(height))
    }
    
    
    public struct Options: OptionSet {
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
        
        public var rawValue: UInt32
        
        public static let software = Options(rawValue: SDL_RENDERER_SOFTWARE.rawValue)
        public static let accelerated = Options(rawValue: SDL_RENDERER_ACCELERATED.rawValue)
        public static let presentVSync = Options(rawValue: SDL_RENDERER_PRESENTVSYNC.rawValue)
        public static let targetTexture = Options(rawValue: SDL_RENDERER_TARGETTEXTURE.rawValue)
    }
    
    
    public struct FlipOptions: OptionSet {
        
        public static let none = FlipOptions(rawValue: SDL_FLIP_NONE.rawValue)
        public static let horizontal = FlipOptions(rawValue: SDL_FLIP_HORIZONTAL.rawValue)
        public static let vertical = FlipOptions(rawValue: SDL_FLIP_VERTICAL.rawValue)
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
        
        public var rawValue: UInt32
        
    }
    
}
