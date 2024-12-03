//
//  XCTFailureTests.swift
//
//
//  Created by Lenard Pop on 03/12/2024.
//

import XCTest
import Foundation
import XCTMockable

@testable import XCTBaseTests

final class XCTFailureTests: XCTBaseTests {
    func test_verifyCall_wrongCallCount() throws {
        // Arrange
        given(PropertiesProtocolMock.description).willReturn("False")
         
        // Assert
        let error = TestFailure.incorrectInvocationCount(
            expected: 2,
            received: 1
        ).errorDescription ?? ""
        
        XCTExpectFailure(error) {
            verify(PropertiesProtocolMock.description).wasCalled(2)
        }
    }
    
    func test_verifyCall_noResult() throws {
        // Assert
        let error = TestFailure.foundNoResult(
            key: "static var description: String"
        ).errorDescription ?? ""
        
        XCTExpectFailure(error) {
            verify(PropertiesProtocolMock.description).returned("False")
        }
    } 
    
    func test_verifyCall_wrongValue() throws {
        // Arrange
        given(PropertiesProtocolMock.description).willReturn("False")
        
        // Assert
        let error = TestFailure.wrongValue(
            value: "Falsey",
            providedValue: "False"
        ).errorDescription ?? ""
        
        XCTExpectFailure(error) {
            verify(PropertiesProtocolMock.description).returned("Falsey")
        }
    }
}
