local pkg = script.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local useCallbackRef = require(lib.hooks.useCallbackRef)
local useControllableState = require(lib.hooks.useControllableState)

export type SwitchRenderProps = {
	checked: boolean,
	disabled: boolean,
	toggleChecked: () -> ()?,
}

export type SwitchProps = {
	checked: boolean?,
	defaultChecked: boolean?,
	disabled: boolean?,
	onCheckedChange: (checked: boolean) -> (),
	render: (props: SwitchRenderProps) -> React.React_Node,
}

local Switch: React.FC<SwitchProps> = function(props)
	local internalValue, setInternalValue = useControllableState({
		defaultValue = props.defaultChecked or false,
		onChange = props.onCheckedChange,
		value = props.checked,
	})

	local toggleChecked = useCallbackRef(function()
		setInternalValue(function(previouslyChecked)
			return not previouslyChecked
		end)
	end, {})

	return React.createElement(props.render, {
		checked = internalValue,
		disabled = props.disabled,
		toggleChecked = if props.disabled ~= true then toggleChecked else nil,
	})
end

return Switch
