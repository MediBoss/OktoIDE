//
//  String+Extension.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

extension String {
    
    func encodeToBase64() -> String {
        
        let cleanDecodedString = self.replacingOccurrences(of: "\n", with: "")
        let encodedString = Data(self.utf8).base64EncodedString()
        
        return encodedString
    }
    
    func decodeFromBase64() -> String{
        
        let cleanEncodedString = self.replacingOccurrences(of: "\n", with: "")
        guard let data = Data(base64Encoded: cleanEncodedString) else { return "" }
        return String(data: data, encoding: .utf8)!
    }
    
    func grabSubstring(start at: String.Index?, on string: String) -> String {
        
        let ext = string.suffix(from: at!).replacingOccurrences(of: ".", with: "")
        return ext
    }
}
