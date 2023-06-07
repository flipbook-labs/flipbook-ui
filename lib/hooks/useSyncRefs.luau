local lib = script.Parent.Parent
local Packages = lib.Parent

local React = require(Packages.React)

local useCallbackRef = require(script.Parent.useCallbackRef)

local function useSyncRefs(...)
	local refs = table.pack(...)
	local cache = React.useRef(refs)

	React.useEffect(function()
		cache.current = refs
	end, refs)

	local syncRefs = useCallbackRef(function(value)
		for _, ref in cache.current do
			if type(ref) == "function" then
				ref(value)
			else
				ref.current = value
			end
		end
	end)

	return syncRefs
end

return useSyncRefs
