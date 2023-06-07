_G.__DEV__ = true

local pkg = script.Parent
local lib = pkg.Parent

local ReactRoblox = require(lib.Parent.ReactRoblox)
local React = require(lib.Parent.React)
local ReactSpring = require(lib.Parent.ReactSpring)

local Component = require(script.Parent)
local RadioGroup = Component.RadioGroup
local Option = Component.Option

local StyledOption: React.FC<Component.OptionRenderProps> = function(props)
	local hovered, setHovered = React.useState(false)
	local styles = ReactSpring.useSpring({
		alpha = if props.checked == true then 0 else 1,
		color = if props.checked == false then Color3.fromHex("E0E0E0") else Color3.fromHex("187DDC"),
		config = { frequency = 0.15 },
		hoverTransparency = if hovered == true then 0.92 else 1,
	}, { props.checked, hovered })

	return React.createElement("TextButton", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(24, 24),
		Text = "",
		[React.Event.Activated] = props.onClick,
		[React.Event.MouseEnter] = function()
			setHovered(true)
		end,
		[React.Event.MouseLeave] = function()
			setHovered(false)
		end,
	}, {
		Hover = React.createElement("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = styles.color,
			BackgroundTransparency = styles.hoverTransparency,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(42, 42),
		}, {
			UICorner = React.createElement("UICorner", {
				CornerRadius = UDim.new(0.5, 0),
			}),
		}),

		Option = React.createElement("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(20, 20),
		}, {
			UICorner = React.createElement("UICorner", {
				CornerRadius = UDim.new(0.5, 0),
			}),

			UIStroke = React.createElement("UIStroke", {
				Color = styles.color,
				Thickness = 2,
			}),
		}),

		Fill = React.createElement("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = styles.color,
			BackgroundTransparency = styles.alpha,
			Position = UDim2.fromScale(0.5, 0.5),
			Size = styles.alpha:map(function(value)
				return UDim2.fromOffset(12, 12):Lerp(UDim2.fromOffset(0, 0), value)
			end),
		}, {
			UICorner = React.createElement("UICorner", {
				CornerRadius = UDim.new(0.5, 0),
			}),
		}),
	})
end

local function Story()
	return React.createElement(React.Fragment, nil, {
		UIListLayout = React.createElement("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0, 16),
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),

		RadioGroup = React.createElement(RadioGroup, {
			onChange = print,
			compare = function(a, b)
				return a.kind == b.kind
			end,
		}, {
			Option1 = React.createElement(Option, {
				disabled = false,
				render = StyledOption,
				value = { kind = "foo" },
			}),

			Option2 = React.createElement(Option, {
				disabled = false,
				render = StyledOption,
				value = { kind = "bar" },
			}),

			-- Option3 = React.createElement(Option, {
			-- 	disabled = false,
			-- 	render = StyledOption,
			-- 	value = "baz",
			-- }),

			-- Option4 = React.createElement(Option, {
			-- 	disabled = false,
			-- 	render = StyledOption,
			-- 	value = "boo",
			-- }),
		}),
	})
end

return function(t: GuiObject)
	local root = ReactRoblox.createRoot(t)
	root:render(React.createElement(Story))

	return function()
		root:unmount()
	end
end
