local pkg = script.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local function useLatestValue<T>(value: T)
	local cache = React.useRef(value)

	React.useLayoutEffect(function()
		cache.current = value
	end, { value })

	return cache
end

return useLatestValue
