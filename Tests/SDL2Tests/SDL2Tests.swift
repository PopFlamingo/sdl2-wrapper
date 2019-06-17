import XCTest
@testable import SDL2

final class SDL2Tests: XCTestCase {
    func testExample() {
        SDL.initialize()
        let win = try! SDLWindow(x: 10, y: 10, width: 1000, height: 1000, options: [.openGL])
        SDL.quit()
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
