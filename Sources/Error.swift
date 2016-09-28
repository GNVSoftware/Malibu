import Foundation

public enum Error: ErrorType {
  case NoMockProvided
  case InvalidRequestURL
  case MissingContentType
  case InvalidParameter
  case InvalidUploadFilePath
  case NoDataInResponse
  case NoResponseReceived
  case UnacceptableStatusCode(Int)
  case UnacceptableContentType(String)
  case JSONArraySerializationFailed
  case JSONDictionarySerializationFailed
  case StringSerializationFailed(UInt)

  public var reason: String {
    var text: String

    switch self {
    case .NoMockProvided:
      text = "No mock provided for the current request and method"
    case .InvalidRequestURL:
      text = "Invalid request URL"
    case .MissingContentType:
      text = "Response content type was missing"
    case .InvalidParameter:
      text = "Parameter is not convertible to NSData"
    case .InvalidUploadFilePath:
      text = "Invalid upload file path"
    case .NoDataInResponse:
      text = "No data in response"
    case .NoResponseReceived:
      text = "No response received"
    case .UnacceptableStatusCode(let statusCode):
      text = "Response status code \(statusCode) was unacceptable"
    case .UnacceptableContentType(let contentType):
      text = "Response content type \(contentType) was unacceptable"
    case .JSONArraySerializationFailed:
      text = "No JSON array in response data"
    case .JSONDictionarySerializationFailed:
      text = "No JSON dictionary in response data"
    case .StringSerializationFailed(let encoding):
      text = "String could not be serialized with encoding: \(encoding)"
    }

    return NSLocalizedString(text, comment: "")
  }
}

// MARK: - Hashable

extension Error: Hashable {

  public var hashValue: Int {
    return reason.hashValue
  }
}

// MARK: - Equatable

public func ==(lhs: Error, rhs: Error) -> Bool {
  return lhs.reason == rhs.reason
}

// MARK: - NSError

extension NSError {

  var isOffline: Bool {
    return Int32(code) == CFNetworkErrors.CFURLErrorNotConnectedToInternet.rawValue
  }
}
