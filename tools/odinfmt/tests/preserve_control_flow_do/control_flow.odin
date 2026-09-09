package preserve_control_flow_do

helper :: proc() {}

check :: proc(value: int) -> bool {
	if value < 0 do return false
	for value > 10 do break
	for _ in 0 ..< value do continue

	if value == 0 do value += 1
	if value == 1 do helper()
	if value == 2 do if value == 3 do return true
	switch value {
	case 3:
		if value == 3 do fallthrough
	case:
	}

	return true
}
