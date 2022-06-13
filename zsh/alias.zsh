#
# WSL "home" dir
WSL_HOME=${${PATH%/AppData*}##*:}

alias ls='ls -FC --color=auto'


alias mvn="docker run -v ~/.m2:/var/maven/.m2 -v \$PWD:/usr/src/app -w /usr/src/app -ti --rm -u $(id -u ${whoami}):$(id -g ${whoami}) -e MAVEN_CONFIG=/var/maven/.m2 maven:3-jdk-8-slim mvn -Duser.home=/var/maven "
alias mulemvn="docker run -v ${WSL_HOME}/.m2:/var/maven/.m2 -v \$PWD:/usr/src/app -w /usr/src/app -ti --rm -u $(id -u ${whoami}):$(id -g ${whoami}) -e MAVEN_CONFIG=/var/maven/.m2 maven:3-jdk-8-slim mvn versions:display-dependency-updates --show-version -Denvironment.id=6913d3b1-798c-472e-a9a5-a5224230bed1 -Ddomain=localhost -Dworker.id=0 -Denv=dev -Dsecret.key=abcd1234abcd1234 -Duser.home=/var/maven "
alias anypoint-cli="docker run --rm --name anypoint-cli -it integrational/anypoint-cli:latest "

alias xmllint="docker run -i --rm --name 'xmllint' -v \$PWD:/data mribeiro/xmllint  "

alias yq="docker run -v \$PWD:/workdir -it --rm mikefarah/yq:4 \$@"
alias aws="docker run --rm -it -v ~/.aws:/root/.aws -v \$PWD:/aws -e AWS_PROFILE -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e TZ amazon/aws-cli"

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
                local secs=$(( $(date +%s) - $startT ))
                local diff=$(printf '%d:%02d\n' $(($secs%3600/60)) $(($secs%60)) )
                /usr/bin/figlet -f small -Wl $diff
                echo $*
        done
}
