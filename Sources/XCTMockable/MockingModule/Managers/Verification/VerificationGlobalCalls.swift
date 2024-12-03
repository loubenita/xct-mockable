//
//  VarificationGlobalCalls.swift
//
//
//  Created by Lenard Pop on 03/12/2024.
//

import Foundation

// MARK: Verification Calls

public func verify<DeclarationType: Declaration, InvocationType, ReturnType>(
    _ declaration: Mockable<DeclarationType, InvocationType, ReturnType>,
    file: StaticString = #file,
    line: UInt = #line
) -> VerificationManager<DeclarationType, ReturnType> {
    return VerificationManager(context: declaration.context,
                               invocation: declaration.invocation,
                               sourceLocation: SourceLocation(file, line))
}

public func verify<ReturnType>(
    _ declaration: @autoclosure () throws -> ReturnType,
    file: StaticString = #file,
    line: UInt = #line
) -> VerificationManager<Any?, ReturnType> {
    let invocations = InvocationsRecorder().startRecording {
        _ = try? declaration()
    }
    
    return VerificationManager(context: invocations.result.context,
                               invocation: invocations.result.invocation,
                               sourceLocation: SourceLocation(file, line))
}
