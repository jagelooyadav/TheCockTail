//
//  UIView+Extension.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 23/02/22.
//

import Foundation
import UIKit

public enum ConstraintRelation {
    case equal
    case greaterOrEqual
    case lessOrEqual
    case ignore
}

public extension UIView {
    @discardableResult func anchorToSuperView(leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
                                              trailingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>? = nil,
                                              topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                                              bottomAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>? = nil,
                                              leadingRelation: ConstraintRelation = .equal,
                                              trailingRelation: ConstraintRelation = .equal,
                                              topRelation: ConstraintRelation = .equal,
                                              bottomRelation: ConstraintRelation = .equal,
                                              leading: CGFloat = 0.0,
                                              trailing: CGFloat = 0.0,
                                              top: CGFloat = 0.0,
                                              bottom: CGFloat = 0.0) -> [NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        var appliedConstraints: [NSLayoutConstraint] = []
        self.addLeading(relation: leadingRelation,
                        leadingAnchor: leadingAnchor,
                        constant: leading,
                        appliedConstraints: &appliedConstraints)
        self.addTrailing(relation: trailingRelation,
                         trailingAnchor: trailingAnchor,
                         constant: trailing,
                         appliedConstraints: &appliedConstraints)
        self.addTop(relation: topRelation,
                    topAnchor: topAnchor,
                    constant: top,
                    appliedConstraints: &appliedConstraints)
        self.addBottom(relation: bottomRelation,
                       bottomAnchor: bottomAnchor,
                       constant: bottom,
                       appliedConstraints: &appliedConstraints)
        NSLayoutConstraint.activate(appliedConstraints)
        return appliedConstraints
    }
    
    private func addLeading(relation: ConstraintRelation,
                            leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
                            constant: CGFloat,
                            appliedConstraints: inout [NSLayoutConstraint]) {
        guard let superview = self.superview else { return }
        let xAxisAnchor = leadingAnchor ?? superview.leadingAnchor
        switch relation {
        case .equal:
            appliedConstraints.append(self.leadingAnchor.constraint(equalTo: xAxisAnchor, constant: constant))
        case .greaterOrEqual:
            appliedConstraints.append(self.leadingAnchor.constraint(greaterThanOrEqualTo: xAxisAnchor, constant: constant))
        case .lessOrEqual:
            appliedConstraints.append(self.leadingAnchor.constraint(lessThanOrEqualTo: xAxisAnchor, constant: constant))
        case .ignore:
            break
        }
    }
    
    private func addTrailing(relation: ConstraintRelation,
                             trailingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?,
                             constant: CGFloat,
                             appliedConstraints: inout [NSLayoutConstraint]) {
        
        guard let superview = self.superview else { return }
        let xAxisAnchor = trailingAnchor ?? superview.trailingAnchor
        switch relation {
        case .equal:
            appliedConstraints.append(xAxisAnchor.constraint(equalTo: self.trailingAnchor, constant: constant))
        case .greaterOrEqual:
            appliedConstraints.append(xAxisAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: constant))
        case .lessOrEqual:
            appliedConstraints.append(xAxisAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: constant))
        case .ignore:
            break
        }
    }
    
    private func addTop(relation: ConstraintRelation,
                        topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
                        constant: CGFloat,
                        appliedConstraints: inout [NSLayoutConstraint]) {
        guard let superview = self.superview else { return }
        let yAxisAnchor = topAnchor ?? superview.topAnchor
        switch relation {
        case .equal:
            appliedConstraints.append(self.topAnchor.constraint(equalTo: yAxisAnchor, constant: constant))
        case .greaterOrEqual:
            appliedConstraints.append(self.topAnchor.constraint(greaterThanOrEqualTo: yAxisAnchor, constant: constant))
        case .lessOrEqual:
            appliedConstraints.append(self.topAnchor.constraint(lessThanOrEqualTo: yAxisAnchor, constant: constant))
        case .ignore:
            break
        }
    }
    
    private func addBottom(relation: ConstraintRelation,
                           bottomAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>?,
                           constant: CGFloat,
                           appliedConstraints: inout [NSLayoutConstraint]) {
        
        guard let superview = self.superview else { return }
        let yAxisAnchor = bottomAnchor ?? superview.bottomAnchor
        switch relation {
        case .equal:
            appliedConstraints.append(yAxisAnchor.constraint(equalTo: self.bottomAnchor, constant: constant))
        case .greaterOrEqual:
            appliedConstraints.append(yAxisAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: constant))
        case .lessOrEqual:
            appliedConstraints.append(yAxisAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: constant))
        case .ignore:
            break
        }
    }
}
