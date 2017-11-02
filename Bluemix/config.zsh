[[ -f ~/.ssh/bluemix.json ]] &&  export BLUEMIX_API_KEY=$(grep apiKey ~/.ssh/bluemix.json | awk -F\" '{print $4}')

