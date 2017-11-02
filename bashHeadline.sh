# @description Writes the given text within a '#' delimited headline
#
# The function will do its best to fill the whole of the terminal's
# current horizontal space and try to centre the given text in the middle.
# If using text that is wider than the terminal, headline formatting will 
# break.
#
# @example
#   headline THIS IS A HEADLINE
#   headline "THIS IS A HEADLINE"
#
# @arg $@ Text to write in the headline
#
function headline() {
    local TEXT="$(printf '%s ' "$@")"
    local COLS=$(tput cols)
    local PADDING=$(printf '%0.s ' $(seq 1 $COLS))

    local BLANK_SPACING=$((COLS - 2 - ${#TEXT}))

    local PREFIX_SPACING=$((BLANK_SPACING / 2))
    local SUFFIX_SPACING=${PREFIX_SPACING}

    if [[ "$((PREFIX_SPACING * 2))" -ne "${BLANK_SPACING}" ]]
    then
        SUFFIX_SPACING=$((SUFFIX_SPACING + 1))
    fi

    #Write starting sequence of #
    printf "%0.s#" $(seq 1 $COLS)
    printf '\n'

    #Write headline text section
    printf '#'
    printf "%*.*s" 0 ${PREFIX_SPACING} "$PADDING"
    printf "%s" "${TEXT}"
    printf "%*.*s" 0 ${SUFFIX_SPACING} "$PADDING"
    printf '#'
    printf '\n'

    #Write ending sequence of #
    printf "%0.s#" $(seq 1 $COLS)
    printf '\n'
}
