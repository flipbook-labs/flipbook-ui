export type ReactBinding<T> = {
	getValue: (self: ReactBinding<T>) -> any,
	map: <U>(self: ReactBinding<T>, (any) -> any) -> any,
}

export type OptionalBinding<T> = T | ReactBinding<T>

return nil
