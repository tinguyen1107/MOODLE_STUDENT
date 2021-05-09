import UIKit

class BaseInputByPickup: BaseInput {
    
    var picker = UIPickerView()

    public var selections = ["first", "second"]
    private var chosen = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createPicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createPicker()
    }
    
    private func createPicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        // bar button (done)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        // assign toolbar
        inputAccessoryView = toolbar
        
        picker.dataSource = self
        picker.delegate = self
        
        self.inputView = picker
    }
    
    @objc func donePressed() {
        text = selections[chosen]
        endEditing(true)
    }
}

extension BaseInputByPickup: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.selections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selections[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosen = row
    }
}
