
//
//  SettingsViewController.swift
//  Demo
//
//  Created by Sergey Sivak on 19/07/16.
//
//

import UIKit
import IconFactory

class SettingsViewController: UIViewController {

    @IBOutlet weak var iconsStyleTextField: UITextField!
    
    @IBOutlet weak var iconTypeTextField: UITextField!
    
    @IBOutlet weak var foregroundColorTextField: UITextField!
    
    @IBOutlet weak var backgroundColorTextField: UITextField!
    
    @IBOutlet weak var widthTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    private var style: IconsStyle?
    
    private var stylePicker: UIPickerView!
    
    private var typePicker: UIPickerView!
    
    private var foregroundColorPicker: UIPickerView!
    
    private var backgroundColorPicker: UIPickerView!
    
    @IBOutlet weak var widthStepper: UIStepper!
    
    @IBOutlet weak var heightStepper: UIStepper!
    
    private var colorHexArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
    
    override func viewDidLoad() {
        let toolbar = UIToolbar(frame: CGRect(origin: CGPointZero, size: CGSize(width: view.bounds.width, height: 44)))
        toolbar.barStyle = .Black
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(resignKeyboard)),
        ]
        stylePicker = createPicker()
        iconsStyleTextField.inputView = stylePicker
        iconsStyleTextField.inputAccessoryView = toolbar
        iconsStyleTextField.delegate = self
        
        typePicker = createPicker()
        iconTypeTextField.inputView = typePicker
        iconTypeTextField.inputAccessoryView = toolbar
        iconTypeTextField.delegate = self
        
        foregroundColorPicker = createPicker()
        foregroundColorTextField.inputView = foregroundColorPicker
        foregroundColorTextField.inputAccessoryView = toolbar
        foregroundColorTextField.delegate = self
        
        backgroundColorPicker = createPicker()
        backgroundColorTextField.inputView = backgroundColorPicker
        backgroundColorTextField.inputAccessoryView = toolbar
        backgroundColorTextField.delegate = self
        
        widthTextField.enabled = false
        heightTextField.enabled = false
        
        widthStepper.minimumValue = 1.0
        widthStepper.maximumValue = 500.0
        
        heightStepper.minimumValue = 1.0
        heightStepper.maximumValue = 500.0
        
        widthStepper.addTarget(self, action: #selector(stepperDidChanged), forControlEvents: .ValueChanged)
        heightStepper.addTarget(self, action: #selector(stepperDidChanged), forControlEvents: .ValueChanged)
        
        setDefaultValues()
    }
    
    func createPicker() -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        return picker
    }
    
    private func setDefaultValues() {
        stylePicker.selectRow(0, inComponent: 0, animated: false)
        typePicker.selectRow(0, inComponent: 0, animated: false)
        foregroundColorPicker.selectRow(15, inComponent: 1, animated: true)
        foregroundColorPicker.selectRow(15, inComponent: 2, animated: true)
        foregroundColorPicker.selectRow(15, inComponent: 3, animated: true)
        foregroundColorPicker.selectRow(15, inComponent: 4, animated: true)
        foregroundColorPicker.selectRow(15, inComponent: 5, animated: true)
        foregroundColorPicker.selectRow(15, inComponent: 6, animated: true)
        backgroundColorPicker.selectRow(0, inComponent: 1, animated: true)
        backgroundColorPicker.selectRow(0, inComponent: 2, animated: true)
        backgroundColorPicker.selectRow(0, inComponent: 3, animated: true)
        backgroundColorPicker.selectRow(0, inComponent: 4, animated: true)
        backgroundColorPicker.selectRow(0, inComponent: 5, animated: true)
        backgroundColorPicker.selectRow(0, inComponent: 6, animated: true)
        widthStepper.value = 44.0
        heightStepper.value = 44.0
        
        stepperDidChanged(widthStepper)
        stepperDidChanged(heightStepper)
        iconsStyleTextField.text = IconsStyle.fontAwesome.description
        style = IconsStyle.fontAwesome
        iconTypeTextField.text = IconFactory.availableIconTypes.first
        foregroundColorTextField.text = "#FFFFFF"
        let fColor = UIColor(hexString: "#FFFFFF")
        foregroundColorTextField.textColor = fColor.inversedColor()
        foregroundColorTextField.backgroundColor = fColor
        backgroundColorTextField.text = "#000000"
        let bColor = UIColor(hexString: "#000000")
        backgroundColorTextField.textColor = bColor.inversedColor()
        backgroundColorTextField.backgroundColor = bColor
    }
    
    @IBAction private func saveBarButtonDidTouchUpInside(sender: UIBarButtonItem) {
        
    }
    
    private dynamic func resignKeyboard() {
        for textField in [iconsStyleTextField, iconTypeTextField, backgroundColorTextField, foregroundColorTextField] {
            textField.resignFirstResponder()
        }
    }
    
    private dynamic func stepperDidChanged(stepper: UIStepper) {
        switch stepper {
        case widthStepper:
            widthTextField.text = stepper.value.description
        case heightStepper:
            heightTextField.text = stepper.value.description
        default:
            break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard
            let viewController = segue.destinationViewController as? DetailViewController,
            let style = style,
            let name = iconTypeTextField.text where !name.isEmpty
        else {
            return
        }
        let width = (widthTextField.text! as NSString).doubleValue
        let height = (heightTextField.text! as NSString).doubleValue
        guard width > 0.0 && height > 0.0 else {
            return
        }
        let fColor = UIColor(hexString: foregroundColorTextField.text!)
        let bColor = UIColor(hexString: backgroundColorTextField.text!)
        
        viewController.style = style
        viewController.name = name
        viewController.fColor = fColor
        viewController.size = CGSize(width: width, height: height)
        viewController.bColor = bColor
    }
}

extension UIColor {
    
    convenience init(hexString: String) {
        var cString = hexString
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        guard cString.characters.count == 6 else {
            self.init(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 0.0
            )
            return
        }
        
        var rgbValue: UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func inversedColor() -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return self
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case stylePicker:
            style = [IconsStyle.fontAwesome][row]
            iconsStyleTextField.text = [IconsStyle.fontAwesome][row].description
        case typePicker:
            iconTypeTextField.text = IconFactory.availableIconTypes[row]
        case foregroundColorPicker:
            let colorHexString = "#" +
                colorHexArray[pickerView.selectedRowInComponent(1)] +
                colorHexArray[pickerView.selectedRowInComponent(2)] +
                colorHexArray[pickerView.selectedRowInComponent(3)] +
                colorHexArray[pickerView.selectedRowInComponent(4)] +
                colorHexArray[pickerView.selectedRowInComponent(5)] +
                colorHexArray[pickerView.selectedRowInComponent(6)]
            let color = UIColor(hexString: colorHexString)
            foregroundColorTextField.backgroundColor = color
            foregroundColorTextField.textColor = color.inversedColor()
            foregroundColorTextField.text = colorHexString
        case backgroundColorPicker:
            let colorHexString = "#" +
                colorHexArray[pickerView.selectedRowInComponent(1)] +
                colorHexArray[pickerView.selectedRowInComponent(2)] +
                colorHexArray[pickerView.selectedRowInComponent(3)] +
                colorHexArray[pickerView.selectedRowInComponent(4)] +
                colorHexArray[pickerView.selectedRowInComponent(5)] +
                colorHexArray[pickerView.selectedRowInComponent(6)]
            let color = UIColor(hexString: colorHexString)
            backgroundColorTextField.backgroundColor = color
            backgroundColorTextField.textColor = color.inversedColor()
            backgroundColorTextField.text = colorHexString
        default:
            break
        }
    }

    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch pickerView {
        case stylePicker:
            return NSAttributedString(string: [IconsStyle.fontAwesome][row].description)
        case typePicker:
            return NSAttributedString(string: IconFactory.availableIconTypes[row])
        case foregroundColorPicker, backgroundColorPicker:
            switch component {
            case 0:
                return NSAttributedString(string: "#")
            case 1, 2:
                return NSAttributedString(string: colorHexArray[row], attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            case 3, 4:
                return NSAttributedString(string: colorHexArray[row], attributes: [NSForegroundColorAttributeName: UIColor.greenColor()])
            case 5,6:
                return NSAttributedString(string: colorHexArray[row], attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
            default:
                return .None
            }
        default:
            return .None
        }
    }

    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case stylePicker:
            return [IconsStyle.fontAwesome][row].description
        case typePicker:
            return IconFactory.availableIconTypes[row]
        case foregroundColorPicker, backgroundColorPicker:
            if component == 0 { return "#" } else { return colorHexArray[row] }
        default:
            return .None
        }
    }
}

extension SettingsViewController: UIPickerViewDataSource {
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        switch pickerView {
        case stylePicker, typePicker:
            return 1
        case foregroundColorPicker, backgroundColorPicker:
            return 7
        default:
            return 0
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case stylePicker:
            return [IconsStyle.fontAwesome].count
        case typePicker:
            return IconFactory.availableIconTypes.count
        case foregroundColorPicker, backgroundColorPicker:
            if component == 0 { return 1 } else { return colorHexArray.count }
        default:
            return 0
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField {
        case iconsStyleTextField, iconTypeTextField, backgroundColorTextField, foregroundColorTextField:
            break
        case widthTextField, heightTextField:
            break
        default:
            break
        }
    }
}

