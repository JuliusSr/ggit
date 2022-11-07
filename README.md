# GGit

A Git wrapper utility

## Prerequisites
Have Git installed

## Configuration
In order to use ggit as a command add the following line to your `.bashrc` or `.zshrc`
```
alias ggit=<path_to_ggit>/ggit.sh
```

## Commands

### pull

Pull multiple branches without changing branch.  
It accepts a list of branches to pull as arguments.  
If no branch is given it only pulls current branch.  
If all option is given, it overrides branches passed as arguments.

#### options
```
-a|--all       Pull all branches (by default all locally tracked branches).
-r|--remote    Used with all option: pull all remote branches
```

#### usage
```sh
ggit pull
ggit pull dev prod
ggit pull --all
ggit pull --all --remote
ggit pull -a -r
```

### mergeto | mt

Merge current branch into one or more branches without changing branch.  
It accepts a list of branches to merge into as arguments (at least one branch has to be provided).  

#### options
```
-p|--push    Push to remote branch after merge
-s|--stash   Stash changes before merging and apply them after operation ends
```

#### usage
```sh
ggit mergeto dev
ggit mt dev
ggit mergeto dev prod --stash --push
ggit mt dev prod -s -p
```

### commit

Commit changes to one or more branches.  
By default changes are committed only to current branch.  

#### options
```
-a|--add         Add unstaged changes to staging area before commit
-m|--message     Commit message
-mt|--mergeto    Merge current branch into multiple other branches after commit
-p|--push        Push after commit (it also applies to all branches of --mergeto)
```

#### usage
```sh
ggit commit --add --push --mergeto dev prod --message "commit message"
ggit commit -a -p -mt dev prod -m "commit message"
```
