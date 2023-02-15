//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2022-2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@available(Future, *)
extension PredicateExpressions {
    public enum ComparisonOperator: Codable, Sendable {
        case lessThan, lessThanOrEqual, greaterThan, greaterThanOrEqual
    }

    public struct Comparison<
        LHS : PredicateExpression,
        RHS : PredicateExpression
    > : PredicateExpression
    where
        LHS.Output == RHS.Output,
        LHS.Output : Comparable
    {
        public typealias Output = Bool
        
        public let op: ComparisonOperator

        public let lhs: LHS
        public let rhs: RHS
        
        public init(lhs: LHS, rhs: RHS, op: ComparisonOperator) {
            self.lhs = lhs
            self.rhs = rhs
            self.op = op
        }
        
        public func evaluate(_ bindings: PredicateBindings) throws -> Bool {
            let a = try lhs.evaluate(bindings)
            let b = try rhs.evaluate(bindings)
            switch op {
            case .lessThan:           return a < b
            case .lessThanOrEqual:    return a <= b
            case .greaterThan:        return a > b
            case .greaterThanOrEqual: return a >= b
            }
        }
    }
    
    public static func build_Comparison<LHS, RHS>(lhs: LHS, rhs: RHS, op: ComparisonOperator) -> Comparison<LHS, RHS> {
        Comparison(lhs: lhs, rhs: rhs, op: op)
    }
}

@available(Future, *)
extension PredicateExpressions.Comparison : StandardPredicateExpression where LHS : StandardPredicateExpression, RHS : StandardPredicateExpression {}

@available(Future, *)
extension PredicateExpressions.Comparison : Codable where LHS : Codable, RHS : Codable {}

@available(Future, *)
extension PredicateExpressions.Comparison : Sendable where LHS : Sendable, RHS : Sendable {}
