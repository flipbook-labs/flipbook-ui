local pkg = script.Parent
local lib = pkg.Parent

local Sift = require(lib.Parent.Sift)

local createReducer = require(lib.utils.createReducer)
local types = require(pkg.types)

local REGISTER_OPTION = "registeredOptions/register-option"
local UNREGISTER_OPTION = "registeredOptions/unregister-option"

type Array<T> = { [number]: T }
type RegisterOption = { type: typeof(REGISTER_OPTION), option: types.Option }
type UnregisterOption = { type: typeof(UNREGISTER_OPTION), id: string }

export type State = { options: Array<types.Option> }

return {
	reducer = createReducer({ options = {} }, {
		[REGISTER_OPTION] = function(state: State, action: RegisterOption): State
			return Sift.Dictionary.merge(state, {
				options = Sift.Array.push(state.options, action.option),
			})
		end,

		[UNREGISTER_OPTION] = function(state: State, action: UnregisterOption): State
			local index = Sift.Array.findWhere(state.options, function(option)
				return option.id == action.id
			end)

			return Sift.Dictionary.merge(state, {
				options = Sift.Array.removeIndex(state.options, index),
			})
		end,
	}),

	registerOption = function(option: types.Option): RegisterOption
		return {
			type = REGISTER_OPTION,
			option = option,
		}
	end,

	unregisterOption = function(id: string): UnregisterOption
		return {
			type = UNREGISTER_OPTION,
			id = id,
		}
	end,
}
