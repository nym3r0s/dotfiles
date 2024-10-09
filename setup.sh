#!/bin/bash

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# java <3
curl -s "https://get.sdkman.io" | bash

# install all the packages
brew install $(<packages.txt)

# install casks
brew install $(<casks.txt)
