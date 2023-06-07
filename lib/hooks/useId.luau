local pkg = script.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local getNextId = require(lib.utils.getNextId)

local function useId(): number
	local id, setId = React.useState(getNextId())

	React.useLayoutEffect(function()
		if id == nil then
			setId(getNextId())
		end
	end, { id })

	return id
end

return useId
