local pkg = script.Parent.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)
local types = require(pkg.types)

type Array<T> = { [number]: T }
export type RadioGroupData<T = unknown> = {
	compare: (a: T, b: T) -> boolean,
	disabled: boolean,
	options: Array<types.Option<T>>,
	value: T,
}

return React.createContext(nil)
