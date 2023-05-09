local lib = script.Parent.Parent
local Packages = lib.Parent

local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)

local useControllableState = require(script.Parent.useControllableState)

local function useControllableStateStory()
	local value, setValue = React.useState(40)
	local internalValue, setInternalValue = useControllableState({
		value = value,
		onChange = setValue,
	})

	return React.createElement("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = Color3.fromHex("FFFFFF"),
		Position = UDim2.fromScale(0.5, 0.5),
	}, {
		UICorner = React.createElement("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),

		UIListLayout = React.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 24),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),

		UIPadding = React.createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 32),
			PaddingLeft = UDim.new(0, 32),
			PaddingRight = UDim.new(0, 32),
			PaddingTop = UDim.new(0, 32),
		}),

		Increment = React.createElement("TextButton", {
			BackgroundColor3 = Color3.fromHex("EDF2F7"),
			FontFace = Font.fromName("Ubuntu", Enum.FontWeight.Medium),
			LayoutOrder = 1,
			LineHeight = 1.15,
			Size = UDim2.fromOffset(42, 42),
			Text = "+",
			TextColor3 = Color3.fromHex("2D3748"),
			TextSize = 20,
			[React.Event.Activated] = function()
				setInternalValue(value + 1)
			end,
		}, {
			UICorner = React.createElement("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		}),

		Value = React.createElement("TextLabel", {
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			FontFace = Font.fromName("Ubuntu", Enum.FontWeight.Light),
			LayoutOrder = 2,
			Text = internalValue,
			TextColor3 = Color3.fromHex("2D3748"),
			TextSize = 20,
		}),

		Decrement = React.createElement("TextButton", {
			BackgroundColor3 = Color3.fromHex("EDF2F7"),
			FontFace = Font.fromName("Ubuntu", Enum.FontWeight.Medium),
			LayoutOrder = 3,
			LineHeight = 1.15,
			Size = UDim2.fromOffset(42, 42),
			Text = "-",
			TextColor3 = Color3.fromHex("2D3748"),
			TextSize = 20,
			[React.Event.Activated] = function()
				setInternalValue(value - 1)
			end,
		}, {
			UICorner = React.createElement("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
		}),
	})
end

return function(t: GuiObject)
	local root = ReactRoblox.createRoot(t)
	root:render(React.createElement(useControllableStateStory))

	return function()
		root:unmount()
	end
end
