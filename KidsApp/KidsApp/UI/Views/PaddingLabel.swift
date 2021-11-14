//
//  PaddingLabel.swift
//  KidsApp
//
//  Created by Tatyana Balashenko on 31.05.21.
//

import UIKit

final class PaddingLabel: UILabel {

    let padding: UIEdgeInsets

    required init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        self.padding = padding
        super.init(frame: CGRect.zero)
    }

    override init(frame: CGRect) {
        padding = UIEdgeInsets.zero
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        padding = UIEdgeInsets.zero
        super.init(coder: aDecoder)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let height = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: height)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        let heigth = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }

}
