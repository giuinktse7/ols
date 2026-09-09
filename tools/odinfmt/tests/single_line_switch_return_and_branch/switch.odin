package single_line_switch_return_and_branch

classify :: proc(value: int) -> int {
	switch value {
	case 0:
		return 0
	case 1:
		break
	case 2:
		fallthrough
	case 3:
		x: = 30
	}
	return value
}
