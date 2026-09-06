package closing_brace_on_own_line

check :: proc(value: int) -> bool {
	if value < 0 {
		return false
	}
	if value == 0 { return false }
	return true
}
