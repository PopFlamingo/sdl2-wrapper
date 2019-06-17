//
//  SDLTexture.swift
//  SDL2
//
//  Created by Trevör Anne Denise on 09/11/2018.
//

import Foundation
import CSDL2

public class SDLTexture {
    
    convenience public init(renderer: SDLRenderer, imagePath: String) {
        let surface = SDLSurface(imagePath: imagePath)
        self.init(renderer: renderer, surface: surface)
    }
    
    
    public init(renderer: SDLRenderer, format: UInt32, access: Access, width: Int, height: Int) {
        self.texturePointer = SDL_CreateTexture(renderer.rendererPointer, format, Int32(access.rawValue), Int32(width), Int32(height))
    }
    
    public init(renderer: SDLRenderer, surface: SDLSurface) {
        if let texturePointer = SDL_CreateTextureFromSurface(renderer.rendererPointer, surface.surfacePointer) {
            self.texturePointer = texturePointer
        } else {
            fatalError("Could not convert surface to texture")
        }
    }
    
    let texturePointer: OpaquePointer
    
    public var width: Int {
        var w: Int32 = 0
        SDL_QueryTexture(texturePointer, nil, nil, &w, nil)
        return Int(w)
    }
    
    public var height: Int {
        var h: Int32 = 0
        SDL_QueryTexture(texturePointer, nil, nil, nil, &h)
        return Int(h)
    }
    
    public enum Access: RawRepresentable {
        
        case statically, streaming, target
        
        public init(rawValue: UInt32) {
            switch rawValue {
            case SDL_TEXTUREACCESS_STATIC.rawValue:
                self = .statically
            case SDL_TEXTUREACCESS_STREAMING.rawValue:
                self = .streaming
            case SDL_TEXTUREACCESS_TARGET.rawValue:
                self = .target
            default:
                fatalError("Unknown access raw value")
            }
        }
        
        public var rawValue: UInt32 {
            switch self {
            case .statically:
                return SDL_TEXTUREACCESS_STATIC.rawValue
            case .streaming:
                return SDL_TEXTUREACCESS_STREAMING.rawValue
            case .target:
                return SDL_TEXTUREACCESS_TARGET.rawValue
            }
        }
        
    }
}
