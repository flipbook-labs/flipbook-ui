local pkg = script.Parent.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local useId = require(lib.hooks.useId)
local useEvent = require(lib.hooks.useEvent)
local useLatestValue = require(lib.hooks.useLatestValue)
local useActions = require(pkg.hooks.useActions)
local useData = require(pkg.hooks.useData)

export type OptionRenderProps = {
	checked: boolean,
	disabled: boolean,
	onClick: () -> (),
}

export type OptionProps = {
	disabled: boolean?,
	value: any,
	render: (props: OptionRenderProps) -> React.React_Node,
}

local Option: React.FC<OptionProps> = function(props)
	local id = useId()
	local actions = useActions("RadioGroup.Option")
	local data = useData("RadioGroup.Option")

	local ref = useLatestValue({
		value = props.value,
		disabled = props.disabled,
	})

	local onClick = useEvent(function()
		actions.triggerChange(props.value)
	end)

	React.useLayoutEffect(function()
		return actions.registerOption({
			id = `flipbookui-radiogroup-option-{id}`,
			props = ref,
		})
	end, { id })

	return React.createElement(props.render, {
		checked = data.compare(data.value, props.value),
		disabled = props.disabled or data.disabled,
		onClick = onClick,
	})
end

return Option
