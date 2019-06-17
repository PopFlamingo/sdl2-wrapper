import CSDL2

public class SDL {
    
    private init() {}
    
    public static func initialize() {
        guard SDL_Init(UInt32(SDL_INIT_VIDEO)) != -1 else {
            fatalError(String(cString: SDL_GetError()))
        }
        
        let flags = Int32(IMG_INIT_JPG.rawValue | IMG_INIT_PNG.rawValue | IMG_INIT_TIF.rawValue)
        let result = IMG_Init(flags)
        guard flags & result == flags else {
            fatalError("IMG init error")
        }
        
        guard TTF_Init() == 0 else {
            fatalError("TTF init error")
        }
    }
    
    public static func quit() {
        IMG_Quit()
        TTF_Quit()
        SDL_Quit()
    }
    
    public static func screenResolution() -> (width: Int, height: Int) {
        var displayMode = SDL_DisplayMode()
        SDL_GetCurrentDisplayMode(0, &displayMode)
        return (width: Int(displayMode.w), height: Int(displayMode.h))
    }
    
    public static func getMouseState() -> (x: Int, y: Int) {
        var x: Int32 = 0
        var y: Int32 = 0
        SDL_GetMouseState(&x, &y)
        return (x: Int(x), y: Int(y))
    }
    
    public static func pollEvent() -> SDLEvent? {
        
        let sdlEventPtr: UnsafeMutablePointer<SDL_Event> = .allocate(capacity: 1)
        
        while SDL_PollEvent(sdlEventPtr) != 0 {
            let sdlEvent = sdlEventPtr.pointee
            switch sdlEvent.type {
                
            case SDL_QUIT.rawValue:
                return SDLQuitEvent(timestamp: Int(sdlEvent.common.timestamp))
                
                
            case SDL_MOUSEBUTTONDOWN.rawValue, SDL_MOUSEBUTTONUP.rawValue:
                let rme = sdlEvent.button
                let pos = getMouseState()
                return SDLMouseButtonEvent(timestamp: Int(rme.timestamp),
                                           x: Int(pos.x),
                                           y: Int(pos.y),
                                           type: SDLMouseButtonEvent.ButtonEventType(rawValue: rme.type),
                                           windowID: Int(rme.windowID),
                                           which: Int(rme.which),
                                           button: SDLMouseButtonEvent.Button(rawValue: Int32(rme.button)),
                                           clicks: Int(rme.clicks))
                
                
            case SDL_WINDOWEVENT.rawValue:
                let windowEvent = sdlEvent.window
                switch UInt32(windowEvent.event) {
                case SDL_WINDOWEVENT_SIZE_CHANGED.rawValue:
                    return SDLWindowSizeChanged(timestamp: Int(sdlEvent.common.timestamp))
                default:
                    break
                }
                
            case SDL_MOUSEMOTION.rawValue:
                let mouseMotionEvent = sdlEvent.motion
                let pos = getMouseState()
                return SDLMouseMotionEvent(timestamp: Int(mouseMotionEvent.timestamp),
                                           x: pos.x,
                                           y: pos.y)
                
                
            default:
                break
            }
        }
        
        return nil
    }
}
