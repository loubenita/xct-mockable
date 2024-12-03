//
//  Mockable+Equatable.swift
//
//
//  Created by Lenard Pop on 03/12/2024.
//

import Foundation

@testable import XCTMockable

extension Mockable: Equatable where DeclarationType: Declaration, Invocation: Equatable, ReturnType: Equatable {
    public static func == (
        lhs: Mockable<DeclarationType, InvocationType, ReturnType>,
        rhs: Mockable<DeclarationType, InvocationType, ReturnType>
    ) -> Bool {
        return lhs.invocation == rhs.invocation &&
               lhs.returnType == rhs.returnType
    }
}
