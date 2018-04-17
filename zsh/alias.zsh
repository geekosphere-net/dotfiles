
alias ls='ls -FC --color=auto'


function mark {
	echo -ne "\e];$*\a"
	/usr/bin/figlet -f big -Wc $(date +%T)
	$*
}

function markloop () {
        echo -ne "\e];$*\a"
        /usr/bin/figlet -f big -Wc $(date +%T)
        local startT=$(date +%s)
        while true
        do
                $*
                sleep 10
                /usr/bin/figlet -f small -Wl $(( $(date +%s) - $startT ))
        done
}
