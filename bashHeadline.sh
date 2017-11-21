# @description Writes the given text within a '#' delimited headline
#
# The function will do its best to centre the generated headline, with the
# text being formatted to central alignment to the best possible effort.
#
# @example
#   headline THIS IS A HEADLINE
#   headline "THIS IS A HEADLINE"
#
# @arg $@ Text to write in the headline
#
function headline() {

    function writeHeadlineLine() {
        local LINE=$1
        local MAX_WRITABLE_WIDTH=$2

        if [[ ${#LINE} -eq ${MAX_WRITABLE_WIDTH} ]]
        then
            printf "# %s #\n" "$LINE"
        else
            local BLANK_SPACING=$((MAX_WRITABLE_WIDTH - ${#LINE}))
            local PREFIX_SPACING=$((BLANK_SPACING / 2))
            local SUFFIX_SPACING=${PREFIX_SPACING}
            if [[ "$((PREFIX_SPACING * 2))" -ne "${BLANK_SPACING}" ]]
            then
                SUFFIX_SPACING=$((SUFFIX_SPACING + 1))
            fi

            printf "#"
            printf "%*.*s" 0 ${PREFIX_SPACING} "$PADDING"
            printf "%s" "${LINE}"
            printf "%*.*s" 0 ${SUFFIX_SPACING} "$PADDING"
            printf "#"
            printf "\n"
        fi
    }

    local TEXT="$(printf '%s' "$*")"
    local COLS=$(tput cols)
    local PADDING=$(printf '%0.s ' $(seq 1 $COLS))
    local MAX_WRITABLE_WIDTH=$((COLS - 2))
    local MAX_TEXT_WIDTH=$((MAX_WRITABLE_WIDTH - 2))

    #Write starting sequence of #
    printf "%0.s#" $(seq 1 $COLS)
    printf "\n"

    #Write headline text section
    local CURRENT_PHRASE=""
    WORD_SEPARATOR=""
    for val in ${TEXT}
    do
        if [[ ${#val} -gt ${MAX_TEXT_WIDTH} ]]
        then
            if [[ ${#CURRENT_PHRASE} -gt 0 ]]
            then
                writeHeadlineLine "${CURRENT_PHRASE}" ${MAX_WRITABLE_WIDTH}
                CURRENT_PHRASE=""
                WORD_SEPARATOR=" "
            fi

            for sval in $(echo $val | sed -r "s/(.{${MAX_TEXT_WIDTH}})/\1 /g")
            do
                if [[ ${#sval} -eq ${MAX_TEXT_WIDTH} ]]
                then
                    writeHeadlineLine "${sval}" ${MAX_WRITABLE_WIDTH}
                else
                    CURRENT_PHRASE="${CURRENT_PHRASE}${WORD_SEPARATOR}${sval}"
                    WORD_SEPARATOR=" "
                fi
            done
        else
            if [[ $((${#CURRENT_PHRASE} + ${#WORD_SEPARATOR} + ${#val})) -gt ${MAX_TEXT_WIDTH} ]]
            then
                writeHeadlineLine "${CURRENT_PHRASE}" ${MAX_WRITABLE_WIDTH}
                CURRENT_PHRASE=""
                WORD_SEPARATOR=" "
            fi
            CURRENT_PHRASE="${CURRENT_PHRASE}${WORD_SEPARATOR}${val}"
            WORD_SEPARATOR=" "
        fi
    done

    if [[ ${#TEXT} -eq 0 || ${#CURRENT_PHRASE} -gt 0 ]]
    then
        writeHeadlineLine "${CURRENT_PHRASE}" ${MAX_WRITABLE_WIDTH}
    fi

    #Write ending sequence of #
    printf "%0.s#" $(seq 1 $COLS)
    printf "\n"

    unset -f writeHeadlineLine
}