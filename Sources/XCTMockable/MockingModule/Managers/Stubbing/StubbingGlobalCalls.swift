//
//  StubbingGlobalCalls.swift
//
//
//  Created by Lenard Pop on 03/12/2024.
//

import Foundation

public func givenSwift<DeclarationType: Declaration,InvocationType, ReturnType>(
    _ mockable: Mockable<DeclarationType, InvocationType, ReturnType>
) -> StubbingManager<DeclarationType, InvocationType, ReturnType> {
    return given(mockable)
}

public func given<DeclarationType: Declaration,InvocationType,ReturnType>(
    _ mockable: Mockable<DeclarationType, InvocationType, ReturnType>
) -> StubbingManager<DeclarationType, InvocationType,ReturnType> {
    return StubbingManager(context: mockable.context, invocation: mockable.invocation)
}

//@available(*, deprecated, renamed: "givenSwift",
//           message: "Unable to infer types for this stub; switch to 'givenSwift' to disambiguate")
//public func given<T: AnyMockableProtocol>(_ declaration: T) -> StubbingManager<AnyDeclaration, Any?, Any?> {
//    fatalError("Incorrect parameter or return types")
//}

public func given<ReturnType>(
    _ declaration: @autoclosure () throws -> ReturnType
) -> StubbingManager<XCTMockable.VariableDeclaration, Any?, ReturnType> {
    let invocations = InvocationsRecorder().startRecording {
        _ = try? declaration()
    }
    
    guard let record = invocations.result else {
        preconditionFailure("Failed to get the records.")
    }
    
    return StubbingManager(
        context: record.context,
        invocation: record.invocation
    )
}
