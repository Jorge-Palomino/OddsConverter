import XCTest
import OddsConverter

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAmerican() {
        // Set input in US format
        let oddAme = OddsConverter(odd: "275")
        // Get fractional format
        XCTAssertEqual(oddAme.getFractional(), "69/25") // 69/25
        // Get decimal format
        XCTAssertEqual(oddAme.getDecimal(), "3.75") // 3.75
    }
    
    func testFractional() {
        // Set input in Fractional format
        let oddFra = OddsConverter(odd: "11/4")
        // Get moneyline (US) format
        XCTAssertEqual(oddFra.getMoneyline(), "+275") // +275
        // Get decimal format
        XCTAssertEqual(oddFra.getDecimal(), "3.75") // 3.75
    }
    
    func testDecimal() {
        // Set input in Decimal format
        let oddDec = OddsConverter(odd: "3.75")
        // Get moneyline (US) format
        XCTAssertEqual(oddDec.getMoneyline(), "+275") // +275
        // Get fractional format
        XCTAssertEqual(oddDec.getFractional(), "69/25") // 69/25
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
