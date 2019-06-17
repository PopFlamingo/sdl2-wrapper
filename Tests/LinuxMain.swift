import XCTest

import SDL2Tests

var tests = [XCTestCaseEntry]()
tests += SDL2Tests.allTests()
XCTMain(tests)