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
    
}
