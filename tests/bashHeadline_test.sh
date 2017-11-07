#!/usr/bin/env shunit2

. $(dirname "${BASH_SOURCE[0]}")/../bashHeadline.sh

oneTimeSetUp() {
	original_width=$(tput cols)
	stty cols 10
}

oneTimeTearDown() {
	stty cols $original_width
}

testHeadlineWithEmptyText() {
	stty cols 10
	local headline_output="$(headline ; echo x)"
	local expected_output="$(printf '##########\n#        #\n##########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testHeadlineWithEvenWidthTextOnEvenWidthTerminal() {
	stty cols 10
	local headline_output="$(headline even; echo x)"
	local expected_output="$(printf '##########\n#  even  #\n##########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testHeadlineWithOddWidthTextOnEvenWidthTerminal() {
	stty cols 10
	local headline_output="$(headline odd; echo x)"
	local expected_output="$(printf '##########\n#  odd   #\n##########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testHeadlineWithEvenWidthTextOnOddWidthTerminal() {
	stty cols 9
	local headline_output="$(headline even; echo x)"
	local expected_output="$(printf '#########\n# even  #\n#########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testHeadlineWithOddWidthTextOnOddWidthTerminal() {
	stty cols 9
	local headline_output="$(headline odd; echo x)"
	local expected_output="$(printf '#########\n#  odd  #\n#########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}
