# About This Project
This repo is used to automatically setup the latest version sqlite on Ubuntu. Currently very fragile. Getting the latest tarball version relies on HTML parsing, which heavily depends on the structure of the webpage.

## Getting Started

### Prerequisites
- ANSI-C compiler and make.
  - Running `sudo apt-get install build-essential` will install all prerequisites.
- bash
  - Other shell scripts are not supported

### Installation
1. Install prerequisites
2. Clone the repo
`git clone https://github.com/AbdulHafiiz/sqlite-setup`

## Usage
Install sqlite by running
`bash setup_sqlite.sh`
in the cli.

## Roadmap
- [ ] Make version detection more robust

## License
Distributed under the MIT License. See `LICENSE.txt` for more information.
