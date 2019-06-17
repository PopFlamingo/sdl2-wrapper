import CSDL2

public class SDLEvent {
    
    init(timestamp: Int) {
        self.timestamp = timestamp
    }
    
    var timestamp: Int
}

public class SDLQuitEvent: SDLEvent {
}

public class SDLWindowSizeChanged: SDLEvent {
}

public class SDLMouseButtonEvent: SDLEvent {
    init(timestamp: Int, x: Int, y: Int, type: ButtonEventType, windowID: Int, which: Int, button: Button, clicks: Int) {
        self.x = x
        self.y = y
        
        self.type = type
        self.windowID = windowID
        self.which = which
        self.button = button
        self.clicks = clicks
        
        super.init(timestamp: timestamp)
    }
    
    public let x: Int
    public let y: Int
    
    public let type: ButtonEventType
    public let windowID: Int
    public let which: Int
    public let button: Button
    public let clicks: Int
    
    public enum ButtonEventType: RawRepresentable {
        
        case buttonDown, buttonUp
        
        public init(rawValue: UInt32) {
            switch rawValue {
            case SDL_MOUSEBUTTONDOWN.rawValue:
                self = .buttonDown
            case SDL_MOUSEBUTTONUP.rawValue:
                self = .buttonUp
            default:
                fatalError("Unknown button event type")
            }
        }
        
        public var rawValue: UInt32 {
            switch self {
            case .buttonDown:
                return SDL_MOUSEBUTTONDOWN.rawValue
            case .buttonUp:
                return SDL_MOUSEBUTTONUP.rawValue
            }
        }
        
    }
    
    public enum Button: RawRepresentable {
        
        case left, middle, right, x1, x2
        
        public init(rawValue: Int32) {
            switch rawValue {
            case SDL_BUTTON_LEFT:
                self = .left
            case SDL_BUTTON_MIDDLE:
                self = .middle
            case SDL_BUTTON_RIGHT:
                self = .right
            case SDL_BUTTON_X1:
                self = .x1
            case SDL_BUTTON_X2:
                self = .x2
            default:
                fatalError("Unknown button")
            }
        }
        
        public var rawValue: Int32 {
            switch self {
            case .left:
                return SDL_BUTTON_LEFT
            case .middle:
                return SDL_BUTTON_MIDDLE
            case .right:
                return SDL_BUTTON_RIGHT
            case .x1:
                return SDL_BUTTON_X1
            case .x2:
                return SDL_BUTTON_X2
            }
        }
        
    }
    
    public enum ButtonState: RawRepresentable {
        
        case pressed, released
        
        public init(rawValue: Int32) {
            switch rawValue {
            case SDL_PRESSED:
                self = .pressed
            case SDL_RELEASED:
                self = .released
            default:
                fatalError("Unknown button state")
            }
        }
        
        public var rawValue: Int32 {
            switch self {
            case .pressed:
                return SDL_PRESSED
            case .released:
                return SDL_RELEASED
            }
        }
        
        
    }
    
}


public class SDLMouseMotionEvent: SDLEvent {
    
    public init(timestamp: Int, x: Int, y: Int) {
        self.x = x
        self.y = y
        super.init(timestamp: timestamp)
    }
    
    public var x: Int
    public var y: Int
    
}
