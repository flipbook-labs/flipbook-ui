local currentId = 0

local function getNextId(): number
	currentId += 1
	return currentId
end

return getNextId
