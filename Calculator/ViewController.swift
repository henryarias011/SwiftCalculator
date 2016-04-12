//
//  ViewController.swift
//  Calculator
//
//  Created by Henry Arias on 4/27/15.
//  Copyright (c) 2015 Henry Arias. All rights reserved.
//

import UIKit

// need to consider a split view controller or a tab controller possibly with modal segways to handle increasing number of calculator operations, maybe a BASIC, Scientific, Financial, Conversion accessible via mutiple tabs

class ViewController: UIViewController

{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false

    @IBAction func appendDigit(sender: UIButton) {
      
     let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text =  digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performSqrt { sqrt($0)}
        case "℃": performCelcius { ($0 - 32) / 1.800 }
        case "℉": performFarenheit { ($0 * 1.800) + 32 }
        case "Kph": performKph { $0 * 1.609344}
        case "Mph": performMph { $0 / 1.609344}
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) ->Double) {
        if operandStack.count >= 2 {
        displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func performSqrt(operation: Double -> Double) {
        if operandStack.count >= 1 {
        displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func performCelcius(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func performFarenheit(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }

    }
    func performKph(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    func performMph(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }

    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }

    var displayValue: Double {
        get {
           return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            
          display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
            
        }
    }
}

