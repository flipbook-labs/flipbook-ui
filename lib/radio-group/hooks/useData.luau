local pkg = script.Parent.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local RadioGroupDataContext = require(pkg.context.RadioGroupDataContext)

local function useData<T>(component: string): RadioGroupDataContext.RadioGroupData<T>
	local context = React.useContext(RadioGroupDataContext)
	if context == nil then
		error(`<{component} /> must be used within a <RadioGroup /> component.`)
	end

	return context
end

return useData
