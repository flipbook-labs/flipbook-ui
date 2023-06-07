local pkg = script.Parent.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)
local types = require(pkg.types)

export type RadioGroupActions<T = unknown> = {
	registerOption: (option: types.Option<T>) -> (() -> ()),
	triggerChange: (newValue: T) -> boolean,
}

return React.createContext(nil)
