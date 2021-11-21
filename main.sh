source ~/ubuntu-bash/.env
source ~/ubuntu-bash/nginx.sh

alias src='cd; source .bashrc'

alias fdapp="cd && cd $APP_FOLDER_PATH"
alias fdapi="cd && cd $API_FOLDER_PATH"
alias fdscripts="cd && cd $SCRIPTS_FOLDER_PATH"

alias pullapp="fdapp && ssh-agent bash -c \"ssh-add $APP_SSH_PATH; git pull\""
alias pullapi="fdapi && ssh-agent bash -c \"ssh-add $API_SSH_PATH; git pull]\""
alias pullscripts='fdscripts && git pull'

appRebuild() {
        fdapp
        npm i
        npm run build:prod
        sudo rm -f $NGINX_APP_FILES_PATH/*
        sudo cp $APP_FOLDER_PATH/dist/* $NGINX_APP_FILES_PATH
}

appDeploy() {
        fdapp
        git reset --hard HEAD
        pullapp
        appRebuild
}

apiDeploy() {
        pullapi
        npm i
        pm2 stop api
        pm2 start api
}
