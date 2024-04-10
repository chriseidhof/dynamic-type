//

import Foundation
import SwiftUI

struct DynamicTypeKey: EnvironmentKey {
    static var defaultValue: DynamicTypeSize = .large
}

extension EnvironmentValues {
    public var myDynamicTypeSize: DynamicTypeSize {
        get { self[DynamicTypeKey.self] }
        set { self[DynamicTypeKey.self] = newValue }
    }
}

extension Weight {
    var weight: Font.Weight {
        switch self {
        case .regular:
            .regular
        case .semibold:
            .semibold
        case .bold:
            .bold
        }
    }
}

struct MyFontModifier: ViewModifier {
    var font: DynamicTypeStyle
    @Environment(\.myDynamicTypeSize) private var dynamicTypeSize
    func body(content: Content) -> some View {
        let metrics = font.resolve(for: dynamicTypeSize)
        content
            .font(.system(size: metrics.size, weight: metrics.weight.weight))
    }
}

extension View {
    public func myFont(_ font: DynamicTypeStyle) -> some View {
        modifier(MyFontModifier(font: font))
    }

    public func dynamicTypeSize(size: DynamicTypeSize = .large) -> some View {
        environment(\.myDynamicTypeSize, size)
    }
}

@propertyWrapper public struct MyScaledMetric<Value> : DynamicProperty where Value : BinaryFloatingPoint {
    @Environment(\.myDynamicTypeSize) private var size
    var source: Value
    var textStyle: DynamicTypeStyle = .body

    public init(wrappedValue: Value, relativeTo textStyle: DynamicTypeStyle) {
        self.source = wrappedValue
        self.textStyle = textStyle
    }

    /// Creates the scaled metric with an unscaled value using the default
    /// scaling.
    public init(wrappedValue: Value) {
        self.source = wrappedValue
    }

    /// The value scaled based on the current environment.
    public var wrappedValue: Value {
        let multiplier = textStyle.resolve(for: size).size / textStyle.resolve(for: .large).size
        return source * .init(multiplier)
    }
}
