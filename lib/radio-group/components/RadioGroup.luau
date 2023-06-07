local pkg = script.Parent.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local registeredOptions = require(pkg.registeredOptions)
local useControllableState = require(lib.hooks.useControllableState)
local useEvent = require(lib.hooks.useEvent)

local RadioGroupActionsContext = require(pkg.context.RadioGroupActionsContext)
local RadioGroupDataContext = require(pkg.context.RadioGroupDataContext)

export type RadioGroupProps<T = unknown> = {
	compare: (a: T, b: T) -> boolean?,
	defaultValue: T?,
	onChange: (newValue: T) -> (),
	value: T?,
}

local RadioGroup: React.FC<RadioGroupProps> = function(props)
	local state: registeredOptions.State, dispatch = React.useReducer(registeredOptions.reducer, { options = {} })
	local options = state.options

	local registerOption = useEvent(function(option)
		dispatch(registeredOptions.registerOption(option))

		return function()
			dispatch(registeredOptions.unregisterOption(option.id))
		end
	end)

	local internalValue, setInternalValue = useControllableState({
		defaultValue = props.defaultValue,
		onChange = props.onChange,
		value = props.value,
	})

	local compare = useEvent(function(a, b)
		if a == b and props.compare ~= nil then
			return props.compare(a, b)
		end

		return false
	end)

	local triggerChange = useEvent(function(newValue)
		if compare(newValue, internalValue) then
			return false
		end

		setInternalValue(newValue)

		return true
	end)

	return React.createElement(RadioGroupActionsContext.Provider, {
		value = {
			registerOption = registerOption,
			triggerChange = triggerChange,
		},
	}, {
		RadioGroupDataContext = React.createElement(RadioGroupDataContext.Provider, {
			value = {
				compare = compare,
				disabled = false,
				options = options,
				value = internalValue,
			},
		}, props.children),
	})
end

return RadioGroup
