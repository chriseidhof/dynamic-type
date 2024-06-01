import SwiftUI

extension DynamicType.DynamicTypeSize {
    fileprivate var value: Double {
        get {
            Double(DynamicTypeSize.allCases.firstIndex(of: self)!)
        }
        set {
            self = DynamicTypeSize.allCases[.init(newValue)]
        }
    }
}

@available(macOS 12.0, *)
public struct DynamicTypeSlider: View {
    @Binding var dynamicTypeSize: DynamicTypeSize

    public init(dynamicTypeSize: Binding<DynamicTypeSize>) {
        self._dynamicTypeSize = dynamicTypeSize
    }

    public var body: some View {
        let steps = DynamicTypeSize.allCases.count
        Slider(value: $dynamicTypeSize.value, in: 0...Double(steps-1), step: 1) {
            Image(systemName: "textformat.size")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: 300)
    }
}
