//

import UIKit

class ClickListener : UITapGestureRecognizer {
    var onClick: (() -> Void)? = nil
}

extension UIStackView {
    
    func setOnClickListener(action: @escaping () -> Void) {
        let tapGeture = ClickListener(target: self, action: #selector(onClick(sender:)))
        tapGeture.onClick = action
        addGestureRecognizer(tapGeture)
    }
    
    @objc
    func onClick(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
}
