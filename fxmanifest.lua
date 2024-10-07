-- fxmanifest.lua

fx_version 'cerulean'
game 'gta5'

author 'Jay O Sullivan'
description 'Boosting Script with Tablet'
version '1.0'

ui_page 'html/boosting_tablet.html'

files {
    'html/boosting_tablet.html',
    'html/styles.css',
    'html/scripts.js'
}

server_script 'config.lua' -- Include config file
server_script 'server/main.lua'
client_script 'client/main.lua'
