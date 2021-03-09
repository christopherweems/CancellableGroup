//  CancellableGroupBuilder.swift
//  Created by Christopher Weems on 2/22/21

import Combine
import ForEach

@resultBuilder
public struct CancellableGroupBuilder {
    public static func buildBlock(_ sinks: Cancellable...) -> CancellableGroup {
        .init(sinks)
    }
    
    public static func buildEither(first: Cancellable) -> Cancellable {
        first
    }
    
    public static func buildEither(second: Cancellable) -> Cancellable {
        second
    }
    
    public static func buildOptional(_ value: Cancellable?) -> Cancellable {
        value ?? AnyCancellable { }
    }
    
    public static func buildArray(_ components: [Cancellable]) -> Cancellable {
        AnyCancellable {
            components.forEach { $0.cancel() }
        }
    }
    
}

extension CancellableGroupBuilder {
    public static func buildExpression(_ cancellable: Cancellable) -> Cancellable {
        cancellable
    }
    
    public static func buildExpression(_ cancellable: Optional<Cancellable>) -> Cancellable {
        cancellable ?? AnyCancellable { }
    }
    
    public static func buildExpression<Data, Content>(_ forEach: ForEach<Data, Content>) -> Cancellable
        where Content : Cancellable {
        let content = forEach.data.map(forEach.content)
        
        return AnyCancellable {
            content.cancel()
            
        }
    }
    
}

fileprivate extension Collection where Element : Cancellable {
    func cancel() {
        self.forEach { $0.cancel() }
    }
    
}
