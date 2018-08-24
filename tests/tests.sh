#!/bin/bash

. assert.sh

declare -a info=($(../src/get_os_info.sh))

case ${info[0]} in
    osx)
        assert_raises "brew --version" 0 ""
        ;;
esac


assert_raises "pet --version" 255 ""
assert_raises "git --version" 0 ""
assert_raises "yarn --version" 0 ""
assert_raises "go --version" 2 ""
assert_raises "pip --version" 0 ""
assert_raises "docker --version" 0 ""
# assert_raises "hub --version" 0 ""
assert_raises "curl --version" 0 ""
assert_raises "nvim --version" 0 ""
assert_raises "python --version" 0 ""
assert_raises "ruby --version" 0 ""
assert_raises "node --version" 0 ""
assert_raises "rbenv --version" 0 ""
assert_raises "composer --version" 0 ""
assert_raises "php --version" 0 ""
assert_raises "travis --version" 0 ""
assert_end tests
