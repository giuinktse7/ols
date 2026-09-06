package closing_brace_on_own_line

main :: proc() {
	x := 1

	if x == 1 {
		x += 1}

	if x == 2 {
		x += 1} else {
		x -= 1}

	for x < 10 {
		x += 1}

	switch x {
	case 10:
		x = 0}

	when ODIN_OS == .Windows {
		x = 1}

	defer {
		x = 0}

	if true {
		for {
			break}}

	if true {
		x += 1 /* comment */}

	if false {x = 0}

	if false {
	}

	if false {

	}

	x = 2}
