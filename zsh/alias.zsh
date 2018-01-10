
alias ls='ls -FC --color=auto'


function mark {
	echo -ne "\e];$*\a"
	/usr/bin/figlet -f big -Wc $(date +%T)
	$*
}

