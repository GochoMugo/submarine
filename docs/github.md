
# github

Utilities useful for Github users.

How?

* clone github repos using shorthands
* generate github tokens
* etc...

## usage:

1. **command:**

  ```bash
  $ msu run submarine.github.<command>
  ```

2. **module require:**

  ```bash
  msu_require "submarine.github"
  ```

## available commands:

### new_token()

Generate a new github accesstoken. You will be prompted for credentials.

Alias: `gh.new_token`


### clone(repoSlug)

Clone a github repository. Repo slug can be:
  * `username/reponame`: resolves to https://github.com/username/reponame.git
  * `reponame`: resolve to https://github.com/<username>/reponame where <username> is the configured name in git.

Alias: `gh.clone`
