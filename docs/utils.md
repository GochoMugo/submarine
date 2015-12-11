
# utils

Some utilities I find useful.

## usage

1. **command:**

  ```bash
  $ msu run submarine.utils.<command>
  ```

2. **module require:**

  ```bash
  msu_require "submarine.utils"
  ```


### check()

Checks to see if useful development utilities have been installed.


### extract([file1 [, file2 [, ...]]])

Extract different types of archives e.g. zip, tar, tgz, etc.

Alias: `utils.extract`


### makezip(filename)

Create a zip from a file or directory

Alias: `utils.makezip`


### makepdf(filename)

Create a PDF file, with the file `filename` as input to `pdflatex` command.

Alias: `utils.makepdf`

