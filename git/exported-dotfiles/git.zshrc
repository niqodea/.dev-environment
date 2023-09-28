function () {
    if [ "$ZSH_GIT_PROMPT_SETUP" = true ]; then
        return
    fi

    export ZSH_GIT_PROMPT_SETUP=true

	local COLOR_GIT="%F{034}"  # Green
    local GIT_INFO='$(git rev-parse --is-inside-work-tree &> /dev/null && (git symbolic-ref --short -q HEAD || git rev-parse --short HEAD))'

	setup_prompt_base "${PROMPT_BASE}${COLOR_GIT}(${GIT_INFO})"
}


alias g="git"
alias ga="git add"
alias gap="git add --patch"
alias gb="git branch"
alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gcl="git clone"
alias gcln="git clean -fd"  # Delete untracked files
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"
alias gd="git diff"
alias gi="git init"
alias gl="git log --graph --pretty=format:'%C(auto)%h -%d %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"  # Compress log, add branches graph, show relative date and author
alias gm="git merge"
alias gp="git push"
alias gpf="git push --force-with-lease"  # You rarely want to force push if leasing fails
alias gpl="git pull --rebase"  # Incorporate changes by rebasing rather than merging
alias gr="git reset"
alias grb="git rebase --interactive"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grh="git reset --hard"
alias grs="git restore"
alias gs="git status"
alias gsh="git stash"
alias gshd="git stash drop"
alias gshl="git stash list"
alias gshp="git stash pop"
alias gsw="git switch"
alias gswc="git switch --create"
alias gswd="git switch --detach"

