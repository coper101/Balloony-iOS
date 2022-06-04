//
//  StepperQuantityView.swift
//  Balloony
//
//  Created by Wind Versi on 27/5/22.
//

import SwiftUI

enum Operation {
    case add
    case deduct
}

struct StepperButtonView: View {
    // MARK: - Properties
    var operation: Operation
    var action: () -> Void
    
    var icon: Icons {
        operation == .add ? .plus : .minus
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            
            ZStack {
                
                icon.image
                    .resizable()
                    .foregroundColor(Colors.background.color)

            }
            .frame(width: 30, height: 30)
            .background(Colors.primary.color)
            .clipShape(
                Circle()
            )
            
        } //: Button
    }
}


struct StepperQuantityView: View {
    // MARK: - Properties
    @Binding var quantity: String

    // MARK: - Body
    var body: some View {
        HStack(spacing: 11) {
            
            // Col 1: DEDUCT BUTTON
            StepperButtonView(
                operation: .deduct,
                action: didTapAdd
            )
            
            // Col 2: QUANTITY TEXT FIELD
            TextField("0", text: $quantity)
                .textFieldStyle(StepperTextFieldStyle())
            
            // Col 3: ADD BUTTON
            StepperButtonView(
                operation: .add,
                action: didTapDeduct
            )
            
        } //: HStack
    }
    
    // MARK: - Function
    func didTapDeduct() {
        guard let quantityInt = Int(quantity) else {
            return
        }
        quantity = "\(quantityInt + 1)"
    }
    
    func didTapAdd() {
        guard
            let quantityInt = Int(quantity),
                quantityInt > 0
        else {
            return
        }
        quantity = "\(quantityInt - 1)"
    }
}

// MARK: - Preview
struct StepperQuantityView_Previews: PreviewProvider {
    static var previews: some View {
        StepperQuantityView(quantity: .constant("1"))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Colors.background.color)
    }
}

// MARK: - Style
struct StepperTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textStyle(
                font: .quicksandSemiBold,
                size: 24
            )
            .frame(width: 30)
            .multilineTextAlignment(.center)
    }
}
