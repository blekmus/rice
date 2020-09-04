function fish_prompt
    set -g fish_prompt_pwd_dir_length 0
   
    if contains -- $USER root toor
	set suffix '#'
    else
	set suffix '$'
    end

    set_color cyan
    printf '['
    set_color magenta
    printf (prompt_pwd)
    set_color cyan
    printf "]"
    set_color white
    printf "$suffix "
end
