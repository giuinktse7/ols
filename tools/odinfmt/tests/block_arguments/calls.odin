package odinfmt_test

main :: proc() {
	ui_box_begin(runtime, "typing sample", {
		width = grow(),
		height = fixed(48),
	}, {
		flags = {.Pointer_Input,.Text_Focusable,.Blocks_World_Input},
		cursor = .Text,
	})

	build(prefix, {width = 100}, callback, timeout, allocator)
	build(prefix, {first = aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa, second = bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb}, callback)

	build(prefix, {
		width = 100,
	}, callback, timeout, allocator)

	append(&items, Item {
		name = "example",
		value = 42,
	})

	configure(prefix, layout = {
		width = 100,
	}, callback)

	slice.sort_by(items, proc(a, b: Item) -> bool {
		return a.id < b.id
	})
}
