//
//  String+Extension.swift
//  OktoIDE
//
//  Created by Medi Assumani on 6/23/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

extension String {
    
    func encodeToBase64() {
        
        
    }
    
    func decodeFromBase64() -> String{
        
        guard let cleanEncodedString = self.replacingOccurrences(of: "\n", with: "") else { return }
        guard let data = Data(base64Encoded: cleanEncodedString) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
