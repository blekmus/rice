function helpie
    if [ "$argv" = 'edit' ]
	    vim /home/someone/backups/commands
    else
	    cat /home/someone/backups/commands
    end
end
