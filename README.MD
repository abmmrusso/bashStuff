# Bash Stuff

This repo is meant to hold a series of bash script resources for an assorted series of tasks.

## Unit Testing

Where possible, the scripts are unit tested using `shunit2` as provided by `/usr/bin/env shunit2`.
To run them, you will need to install/set it up.
Most of the package managers allow for `shunit2` installation:
* [apt-get](https://wiki.debian.org/Apt)
```bash
sudo apt-get install shunit2
```
* [pacman](https://wiki.archlinux.org/index.php/pacman)
```bash
sudo pacman -S shunit2
```
* [yum](http://yum.baseurl.org/)
```bash
sudo yum install shunit2
```
* [dnf](https://github.com/rpm-software-management/dnf)
```bash
sudo dnf install shunit2
```
* [ZYpp](https://en.opensuse.org/Portal:Libzypp)
```bash
sudo zypper in patch shunit2
```
* [portage](https://wiki.gentoo.org/wiki/Project:Portage)
```bash
sudo emerge -pv shunit2
```
* [Homebrew](https://brew.sh/)
```bash
brew install shunit2
```

## Documentation

REFERENCE.MD is generated with the use of [shdoc](https://github.com/reconquest/shdoc) using the command line
```
cat *.sh | shdoc > REFERENCE.md
```

## The Scripts

The following are the scripts provided on this repo.

### `bashHeadline.sh`

This script provides the `headline` function which can be used to allow the writting text surrounded by a frame made up of hash characters ('#'). The function is smart enough to fill the whole available terminal horizontal space.

#### Usage

To use the function, just source the file using `. bashHeadline.sh`.
From that point onward, you should be able to invoke the `headline` function like this:
```bash
$ headline hello
##################################################
#                     hello                      #
##################################################
```
You can also call the `banner` function that works as a simple _alias_ function for `headline`
```bash
$ banner hello
##################################################
#                     hello                      #
##################################################
```

#### Unit tests

To run unit tests for this script, run the `bashHeadline_tests.sh` script located inside the `tests` folder:
```bash
./tests/bashHeadline_test.sh

# SCRIPT OUTPUT EXAMPLE
testHeadlineWithEmptyText
testHeadlineWithEvenWidthTextOnEvenWidthTerminal
testHeadlineWithOddWidthTextOnEvenWidthTerminal
testHeadlineWithEvenWidthTextOnOddWidthTerminal
testHeadlineWithOddWidthTextOnOddWidthTerminal

Ran 5 tests.

OK
```
