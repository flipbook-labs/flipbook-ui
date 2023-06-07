local pkg = script.Parent.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local RadioGroupActionsContext = require(pkg.context.RadioGroupActionsContext)

local function useActions<T>(component: string): RadioGroupActionsContext.RadioGroupActions<T>
	local context = React.useContext(RadioGroupActionsContext)
	if context == nil then
		error(`<{component} /> must be used within a <RadioGroup /> component.`)
	end

	return context
end

return useActions
