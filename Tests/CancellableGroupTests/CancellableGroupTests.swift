import Combine
import XCTest
@testable import CancellableGroup

final class CancellableGroupTests: XCTestCase {
    func testCancelling() {
        var wasCancelled = false
        
        XCTAssertFalse(wasCancelled)
        
        let group = CancellableGroup {
            AnyCancellable {
                wasCancelled = true
                
            }
            
        }
        
        XCTAssertFalse(wasCancelled)
        group.cancel()
        
        XCTAssert(wasCancelled)
        
    }
    
    func testGroupBuilder() {
        enum TestEnum: Int {
            case first = 0
            case second
            case third
            
        }
        
        let includeFirstGroup = Bool.random()
        let switchSelection = TestEnum(rawValue: Int.random(in: 0..<3))!
        
        let group = CancellableGroup {
            if includeFirstGroup {
                AnyCancellable {
                    
                }
                
            } else {
                AnyCancellable {
                    
                }
                
            }
            
            switch switchSelection {
            case .first:
                AnyCancellable { }
                
            case .second:
                AnyCancellable { }
                
            case .third:
                AnyCancellable { }
                
            }
            
            for _ in 0..<4 {
                AnyCancellable { }
                
            }
            
        }
        
        XCTAssertNotNil(group)
        
    }
    
    func testOptionalGroupBuilder() {
        weak var weakVarA: NSArray?
        weak var weakVarB: NSArray?
        
        var group: CancellableGroup!
        
        _ = {
            let strongVarA = NSArray(array: [NSObject()])
            let strongVarB = NSArray(array: [NSObject()])
            
            weakVarA = strongVarA
            weakVarB = strongVarB
            
            let a: Cancellable? = AnyCancellable { _ = strongVarA }
            let b: Cancellable = AnyCancellable { _ = strongVarB }
            
            group = CancellableGroup {
                a
                b
                
            }
            
        }()
        
        XCTAssertNotNil(weakVarA)
        XCTAssertNotNil(weakVarB)
        
        group.cancel()
        
        XCTAssertNil(weakVarA)
        XCTAssertNil(weakVarB)
        
    }
    
}
