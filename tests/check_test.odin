package tests

import "core:testing"

import "src:common"
import "src:server"

@(test)
checker_detects_test_file_tag :: proc(t: ^testing.T) {
	Case :: struct {
		source:   string,
		expected: bool,
	}
	
	cases := []Case {
		{source = "#+test\npackage example", expected = true},
		{source = "#+test // test configuration\npackage example", expected = true},
		{source = "#+build linux\n#+test\npackage example", expected = true},
		{source = "  #+test  \r\npackage example", expected = true},
		{source = "package example\n#+test", expected = false},
		{source = "// #+test\npackage example", expected = false},
	}

	for test_case in cases {
		testing.expect_value(t, server.source_has_test_tag(test_case.source), test_case.expected)
	}
}

@(test)
checker_adds_test_build_mode_to_test_targets :: proc(t: ^testing.T) {
	config := common.Config{odin_command = "custom-odin"}

	normal_cmd := server.build_check_command("example", {}, &config, false)
	test_cmd := server.build_check_command("example", {}, &config, true)

	normal_has_test_mode := false
	for arg in normal_cmd {
		normal_has_test_mode = normal_has_test_mode || arg == "-build-mode:test"
	}

	test_has_test_mode := false
	for arg in test_cmd {
		test_has_test_mode = test_has_test_mode || arg == "-build-mode:test"
	}

	testing.expect_value(t, normal_has_test_mode, false)
	testing.expect_value(t, test_has_test_mode, true)
}

@(test)
checker_test_mode_preserves_workspace_and_overlay :: proc(t: ^testing.T) {
	config := common.Config {
		odin_command = "custom-odin",
		checker_args = "-vet",
	}
	paths := []string{"first", "second"}
	cmd := server.build_check_command(
		paths[0],
		{"-collection:example=example"},
		&config,
		true,
		check_paths = paths,
		overlay = "overlay.json",
		semantics = "semantics.cbor",
	)

	testing.expect_value(t, cmd[0], "custom-odin")
	testing.expect_value(t, cmd[1], "check")
	testing.expect_value(t, cmd[2], "first")
	testing.expect_value(t, cmd[3], "second")
	for expected in ([]string{
		"-collection:example=example",
		"-no-entry-point",
		"-json-errors",
		"-workspace",
		"-overlay:overlay.json",
		"-export-semantics:cbor",
		"-export-semantics-file:semantics.cbor",
		"-build-mode:test",
		"-vet",
	}) {
		found := false
		for arg in cmd {
			found ||= arg == expected
		}
		testing.expectf(t, found, "Missing checker argument %q", expected)
	}
}
