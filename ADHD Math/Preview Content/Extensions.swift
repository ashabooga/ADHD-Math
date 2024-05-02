//
//  Extensions.swift
//  ADHD Learning
//
//  Created by Ben Cuello-Wolffe on 1/28/24.
//

import Foundation
import SwiftUI

extension Text {

    func titleText(color: Color) -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundStyle(color)
    }
    
    func questionText(color: Color) -> some View {
        self.font(.title2)
            .font(.system(size: 15))
            .foregroundStyle(color)
    }
    
    func questionTitleText(isBold: Bool) -> some View {
        self.font(.title2)
            .fontWeight(isBold ? .heavy : .semibold)
            .foregroundStyle(Color.black)
    }
}

extension UIView {
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview?.superview(of: type)
    }
    
    func currentFirstResponder() -> UIResponder? {
        if self.isFirstResponder {
            return self
        }

        for view in self.subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }

        return nil
    }
}

