package single_line_switch_simple

helper :: proc() {}

classify :: proc(value: int) -> int {
	switch value {
	case 0: return 0
	case 1: break
	case 2: value = 20
	case 3: helper()
	case 4: local := 40
	case 5:
		if value > 0 {
			return value
		}
	}
	return value
}
