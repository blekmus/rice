function helpie
    if [ "$argv" = 'edit' ]
	    micro $HOME/Sandbox/commands
    else
	    cat $HOME/Sandbox/commands
    end
end
