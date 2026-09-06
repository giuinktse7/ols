package align_single_line_switch

Kind :: enum {
	Fit,
	Grow,
	Very_Long_Name,
}

name :: proc(kind: Kind) -> string {
	switch kind {
	case .Fit:  return "fit"
	case .Grow: return "grow"
	case .Very_Long_Name:
		return(
				"a name that makes this line too wide to inline" \
			)
	case: return "unknown"
	}
}
