import Testing
@testable import MMLCore

@Test
func httpErrorsWithSamePayloadAreEqual() {
    #expect(AppError.http(message: "Not Found", code: 404) == AppError.http(message: "Not Found", code: 404))
}

@Test
func httpErrorsWithDifferentCodeAreNotEqual() {
    #expect(AppError.http(message: "Not Found", code: 404) != AppError.http(message: "Not Found", code: 500))
}
