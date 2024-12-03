//
//  StubbingManager.swift
//  
//
//  Created by Lenard Pop on 19/02/2024.
//

public protocol StubbingManagerProtocol {
    associatedtype ReturnType
    
    func willReturn(_ value: ReturnType)
}

public class StubbingManager<
    DeclarationType: Declaration,
    InvocationType,
    ReturnType
>: StubbingManagerProtocol {
    private let context: ContextContainer
    private let invocation: Invocation
        
    public init(context: ContextContainer, invocation: Invocation) {
        self.context = context
        self.invocation = invocation
    }
    
    public func willReturn(_ value: ReturnType) {
        self.context.stubbing.addStubs(invocation, value: value)
    }
}
