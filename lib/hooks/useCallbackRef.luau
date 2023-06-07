local lib = script.Parent.Parent
local Packages = lib.Parent

local React = require(Packages.React)

local function useCallbackRef(callback, deps)
	local callbackRef = React.useRef(callback)

	React.useEffect(function()
		callbackRef.current = callback
	end)

	return React.useCallback(function(...)
		if callbackRef.current ~= nil then
			callbackRef.current(...)
		end
	end, deps)
end

return useCallbackRef
