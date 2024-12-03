//
//  Mockable.swift
//  
//
//  Created by Lenard Pop on 19/02/2024.
//

public struct Mockable<DeclarationType: Declaration, InvocationType, ReturnType>: AnyMockableProtocol {
    public var context: ContextContainer
    public var invocation: Invocation
    public var returnType: ObjectIdentifier
    
    public init(context: ContextContainer, invocation: Invocation, returnType: ObjectIdentifier) {
        self.context = context
        self.invocation = invocation
        self.returnType = returnType
    }
}
