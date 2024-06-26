#!/bin/bash

# This is a shell script that will call the actual test runner with the
# specified transducer. This determines also the set of yaml test files looped
# over by the test runner.

###### User variables - adjust as needed: #######
# Specify the invariable part of the transducer name:
transducer=lexicon

# Specify whether the test runner should test only generation, analysis or both:
# gen = generation test
# ana = analysis test
# full / both / "" (ie nothing) = test both directions
halftest=gen

# Specify the name of the subdir where the yaml files are, use '.' if it is the
# same dir as this script:
yaml_file_subdir=lexicon-yamls

####### Include/source helper script from dir above - DO NOT CHANGE: ########
# Relative path from test script to test runner:
testrunner="../../../test/run-yaml-testcases.sh"

# Make symlink of lexicon.hfst in the src directory
pushd ../ || exit 1
ln -s fst/lexicon.hfst generator-lexicon.hfst
popd || exit 1

source $testrunner $transducer $yaml_file_subdir ../../../test $halftest
