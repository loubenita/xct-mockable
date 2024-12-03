//
//  XCTBaseTests.swift
//
//
//  Created by Lenard Pop on 13/05/2024.
//

import XCTest
import Foundation

public class XCTBaseTests: XCTestCase {
    internal let asyncMock = AsyncProtocolMock()
    internal let throwsMock = ThrowsProtocolMock()
    internal let methodsMock = MethodsProtocolMock()
    internal let subscriptMock = SubscriptProtocolMock()
    internal let propertiesMock = PropertiesProtocolMock()
    internal let asyncThrowsMock = AsyncThrowsProtocolMock()
    
    private var expectedFailures: [String] = []

    public override func record(_ issue: XCTIssue) {
        if expectedFailures.contains(issue.compactDescription) {
            expectedFailures.removeAll { $0 == issue.compactDescription }
            return
        }
        super.record(issue)
    }
    
    public func XCTExpectFailure(_ message: String, _ expression: @escaping () -> Void) {
        expectedFailures.append("failed - \(message)")
        expression()
        XCTAssertTrue(expectedFailures.isEmpty, "Expected failure did not occur.")
    }
}
