//
//  NSError+LocalizedError.swift
//
//  Created by Paul on 08/09/2023.
//

import Foundation

extension NSError {
        
    /// Create `NSError` that is potentially compatible with  `LocalizedError`.
    /// Parameter string literals can be extracted and localized with Xcode build-in tools.
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    public convenience init(domain: String = #file, code: Int = Int(#line), description: LocalizedStringResource? = nil, failureReason: LocalizedStringResource? = nil, recoverySuggestion: LocalizedStringResource? = nil, helpAnchor: LocalizedStringResource? = nil) {
        var userInfo = [String : Any]()
        
        if let description {
            userInfo[NSLocalizedDescriptionKey] = String(localized: description)
        }
        
        if let failureReason {
            userInfo[NSLocalizedFailureReasonErrorKey] = String(localized: failureReason)
        }
        
        if let recoverySuggestion {
            userInfo[NSLocalizedFailureReasonErrorKey] = String(localized: recoverySuggestion)
        }
        
        if let helpAnchor {
            userInfo[NSHelpAnchorErrorKey] = String(localized: helpAnchor)
        }
        
        self.init(domain: domain, code: code, userInfo: userInfo.isEmpty ? nil : userInfo)
    }
    
    /// Create `NSError` that is potentially compatible with  `LocalizedError`
    /// Parameter string literals should be wrapped in `NSLocalizedString()` be extracted and localized with Xcode build-in tools.
    @available(iOS, deprecated: 16, obsoleted: 16, message: "A better overload is available that takes advantage of `LocalizedStringResource`. No need to mess with `NSLocalizedString()` anymore.")
    public convenience init(domain: String = #file, code: Int = Int(#line), description: String? = nil, failureReason: String? = nil, recoverySuggestion: String? = nil, helpAnchor: String? = nil) {
        var userInfo = [String : Any]()
        
        if let description {
            userInfo[NSLocalizedDescriptionKey] = description
        }
        
        if let failureReason {
            userInfo[NSLocalizedFailureReasonErrorKey] = failureReason
        }
        
        if let recoverySuggestion {
            userInfo[NSLocalizedFailureReasonErrorKey] = recoverySuggestion
        }
        
        if let helpAnchor {
            userInfo[NSHelpAnchorErrorKey] = helpAnchor
        }
        
        self.init(domain: domain, code: code, userInfo: userInfo.isEmpty ? nil : userInfo)
    }
    
    
}


extension NSError: LocalizedError {
    
    public var errorDescription: String? { localizedDescription }
    
    public var failureReason: String? { localizedFailureReason }
    
    public var recoverySuggestion: String? { localizedRecoverySuggestion }
    
    // public var helpAnchor: String? { get }  // Goes as is.
}
