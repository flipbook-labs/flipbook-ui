export type Option<T = unknown> = {
	id: string,
	props: {
		current: {
			disabled: boolean,
			value: T,
		},
	},
}

return nil
