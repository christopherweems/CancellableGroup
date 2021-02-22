//  CancellableGroup.swift
//  Created by Christopher Weems on 2/22/21

import Combine

public final class CancellableGroup {
    private let sinks: [Cancellable]
    private var hasCancelled = false
    
    public init(_ sinks: [Cancellable]) {
        self.sinks = sinks
        
    }
    
    public init(@CancellableGroupBuilder _ group: () -> CancellableGroup) {
        let built = group()
        built.hasCancelled = true // to prevent cancellation of children in `deinit`
        
        self.sinks = built.sinks
        
    }
    
    deinit {
        self.cancel()
        
    }
    
}

extension CancellableGroup: Cancellable {
    public func cancel() {
        guard !hasCancelled else { return }
        defer { hasCancelled = true }
        sinks.forEach { $0.cancel() }
    }
    
}
