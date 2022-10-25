#!/bin/sh

#
# Trompeloeil C++ mocking framework
#
# Copyright Björn Fahller 2014-2021
#
#  Use, modification and distribution is subject to the
#  Boost Software License, Version 1.0. (See accompanying
#  file LICENSE_1_0.txt or copy at
#  http://www.boost.org/LICENSE_1_0.txt)
#
# Project home: https://github.com/rollbear/trompeloeil
#

echo "CXX=$CXX"
echo "CXXFLAGS=$CXXFLAGS"
echo "CPPFLAGS=$CPPFLAGS"

# Default CXXFLAGS to -std=c++14 if not set in the environment
# for backward compatibility.
#CXXFLAGS=${CXXFLAGS:-"-std=c++14"}

#echo "CXXFLAGS is now $CXXFLAGS"

failfile=`mktemp`
#${CXX} --version
cd compilation_errors
parallel -j 1 ../verify_compilation_error.sh -- `ls *.cpp` | tee $failfile
FAILURES=`cat $failfile | grep FAIL | wc -l`
rm $failfile
exit $FAILURES
