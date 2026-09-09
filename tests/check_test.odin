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
