import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SDL2Tests.allTests),
    ]
}
#endif