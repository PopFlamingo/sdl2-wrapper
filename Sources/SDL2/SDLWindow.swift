import CSDL2
import Foundation

public class SDLWindow {
    
    public init(x: Int, y: Int, width: Int, height: Int, options: Option) throws {
        guard let windowPointer = SDL_CreateWindow("", Int32(x), Int32(y), Int32(width), Int32(height), options.rawValue) else {
            fatalError("SDL error")
        }
        self.windowPointer = windowPointer
    }
    
    deinit {
        SDL_DestroyWindow(windowPointer)
    }
    
    let windowPointer: OpaquePointer
    
    public var id: Int {
        return Int(SDL_GetWindowID(windowPointer))
    }
    
    public var title: String {
         
        get {
            return String(cString: SDL_GetWindowTitle(windowPointer))
        }
        
        set {
            newValue.withCString { cString in
                SDL_SetWindowTitle(windowPointer, cString)
            }
        }
    }
    
    public var surface: SDLSurface {
        return SDLSurface(pointer: SDL_GetWindowSurface(windowPointer))
    }

    
    public func updateSurface() {
        SDL_UpdateWindowSurface(windowPointer)
    }
    
    public var width: Int {
        get {
            var width: Int32 = 0
            SDL_GetWindowSize(windowPointer, &width, nil)
            return Int(width)
        } set {
            SDL_SetWindowSize(windowPointer, Int32(newValue), Int32(height))
        }
    }
    
    public var height: Int {
        get {
            var height: Int32 = 0
            SDL_GetWindowSize(windowPointer, nil, &height)
            return Int(height)
        } set {
            SDL_SetWindowSize(windowPointer, Int32(width), Int32(newValue))
        }
    }
    
    
    public var x: Int {
        get {
            var x: Int32 = 0
            SDL_GetWindowPosition(windowPointer, &x, nil)
            return Int(x)
        }
        set {
            SDL_SetWindowPosition(windowPointer, Int32(newValue), Int32(y))
        }
    }
    
    public var y: Int {
        get {
            var y: Int32 = 0
            SDL_GetWindowPosition(windowPointer, nil, &y)
            return Int(y)
        }
        set {
            SDL_SetWindowPosition(windowPointer, Int32(x), Int32(newValue))
        }
    }
    
    public var options: Option {
        return Option(rawValue: SDL_GetWindowFlags(windowPointer))
    }
    
    public func hide() {
        SDL_HideWindow(windowPointer)
    }
    
    public func show() {
        SDL_ShowWindow(windowPointer)
    }
    
    public func raise() {
        SDL_RaiseWindow(windowPointer)
    }
    
    public struct Option: OptionSet {
        
        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }
        
        public let rawValue: UInt32
        
        public static let fullscreen = Option(rawValue: SDL_WINDOW_FULLSCREEN.rawValue)
        public static let fullscreenDesktop = Option(rawValue: SDL_WINDOW_FULLSCREEN_DESKTOP.rawValue)
        public static let openGL = Option(rawValue: SDL_WINDOW_OPENGL.rawValue)
        public static let hidden = Option(rawValue: SDL_WINDOW_HIDDEN.rawValue)
        public static let borderless = Option(rawValue: SDL_WINDOW_BORDERLESS.rawValue)
        public static let resizable = Option(rawValue: SDL_WINDOW_RESIZABLE.rawValue)
        public static let minimized = Option(rawValue: SDL_WINDOW_MINIMIZED.rawValue)
        public static let maximized = Option(rawValue: SDL_WINDOW_MAXIMIZED.rawValue)
        public static let grabbed = Option(rawValue: SDL_WINDOW_INPUT_GRABBED.rawValue)
        public static let allowHighDPI = Option(rawValue: SDL_WINDOW_ALLOW_HIGHDPI.rawValue)
        
    }
    
    
}
