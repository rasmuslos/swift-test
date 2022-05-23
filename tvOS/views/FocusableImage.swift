//
//  FocusableImage.swift
//  tvOS
//
//  Created by Rasmus Krämer on 23.05.22.
//

import SwiftUI

class FocusableImage: UIImage {
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        backgroundColor = context.nextFocusedView == self ? .blue:.red
    }
}
