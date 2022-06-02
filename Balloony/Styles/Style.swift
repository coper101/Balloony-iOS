//
//  Style.swift
//  Balloony
//
//  Created by Wind Versi on 25/5/22.
//

import SwiftUI

// MARK: - Color
enum Colors: String {
    case background = "Blue"
    case background2 = "Light Blue"
    case combination1a = "Blue Party Parrot"
    case combination1b = "Gulabi Pink"
    case combination2a = "Exquisite Turquoise"
    case combination2b = "Gentian Flower"
    case combination3a = "Glistening Dawn"
    case combination3b = "Orange Gluttony"
    case combination4a = "Calabrese"
    case combination4b = "Dandelion Whisper"
    case combination5a = "Byzantine Night Blue"
    case combination5b = "Girl Power"
    case primary = "White"
    case secondary = "Yellow"
    var color: Color {
        Color(self.rawValue)
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct BlurModifier: ViewModifier {
    
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .background(
                color
                    .opacity(0.1)
                    .scaleEffect(1.5)
                    .blur(radius: 50)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(
                        color.opacity(0.03),
                        lineWidth: 0.5
                    )
            )
    }
}

extension View {
    
    func backgroundBlur(color: Colors = .primary) -> some View {
        self.modifier(BlurModifier(color: color.color))
    }
    
}

// MARK: - Icons
enum Icons: String {
    case menu = "Menu"
    case search = "Search"
    case spaceship = "Spaceship"
    case string = "String"
    case thunderbolt = "Thunderbolt"
    case plus = "Plus"
    case minus = "Minus"
    case pointer = "Pointer"
    case star = "Star"
    case leftArrow = "Left Arrow"
    var image: Image {
        Image(self.rawValue)
    }
}

// MARK: - Text
enum Fonts: String {
    case quicksandMedium = "Quicksand-Medium"
    case quicksandSemiBold = "Quicksand-SemiBold"
    var value: String {
        self.rawValue
    }
}

struct CustomText: ViewModifier {
    var foregroundColor: Color
    var font: String
    var size: Int
    var maxWidth: CGFloat?
    var alignment: Alignment
    var lineLimit: Int?
    var lineSpacing: CGFloat

    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .font(
                Font.custom(
                    font,
                    size: CGFloat(size)
                )
            )
            .frame(
                maxWidth: maxWidth,
                alignment: alignment
            )
            .lineLimit(lineLimit)
            .lineSpacing(lineSpacing)
    }
}

extension View {
    
    /// Sets the style of the Text
    ///
    /// - Parameters:
    ///   - foregroundColor: The color of the text
    ///   - font: The custom font e.g. "Arial-Bold"
    ///   - size: The font size
    ///   - maxWidth: The text will fill all the available width of its parent
    ///   - alignment: The alignment of the text relative to its width
    ///   - linelimit: Limit the text per line. Overflowing text in single line will be truncated with ...
    ///   - lineSpacing: The space between lines of text
    ///
    /// - Returns: A Text View with new Style
    func textStyle(
        foregroundColor: Colors = .primary,
        font: Fonts = .quicksandMedium,
        size: Int = 12,
        maxWidth: CGFloat? = nil,
        alignment: Alignment = .leading,
        lineLimit: Int? = nil,
        lineSpacing: CGFloat = 0
    ) -> some View {
        self.modifier(
            CustomText(
                foregroundColor: foregroundColor.color,
                font: font.value,
                size: size,
                maxWidth: maxWidth,
                alignment: alignment,
                lineLimit: lineLimit,
                lineSpacing: lineSpacing
            )
        )
    }
    
}


// MARK: - Frame
struct FrameModifier: ViewModifier {
    var maxWidth: CGFloat?
    var maxHeight: CGFloat?
    var alignment: Alignment
    
    func body(content: Content) -> some View {
        content.frame(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            alignment: alignment
        )
    }
}

extension View {
    
    func fillMaxHeight(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: nil,
                maxHeight: .infinity,
                alignment: alignment
            )
        )
    }
    
    func fillMaxWidth(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: .infinity,
                maxHeight: nil,
                alignment: alignment
            )
        )
    }
    
    func fillMaxSize(
        alignment: Alignment = .center
    ) -> some View {
        modifier(
            FrameModifier(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: alignment
            )
        )
    }
    
    
}
