public enum DynamicTypeStyle: String, Hashable, CaseIterable, Codable {
    case largeTitle = "Large Title"
    case title1 = "Title 1"
    case title2 = "Title 2"
    case title3 = "Title 3"
    case headline = "Headline"
    case body = "Body"
    case callout = "Callout"
    case subhead = "Subhead"
    case footnote = "Footnote"
    case caption1 = "Caption 1"
    case caption2 = "Caption 2"
}

public enum DynamicTypeSize: String, Hashable, CaseIterable {
    case extraSmall = "Extra Small"
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
    case extraLarge = "Extra Large"
    case extraExtraLarge = "Extra Extra Large"
    case extraExtraExtraLarge = "Extra Extra Extra Large"
    case accessibilityMedium = "Accessibility Medium"
    case accessibilityLarge = "Accessibility Large"
    case accessibilityExtraLarge = "Accessibility Extra Large"
    case accessibilityExtraExtraLarge = "Accessibility Extra Extra Large"
    case accessibilityExtraExtraExtraLarge = "Accessibility Extra Extra Extra Large"
}

extension DynamicType.DynamicTypeSize {
    mutating public func smaller() {
        let i = Self.allCases.firstIndex(of: self)!
        guard i > 0 else { return }
        self = Self.allCases[i-1]
    }

    mutating public func larger() {
        let i = Self.allCases.firstIndex(of: self)!
        guard i + 1 < Self.allCases.count else { return }
        self = Self.allCases[i+1]
    }
}


extension DynamicTypeStyle {
    public func value(in instance: DynamicTypeInstance) -> SizeAndLeading {
        switch self {
        case .largeTitle:
            instance.largeTitle
        case .title1:
            instance.title1
        case .title2:
            instance.title2
        case .title3:
            instance.title3
        case .headline:
            instance.headline
        case .body:
            instance.body
        case .callout:
            instance.callout
        case .subhead:
            instance.subhead
        case .footnote:
            instance.footnote
        case .caption1:
            instance.caption1
        case .caption2:
            instance.caption2
        }
    }

    public func resolve(for style: DynamicTypeSize) -> SizeAndLeading {
        value(in: style.instance)
    }
}

public enum Weight: String, Hashable, CaseIterable, Codable {
    case regular = "Regular"
    case semibold = "Semibold"
    case bold = "Bold"
}

public struct SizeAndLeading: Hashable, Codable {
    public var weight: Weight
    public var size: Double
    public var leading: Double
}

public struct DynamicTypeInstance: Hashable, Codable {
    public var largeTitle: SizeAndLeading
    public var title1: SizeAndLeading
    public var title2: SizeAndLeading
    public var title3: SizeAndLeading
    public var headline: SizeAndLeading
    public var body: SizeAndLeading
    public var callout: SizeAndLeading
    public var subhead: SizeAndLeading
    public var footnote: SizeAndLeading
    public var caption1: SizeAndLeading
    public var caption2: SizeAndLeading
}


extension DynamicTypeSize {
    public var instance: DynamicTypeInstance {
        switch self {
        case .extraSmall:
            .extraSmall
        case .small:
            .small
        case .medium:
            .medium
        case .large:
            .large
        case .extraLarge:
            .extraLarge
        case .extraExtraLarge:
            .extraExtraLarge
        case .extraExtraExtraLarge:
            .extraExtraExtraLarge
        case .accessibilityMedium:
            .accessibilityMedium
        case .accessibilityLarge:
            .accessibilityLarge
        case .accessibilityExtraLarge:
            .accessibilityExtraLarge
        case .accessibilityExtraExtraLarge:
            .accessibilityExtraExtraLarge
        case .accessibilityExtraExtraExtraLarge:
            .accessibilityExtraExtraExtraLarge
        }
    }
}
