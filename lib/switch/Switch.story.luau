local pkg = script.Parent
local lib = pkg.Parent

local ReactRoblox = require(lib.Parent.ReactRoblox)
local React = require(lib.Parent.React)
local ReactSpring = require(lib.Parent.ReactSpring)

local Switch = require(script.Parent)

local StyledSwitch: React.FC<Switch.SwitchRenderProps> = function(props)
	local hovered, setHovered = React.useState(false)
	local styles = ReactSpring.useSpring({
		anchor = if props.checked == false then Vector2.new(0, 0.5) else Vector2.new(1, 0.5),
		backgroundColor = if props.checked == false then Color3.fromHex("606974") else Color3.fromHex("187DDC"),
		config = { frequency = 0.15 },
		position = if props.checked == false then UDim2.fromScale(0, 0.5) else UDim2.fromScale(1, 0.5),
		thumbColor = if props.checked == false then Color3.fromHex("E0E0E0") else Color3.fromHex("FFFFFF"),
		thumbHoverTransparency = if hovered == true then 0.92 else 1,
	}, { props.checked, hovered })

	return React.createElement("TextButton", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		AutoButtonColor = false,
		BackgroundColor3 = styles.backgroundColor,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(52, 32),
		Text = "",
		[React.Event.Activated] = props.toggleChecked,
		[React.Event.MouseEnter] = function()
			setHovered(true)
		end,
		[React.Event.MouseLeave] = function()
			setHovered(false)
		end,
	}, {
		UICorner = React.createElement("UICorner", {
			CornerRadius = UDim.new(0.5, 0),
		}),

		UIPadding = React.createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 4),
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
			PaddingTop = UDim.new(0, 4),
		}),

		Thumb = React.createElement("Frame", {
			AnchorPoint = styles.anchor,
			BackgroundTransparency = 1,
			Position = styles.position,
			Size = UDim2.fromOffset(24, 24),
		}, {
			Hover = React.createElement("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(40, 40),
				BackgroundColor3 = styles.thumbColor,
				BackgroundTransparency = styles.thumbHoverTransparency,
			}, {
				UICorner = React.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),

			Thumb = React.createElement("Frame", {
				BackgroundColor3 = styles.thumbColor,
				Size = UDim2.fromScale(1, 1),
			}, {
				UICorner = React.createElement("UICorner", {
					CornerRadius = UDim.new(0.5, 0),
				}),
			}),
		}),
	})
end

return function(t: GuiObject)
	local root = ReactRoblox.createRoot(t)
	root:render(React.createElement(Switch, {
		onCheckedChange = print,
		render = StyledSwitch,
	}))

	return function()
		root:unmount()
	end
end
