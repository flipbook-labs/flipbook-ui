local lib = script.Parent.Parent
local Packages = lib.Parent

local React = require(Packages.React)

local useCallbackRef = require(script.Parent.useCallbackRef)

export type UseControllableStateProps<T> = {
	defaultValue: T | (() -> T)?,
	onChange: (value: T) -> (),
	shouldUpdate: nil | (prev: T, next: T) -> boolean,
	value: T?,
}

local function useControllableState<T>(props: UseControllableStateProps<T>)
	local valueProp = props.value
	local defaultValueProp = props.defaultValue
	local onChangeProp = props.onChange
	local shouldUpdateProp = props.shouldUpdate

	local onChangeRef = useCallbackRef(onChangeProp)
	local shouldUpdateRef = useCallbackRef(shouldUpdateProp)

	local uncontrolledState, setUncontrolledState = React.useState(defaultValueProp)
	local controlled = valueProp ~= nil
	local value = if controlled == true then valueProp else uncontrolledState

	local setValue = useCallbackRef(function(next)
		local setter = next
		local nextValue = if typeof(next) == "function" then setter(value) else next

		if shouldUpdateProp ~= nil and shouldUpdateRef(value, nextValue) == false then
			return
		end

		if controlled == false then
			setUncontrolledState(nextValue)
		end

		onChangeRef(nextValue)
	end, { controlled, onChangeRef, value, shouldUpdateRef })

	return value, setValue
end

return useControllableState
