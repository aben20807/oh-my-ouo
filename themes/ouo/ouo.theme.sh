# ouo theme # Author: Huang Po Hsuan
# inspired by theme "pure" "cupcake"

# scm theming
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${green}✓${normal}"
SCM_GIT_CHAR="${green}±${normal}"
SCM_GIT_BEHIND_CHAR="${bold_blue}↓${normal}"
SCM_GIT_AHEAD_CHAR="${bold_blue}↑${normal}"
SCM_GIT_UNTRACKED_CHAR="${bold_blue}⌀${normal}"
SCM_GIT_UNSTAGED_CHAR="${bold_yellow}•${normal}"
SCM_GIT_STAGED_CHAR="${bold_green}+${normal}"

CLOCK_THEME_PROMPT_PREFIX=''
CLOCK_THEME_PROMPT_SUFFIX=' '
THEME_SHOW_CLOCK=true
THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$green"}
THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"[%H:%M]"}

scm_prompt() {
    CHAR=$(scm_char)
    if [ $CHAR = $SCM_NONE_CHAR ]
    then
        return
    else
        echo "[$(scm_prompt_info)]"
    fi
}

rightprompt() {
    printf "%*s" $COLUMNS "$1"
}

virtualenv_prompt() {
    if [[ -n $VIRTUAL_ENV ]]; then
	    printf "[$(basename -- $VIRTUAL_ENV)] "
    elif [[ -n $CONDA_DEFAULT_ENV ]]; then
        printf "[$(basename -- $CONDA_DEFAULT_ENV)] "
    fi
}

# Credit: https://stackoverflow.com/a/17841619/2858703
join_by() { local IFS="$1"; shift; echo "$*"; }

# Credit: https://unix.stackexchange.com/a/551524
short_pwd() {
    IFS='/' read -a directory < <(pwd)

    local -i trim_level=${1:-3} # default trim level of 3

    if [ ${#directory[*]} -gt ${trim_level} ] && [ ${trim_level} -gt 0 ]; then
        join_by / "..." "${directory[@]: -${trim_level}}/"
    else
        pwd
    fi
}

ouo_prompt() {
    local RC="$?"
    local ps_host="$(tput setaf 221)\h${normal}"
    local ps_user="$(tput setaf 221)\u@${normal}"
    local ps_root="$(tput setaf 221)\u@${normal}"
    local ps_user_mark="${green}$ ${normal}"
    local ps_root_mark="${green}# ${normal}"
    if [ $RC -ne 0 ]
    then
        ps_user_mark="${red}$ ${normal}"
        ps_root_mark="${red}# ${normal}"
    fi
    
    local venv="${cyan}$(virtualenv_prompt)${normal}"
    local ps_path="$(tput setaf 39)$(short_pwd 5)${normal}"

    # Left
    case $(id -u) in
        0) PS1L="$venv$ps_root$ps_host $ps_path $(scm_prompt)"
        ;;
        *) PS1L="$venv$ps_user$ps_host $ps_path $(scm_prompt)"
        ;;
    esac

    # Right
    PS1R="$(clock_prompt)"
    
    # Ref: https://wiki.archlinux.org/index.php/Bash/Prompt_customization#Right-justified_text
    # Combine
    PS1=$(printf "\n$(tput sc; rightprompt $PS1R; tput rc)%s" "$PS1L")

    case $(id -u) in
        0) PS1="${PS1}\n$ps_root_mark"
        ;;
        *) PS1="${PS1}\n$ps_user_mark"
        ;;
    esac
}

safe_append_prompt_command ouo_prompt
