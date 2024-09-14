//
//  Bindable.swift
//  Map
//
//  Created by Paulo Magro on 10/09/24.
//

import Foundation
public class Bindable<T> {
    public typealias Listener = (T) -> ()
    
    // MARK: - Properties
    public var listener: Listener?

    // MARK: - Triggers
    public var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    // MARK: - Constructors
    public init(_ v: T) {
        value = v
    }
    
    // MARK: - Bind
    public func bind(_ listener: @escaping Listener) {
        self.listener = listener
    }
}
