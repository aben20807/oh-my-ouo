# ouo theme
# Author: Huang Po Hsuan
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

ouo_prompt() {
    # ps_host="${bold_blue}\h${normal}";
    # ps_user="${green}\u${normal}";
    # ps_root="${red}\u${red}";
    # ouo="${green}ouo${normal}";
    if [ $? -ne 0 ]
        then
            ps_user_mark="${red}$ ${normal}";
        else
            ps_user_mark="${green}$ ${normal}";
    fi
    ps_root_mark="${green}# ${normal}"
    ps_path="${yellow}\w${normal}";

    # make it work
    case $(id -u) in
        # 0) PS1="$ps_root@$ps_host$(scm_prompt):$ps_path\n$ps_root_mark"
        0) PS1="\n$(clock_prompt)$ps_path $(scm_prompt)\n$ps_root_mark"
            ;;
        # *) PS1="$ps_user@$ps_host$(scm_prompt):$ps_path\n$ps_user_mark"
        *) PS1="\n$(clock_prompt)$ps_path $(scm_prompt)\n$ps_user_mark"
            ;;
    esac
}

safe_append_prompt_command ouo_prompt
