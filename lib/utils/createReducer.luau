-- https://github.com/Roblox/rodux/blob/master/src/createReducer.lua
return function(initialState, handlers)
	return function(state: any, action)
		if state == nil then
			state = initialState
		end

		local handler = handlers[action.type]

		if handler then
			return handler(state, action)
		end

		return state
	end
end
