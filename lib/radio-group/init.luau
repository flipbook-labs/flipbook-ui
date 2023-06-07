local RadioGroup = require(script.components.RadioGroup)
local Option = require(script.components.Option)

export type RadioGroupProps<T> = RadioGroup.RadioGroupProps<T>
export type OptionProps = Option.OptionProps
export type OptionRenderProps = Option.OptionRenderProps

return {
	Option = Option,
	RadioGroup = RadioGroup,
}
