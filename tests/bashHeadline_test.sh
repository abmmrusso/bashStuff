#!/usr/bin/env bash

. $(dirname "${BASH_SOURCE[0]}")/../bashHeadline.sh

oneTimeSetUp() {
	original_width=$(tput cols)
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

testHeadlineWithEvenWidthTextWithMultipleWordsOnEvenWidthTerminal() {
	stty cols 10
	local headline_output="$(headline yes no; echo x)"
	local expected_output="$(printf '##########\n# yes no #\n##########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testHeadlineWithOddWidthTextWithMultipleWordsOnEvenWidthTerminal() {
	stty cols 10
	local headline_output="$(headline no no; echo x)"
	local expected_output="$(printf '##########\n# no no  #\n##########\n' ; echo x)"
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

testHeadlineWithEvenWidthTextWithMultipleWordsOnOddWidthTerminal() {
	stty cols 11
	local headline_output="$(headline yes no; echo x)"
	local expected_output="$(printf '###########\n# yes no  #\n###########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testHeadlineWithOddWidthTextWithMultipleWordsOnOddWidthTerminal() {
	stty cols 11
	local headline_output="$(headline no no; echo x)"
	local expected_output="$(printf '###########\n#  no no  #\n###########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testHeadlineWithTextWiderThanTerminalExpectingFittedMultilineOutput() {
	stty cols 10
	local headline_output="$(headline '123456123456'; echo x)"
	local expected_output="$(printf '##########\n# 123456 #\n# 123456 #\n##########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testHeadlineWithTextWiderThanTerminalExpectingMultilineOutput() {
	stty cols 10
	local headline_output="$(headline '1234561234'; echo x)"
	local expected_output="$(printf '##########\n# 123456 #\n#  1234  #\n##########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testHeadlineWithTwoWordsWiderThanTerminalExpectingMultilineOutput() {
	stty cols 10
	local headline_output="$(headline '1234561234 1234561234'; echo x)"
	local expected_output="$(printf '##########\n# 123456 #\n#  1234  #\n# 123456 #\n#  1234  #\n##########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testMultilineHeadlineTextWithPhrase() {
	stty cols 10
	local headline_output="$(headline 'This is a test phrase'; echo x)"
	local expected_output="$(printf '##########\n#  This  #\n#  is a  #\n#  test  #\n# phrase #\n##########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

testBannerAliasFunctionWorks() {
	stty cols 10
	local headline_output="$(banner even; echo x)"
	local expected_output="$(printf '##########\n#  even  #\n##########\n' ; echo x)"
	assertEquals "${expected_output%x}" "${headline_output%x}"
}

. /usr/bin/shunit2
