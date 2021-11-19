source ~/ubuntu-bash/.env
source ~/ubuntu-bash/nginx.sh

alias src='cd; source .bashrc'

alias fdapp="cd && cd $APP_FOLDER_PATH"
alias fdapi='cd && cd elefnt-crypto-api'
alias fddocs='cd && cd Staging-Docs'

alias pullapp='fdapp && ssh-agent bash -c "ssh-add ~/.ssh/app_rsa; git pull"'
alias pullapi='fdapi && ssh-agent bash -c "ssh-add ~/.ssh/api_rsa; git pull"'
alias pulldocs='fddocs && ssh-agent bash -c "ssh-add ~/.ssh/docs_rsa; git pull"'

buildProd() {
        fdapp
        npm i
        npm run build:prod
        sudo rm -f /var/www/html/*
        sudo cp ~/fintech-freedom/dist/* /var/www/html/
}

deploy() {
        fdapp
        git reset --hard HEAD
        ssh-agent bash -c "ssh-add ~/.ssh/app_rsa; git pull"
        buildProd
}
