#!/bin/bash
./XcodeCoverage/cleancov
xctool test -workspace CKCountdownButton.xcworkspace -scheme CKCountdownButton -sdk iphonesimulator -arch i386 ONLY_ACTIVE_ARCH=NO GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES
./XcodeCoverage/getcov