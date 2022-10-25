#!/bin/sh

PASS="\033[32mPASS\033[0m"
FAIL="\033[1;31mFAIL\033[0m"

SCRIPT='
s:^//\(.*\)$:\1:g
t print
b
:print
P
'
f=$1
RE=`sed -n "$SCRIPT" < $f`
# echo "RE=$RE"
${CXX} ${CXXFLAGS} ${CPPFLAGS} -I ../include $f -c 2>&1 | egrep  -q "${RE}" && printf "%-45s ${PASS}\n" $f && continue || printf "%-45s ${FAIL}\n" $f && false
