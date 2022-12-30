import SwiftUI
import Injection

@propertyWrapper
public struct NavigationState<Value>: DynamicProperty {

    @Shared private var path: Value

    public var wrappedValue: Value {
        get { path }
        nonmutating set { path = newValue }
    }

    public var projectedValue: Binding<Value> {
        .init(get: { wrappedValue }, set: { wrappedValue = $0 })
    }

    public init(wrappedValue: Value, _ key: String? = nil) where Value == NavigationPath {
        self._path = .init(wrappedValue: wrappedValue, key)
    }

    public init(_ key: String? = nil) where Value == NavigationPath {
        self.init(wrappedValue: NavigationPath(), key)
    }

    public init(wrappedValue: Value, _ key: String? = nil) where Value : MutableCollection, Value : RandomAccessCollection, Value : RangeReplaceableCollection, Value.Element : Hashable { //, Value: ExpressibleByArrayLiteral, Value.ArrayLiteralElement: Hashable {
        self._path = .init(wrappedValue: wrappedValue, key)
    }

}
