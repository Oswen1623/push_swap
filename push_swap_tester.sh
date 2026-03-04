#!/bin/bash

GREEN="\033[32m"
RED="\033[31m"
CYAN='\033[0;36m'
END="\033[0m"
NC="\033[0m"
YELLOW='\e[1;33m'
N=100
MYPATH=/home/lucinguy/cercle2/push_swap

print_histogram() {
    local title="$1"
    shift
    local values=("$@")
    local BUCKETS=20
    local BAR_WIDTH=40

    local h_min=${values[0]}
    local h_max=${values[0]}
    for v in "${values[@]}"; do
        (( v < h_min )) && h_min=$v
        (( v > h_max )) && h_max=$v
    done

    local range=$(( h_max - h_min + 1 ))
    local bucket_size=$(( (range + BUCKETS - 1) / BUCKETS ))
    (( bucket_size < 1 )) && bucket_size=1

    declare -A counts
    for v in "${values[@]}"; do
        local idx=$(( (v - h_min) / bucket_size ))
        counts[$idx]=$(( ${counts[$idx]:-0} + 1 ))
    done

    local max_count=0
    for idx in "${!counts[@]}"; do
        (( counts[$idx] > max_count )) && max_count=${counts[$idx]}
    done

    echo -e "${CYAN}"
    echo "  ╔══════════════════════════════════════════════════════════════╗"
    printf "  ║  %-60s║\n" "$title"
    echo "  ╚══════════════════════════════════════════════════════════════╝"
    echo -e "${END}"

    local num_buckets=$(( (range + bucket_size - 1) / bucket_size ))
    for (( b=0; b<num_buckets; b++ )); do
        local lo=$(( h_min + b * bucket_size ))
        local hi=$(( lo + bucket_size - 1 ))
        local count=${counts[$b]:-0}

        local bar_len=0
        (( max_count > 0 )) && bar_len=$(( count * BAR_WIDTH / max_count ))

        local color=$RED
        (( count > max_count / 3 ))     && color=$YELLOW
        (( count > max_count * 2 / 3 )) && color=$GREEN

        local bar=""
        for (( k=0; k<bar_len; k++ )); do bar+="█"; done
	local spaces=$(( BAR_WIDTH - bar_len ))
	local padding=""
	for (( k=0; k<spaces; k++ )); do padding+=" "; done
	printf "  %5d-%-5d │${color}%s${END}%s│ %d\n" "$lo" "$hi" "$bar" "$padding" "$count"
    done
    echo ""
}


WRONG_ARG="10 one 12"
DUP_ARG="10 42 46 -3 4 42"
SORTED_ARG="-1 0 3 4 5 6 7 8 9"
LT_INTMIN="4 2 3 -2147483649 42 41"
GT_INTMAX="4 2 3 -2147483647 2147483648 42 41"
EMPTY_ARG="10 \"\" -2"
bin_path=/usr/bin
uname -s | grep -qi darwin && os=mac && ls_path=/bin && cat_path=/bin
uname -s | grep -qi linux && os=linux && cat_path=/usr/bin && ls_path=/usr/bin

# print intro
echo -e "${CYAN}-----------------------------------------------"
echo -e "-----------------------------------------------"
echo -e "\t     PUSH_SWAP TESTER"
echo -e "Started at $(date +%R) - $(date +"%d %B %Y")"
echo -e "by $USER on $os os"
echo -e "made by ccauderl (and acohaut but nobody cares)"
echo -e "-----------------------------------------------"
echo -e "-----------------------------------------------${END}"

echo ""
echo -e "${YELLOW}<<<<< Norminette >>>>>${END}"
NORM=$(cd ${MYPATH} && norminette | grep Error)
if [ -z "$NORM" ];
then
	echo -e "${GREEN}Norm OK${END}"
else
	echo -e "${RED}Norm Error${END}"
	echo "$NORM"
fi
echo ""

echo -e "${YELLOW}<<<<< Makefile >>>>>${END}"
echo ""
cd ${MYPATH} && make all > /dev/null 2>&1 && echo -e "${GREEN}REGLE ALL OK${END}" || echo -e "${RED}PROBLEME REGLE ALL${END}"
cd ${MYPATH} && make clean > /dev/null 2>&1 && echo -e "${GREEN}REGLE CLEAN OK${END}" || echo -e "${RED}PROBLEME REGLE CLEAN${END}"
cd ${MYPATH} && make fclean > /dev/null 2>&1 && echo -e "${GREEN}REGLE FCLEAN OK${END}" || echo -e "${RED}PROBLEME REGLE FCLEAN${END}"
cd ${MYPATH} && make re > /dev/null 2>&1 && echo -e "${GREEN}REGLE RE OK${END}" || echo -e "${RED}PROBLEME REGLE RE${END}"
echo ""
echo ""

echo -e "${YELLOW}<<<<< WRONG ARGUMENTS >>>>>${NC}"
echo ""
CHECK=$(${MYPATH}/push_swap $WRONG_ARG 2>&1)
VAL_CHECK=$(valgrind ${MYPATH}/push_swap $WRONG_ARG 2>&1 | grep lost | grep -v " 0 bytes")
if [ "$CHECK" = "Error" ];
then
	echo -e "${GREEN}OK${END}"
else
	echo -e "${RED}KO${END}"
	echo -e "./push_swap $WRONG_ARG"
fi
if [ ! -z "$VAL_CHECK" ];
then
    echo -e "${RED}LEAK${END}"
    echo -e "valgrind ./push_swap $WRONG_ARG"
else
    echo -e "${GREEN}LEAK OK${END}"
fi
echo ""

echo -e "${YELLOW}<<<<< ALREADY SORTED >>>>>${NC}"
echo ""
CHECK=$(${MYPATH}/push_swap $SORTED_ARG 2>&1)
VAL_CHECK=$(valgrind ${MYPATH}/push_swap $SORTED_ARG 2>&1 | grep lost | grep -v " 0 bytes")
if [ -z "$CHECK" ];
then
        echo -e "${GREEN}OK${END}"
else
        echo -e "${RED}KO${END}"
        echo -e "./push_swap $SORTED_ARG"
fi
if [ ! -z "$VAL_CHECK" ];
then
    echo -e "${RED}LEAK${END}"
    echo -e "valgrind ./push_swap $SORTED_ARG"
else
    echo -e "${GREEN}LEAK OK${END}"
fi
echo ""

echo -e "${YELLOW}<<<<< LOWER THAN INT MIN >>>>>${NC}"
echo ""
CHECK=$(${MYPATH}/push_swap $LT_INTMIN 2>&1)
VAL_CHECK=$(valgrind ${MYPATH}/push_swap $LT_INTMIN 2>&1 | grep lost | grep -v " 0 bytes")
if [ "$CHECK" = "Error" ];
then
        echo -e "${GREEN}OK${END}"
else
        echo -e "${RED}KO${END}"
        echo -e "./push_swap $LT_INTMIN"
fi
if [ ! -z "$VAL_CHECK" ];
then
    echo -e "${RED}LEAK${END}"
    echo -e "valgrind ./push_swap $LT_INTMIN"
else
    echo -e "${GREEN}LEAK OK${END}"
fi
echo ""

echo -e "${YELLOW}<<<<< GREATER THAN INT MAX >>>>>${NC}"
echo ""
CHECK=$(${MYPATH}/push_swap $GT_INTMAX 2>&1)
VAL_CHECK=$(valgrind ${MYPATH}/push_swap $GT_INTMAX 2>&1 | grep lost | grep -v " 0 bytes")
if [ "$CHECK" = "Error" ];
then
        echo -e "${GREEN}OK${END}"
else
        echo -e "${RED}KO${END}"
        echo -e "./push_swap $GT_INTMAX"
fi
if [ ! -z "$VAL_CHECK" ];
then
    echo -e "${RED}LEAK${END}"
    echo -e "valgrind ./push_swap $GT_INTMAX"
else
    echo -e "${GREEN}LEAK OK${END}"
fi
echo ""

echo -e "${YELLOW}<<<<< DUPLICATE ARG >>>>>${NC}"
echo ""
CHECK=$(${MYPATH}/push_swap $DUP_ARG 2>&1)
VAL_CHECK=$(valgrind ${MYPATH}/push_swap $DUP_ARG 2>&1 | grep lost | grep -v " 0 bytes")
if [ "$CHECK" = "Error" ];
then
        echo -e "${GREEN}OK${END}"
else
        echo -e "${RED}KO${END}"
        echo -e "./push_swap $DUP_ARG"
fi
if [ ! -z "$VAL_CHECK" ];
then
    echo -e "${RED}LEAK${END}"
    echo -e "valgrind ./push_swap $DUP_ARG"
else
    echo -e "${GREEN}LEAK OK${END}"
fi
echo ""

echo -e "${YELLOW}<<<<< EMPTY ARG >>>>>${NC}"
echo ""
CHECK=$(${MYPATH}/push_swap 10 "" -2 2>&1)
VAL_CHECK=$(valgrind ${MYPATH}/push_swap 10 "" -2 2>&1 | grep lost | grep -v "0 bytes")
if [ "$CHECK" = "Error" ];
then
        echo -e "${GREEN}OK${END}"
else
        echo -e "${RED}KO${END}"
        echo -e "./push_swap $EMPTY_ARG"
fi
if [ ! -z "$VAL_CHECK" ];
then
    echo -e "${RED}LEAK${END}"
    echo -e "valgrind ./push_swap $EMPTY_ARG"
else
    echo -e "${GREEN}LEAK OK${END}"
fi
echo ""


MAX=0
MIN=99999
TEMP=0

echo ""
echo -e "${CYAN}-----------------------------------------------"
echo -e "-------------------3 Elements------------------"
echo -e "-----------------------------------------------${END}"
echo ""

VAL_NUM=0
for ((i = 0; i < 20; i++)); do
    ARG=$(shuf -i 0-2500 -n 3 | tr '\n' ' ')
    ARG="${ARG% }"
    VAL_CHECK=$(valgrind ${MYPATH}/push_swap $ARG 2>&1 | grep lost | grep -v " 0 bytes")
    RESULT=$(${MYPATH}/push_swap $ARG)
    if [ -z "$RESULT" ]; then
	    TEMP=0
	    TEMP2="OK"
    else
    	TEMP=$(echo "$RESULT" | wc -l)
    	TEMP2=$(echo "$RESULT" | ${MYPATH}/checker_linux $ARG)
    fi
    if [ "$TEMP" -gt "$MAX" ]; then
        MAX=$TEMP
    fi
    if [ "$TEMP" -lt "$MIN" ]; then
        MIN=$TEMP
    fi
    if [ "$TEMP2" = "KO" ]; then
	echo "KO: $ARG"
    fi
    if [ ! -z "$VAL_CHECK" ];
    then
	echo -e "${RED}LEAK${END}"
	echo -e "valgrind ./push_swap $ARG"
	(( VAL_NUM++ ))
    fi
done

if [ "$VAL_NUM" -gt 0 ]; then
	echo -e "${RED}LEAK KO${END}"
else
	echo -e "${GREEN}LEAK OK${END}"
fi

if [ "$MIN" -lt 5 ];
then
        echo -e "${GREEN}Minimum : $MIN${END}"
else
        echo -e "${RED}Minimum : $MIN${END}"
fi
if [ "$MAX" -lt 5 ];
then
        echo -e "${GREEN}Maximum : $MAX${END}"
else
        echo -e "${RED}Maximum : $MAX${END}"
fi
echo ""

MAX=0
MIN=99999
TEMP=0

echo ""
echo -e "${CYAN}-----------------------------------------------"
echo -e "-------------------4 Elements------------------"
echo -e "-----------------------------------------------${END}"
echo ""

VAL_NUM=0
for ((i = 0; i < 20; i++)); do
    ARG=$(shuf -i 0-2500 -n 4 | tr '\n' ' ')
    ARG="${ARG% }"
    VAL_CHECK=$(valgrind ${MYPATH}/push_swap $ARG 2>&1 | grep lost | grep -v " 0 bytes")
    RESULT=$(${MYPATH}/push_swap $ARG)
    if [ -z "$RESULT" ]; then
            TEMP=0
            TEMP2="OK"
    else
        TEMP=$(echo "$RESULT" | wc -l)
        TEMP2=$(echo "$RESULT" | ${MYPATH}/checker_linux $ARG)
    fi
    if [ "$TEMP" -gt "$MAX" ]; then
        MAX=$TEMP
    fi
    if [ "$TEMP" -lt "$MIN" ]; then
        MIN=$TEMP
    fi
    if [ "$TEMP2" = "KO" ]; then
        echo "KO: $ARG"
    fi
    if [ ! -z "$VAL_CHECK" ];
    then
        echo -e "${RED}LEAK${END}"
        echo -e "valgrind ./push_swap $ARG"
        (( VAL_NUM++ ))
    fi
done

if [ "$VAL_NUM" -gt 0 ]; then
        echo -e "${RED}LEAK KO${END}"
else
        echo -e "${GREEN}LEAK OK${END}"
fi
echo ""

MAX=0
MIN=99999
TEMP=0

echo ""
echo -e "${CYAN}-----------------------------------------------"
echo -e "-------------------5 Elements------------------"
echo -e "-----------------------------------------------${END}"
echo ""

VAL_NUM=0
for ((i = 0; i < 30; i++)); do
    ARG=$(shuf -i 0-2500 -n 5 | tr '\n' ' ')
    ARG="${ARG% }"
    VAL_CHECK=$(valgrind ${MYPATH}/push_swap $ARG 2>&1 | grep lost | grep -v " 0 bytes")
    RESULT=$(${MYPATH}/push_swap $ARG)
    if [ -z "$RESULT" ]; then
            TEMP=0
            TEMP2="OK"
    else
        TEMP=$(echo "$RESULT" | wc -l)
        TEMP2=$(echo "$RESULT" | ${MYPATH}/checker_linux $ARG)
    fi
    if [ "$TEMP" -gt "$MAX" ]; then
        MAX=$TEMP
    fi
    if [ "$TEMP" -lt "$MIN" ]; then
        MIN=$TEMP
    fi
    if [ "$TEMP2" = "KO" ]; then
	echo "KO: $ARG"
    fi
    if [ ! -z "$VAL_CHECK" ];
    then
	echo -e "${RED}LEAK${END}"
	echo -e "valgrind ./push_swap $ARG"
	(( VAL_NUM++ ))
    fi
done

if [ "$VAL_NUM" -gt 0 ]; then
	echo -e "${RED}LEAK KO${END}"
else
	echo -e "${GREEN}LEAK OK${END}"
fi

if [ "$MIN" -lt 12 ];
then
        echo -e "${GREEN}Minimum : $MIN${END}"
else
        echo -e "${RED}Minimum : $MIN${END}"
fi
if [ "$MAX" -lt 12 ];
then
        echo -e "${GREEN}Maximum : $MAX${END}"
else
        echo -e "${RED}Maximum : $MAX${END}"
fi

echo ""
echo ""
echo -e "${CYAN}-----------------------------------------------"
echo -e "------------------100 Elements-----------------"
echo -e "-----------------------------------------------${END}"
echo ""

MOY=0
MAX=0
MIN=99999
SUM_STD_DEV=0
ARRAY=()

for ((i = 0; i < N; i++)); do
    ARG=$(shuf -i 0-2500 -n 100 | tr '\n' ' ')
    ARG="${ARG% }"
    RESULT=$(${MYPATH}/push_swap $ARG)
    TEMP=$(echo "$RESULT" | wc -l)
    TEMP2=$(echo "$RESULT" | ${MYPATH}/checker_linux $ARG)
    ARRAY+=($TEMP)
    MOY=$((MOY + TEMP))
    if [ "$TEMP" -gt "$MAX" ]; then
        MAX=$TEMP
    fi
    if [ "$TEMP" -lt "$MIN" ]; then
        MIN=$TEMP
    fi
    if [ "$TEMP2" = "KO" ]; then
	echo "KO: $ARG"
    fi
done
MOY=$((MOY / N))
for el in "${ARRAY[@]}"; do
	SUM_STD_DEV=$(echo "$SUM_STD_DEV + ($el - $MOY)^2" | bc)
done
STD_DEV=$(echo "scale=2; sqrt($SUM_STD_DEV / $N)" | bc -l)
SORTED=($(printf "%s\n" "${ARRAY[@]}" | sort -n))
MEDIAN=${SORTED[$(( N / 2 ))]}

if [ "$MIN" -lt 700 ];
then
	echo -e "${GREEN}Minimum : $MIN${END}"
else
	echo -e "${RED}Minimum : $MIN${END}"
fi
if [ "$MAX" -lt 700 ];
then
	echo -e "${GREEN}Maximum : $MAX${END}"
else
	echo -e "${RED}Maximum : $MAX${END}"
fi
if [ "$MOY" -lt 700 ];
then
	echo -e "${GREEN}Average : $MOY${END}"
else
	echo -e "${RED}Average : $MOY${END}"
fi
if [ "$MEDIAN" -lt 700 ];
then
        echo -e "${GREEN}Median  : $MEDIAN${END}"
else
        echo -e "${RED}Median  : $MEDIAN${END}"
fi
echo ""

echo "Standard deviation : $STD_DEV"

print_histogram "Distribution — 100 elements ($N runs)" "${ARRAY[@]}"

echo "Over 700 : $(( $(printf '%s\n' "${ARRAY[@]}" | awk '$1 > 700' | wc -l) * 100 / N ))%"

echo ""
echo -e "${CYAN}-----------------------------------------------"
echo -e "------------------500 Elements-----------------"
echo -e "-----------------------------------------------${END}"
echo ""

MOY=0
MAX=0
MIN=99999
SUM_STD_DEV=0
ARRAY=()
for ((i = 0; i < N; i++)); do
    ARG=$(shuf -i 0-2500 -n 500 | tr '\n' ' ')
    ARG="${ARG% }"
    RESULT=$(${MYPATH}/push_swap $ARG)
    TEMP=$(echo "$RESULT" | wc -l)
    TEMP2=$(echo "$RESULT" | ${MYPATH}/checker_linux $ARG)
    MOY=$((MOY + TEMP))
    ARRAY+=($TEMP)
    if [ "$TEMP" -gt "$MAX" ]; then
        MAX=$TEMP
    fi
    if [ "$TEMP" -lt "$MIN" ]; then
        MIN=$TEMP
    fi
    if [ "$TEMP2" = "KO" ]; then
	echo "KO: $ARG"
    fi
done

MOY=$((MOY / N))
SORTED=($(printf "%s\n" "${ARRAY[@]}" | sort -n))
MEDIAN=${SORTED[$(( N / 2 ))]}

if [ "$MIN" -lt 5500 ];
then
        echo -e "${GREEN}Minimum : $MIN${END}"
else
        echo -e "${RED}Minimum : $MIN${END}"
fi
if [ "$MAX" -lt 5500 ];
then
        echo -e "${GREEN}Maximum : $MAX${END}"
else
        echo -e "${RED}Maximum : $MAX${END}"
fi
if [ "$MOY" -lt 5500 ];
then
        echo -e "${GREEN}Average : $MOY${END}"
else
        echo -e "${RED}Average : $MOY${END}"
fi
if [ "$MEDIAN" -lt 5500 ];
then
        echo -e "${GREEN}Median  : $MEDIAN${END}"
else
        echo -e "${RED}Median  : $MEDIAN${END}"
fi
echo ""

for el in "${ARRAY[@]}"; do
        SUM_STD_DEV=$(echo "$SUM_STD_DEV + ($el - $MOY)^2" | bc)
done
STD_DEV=$(echo "scale=2; sqrt($SUM_STD_DEV / $N)" | bc -l)
echo "Standard deviation : $STD_DEV"

print_histogram "Distribution — 500 elements ($N runs)" "${ARRAY[@]}"

echo "Over 5500 : $(( $(printf '%s\n' "${ARRAY[@]}" | awk '$1 > 5500' | wc -l) * 100 / N ))%"
