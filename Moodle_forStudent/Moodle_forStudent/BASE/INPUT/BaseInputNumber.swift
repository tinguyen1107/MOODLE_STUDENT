
import UIKit


class BaseInputNumber: BaseInput {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInput()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInput()
    }
    
    private func setupInput () {
        keyboardType = .numberPad
    }
}

