local pkg = script.Parent
local lib = pkg.Parent

local React = require(lib.Parent.React)

local useLatestValue = require(pkg.useLatestValue)

local function useEvent(cb)
	local cache = useLatestValue(cb)

	return React.useCallback(function(...)
		return cache.current(...)
	end, { cache })
end

return useEvent
