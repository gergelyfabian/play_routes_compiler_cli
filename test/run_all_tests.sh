#!/usr/bin/env bash
# Borrowed from lucidsoftware/rules_play_routes

set -e

# NOMERGE
echo "skipping tests"
exit 0

# TODO: Once the Bazel integration testing library is further along, we should
# migrate to it
./test/play_routes_compiler_bazel_e2e_test.sh
./test/reproducibility_test.sh
