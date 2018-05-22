function git_branch_diff() {
    [[ $# != 2 ]] && __sk_git_branch_diff && return -1
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $1..$2
}

function __sk_git_branch_diff() {
    echo 'Shows branch difference'
    echo
    echo 'Usage: git_branch_diff brahchA branchB'
}

function git_branch_cleanup() {
    git remote prune origin && git branch -r | awk '{ print $1 }' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{ print $1 }'   | xargs -p -n1 git branch -d
}

function __sk_git_branch_cleanup() {
    echo 'Cleanes up git branches that do not exist on remote anymore'
    echo
    echo 'Usage: git_branch_cleanup'
}
