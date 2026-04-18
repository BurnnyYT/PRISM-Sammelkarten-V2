fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'BurnnyYT'
description 'PRISM Sammelkarten System'
version '0.0.2'

ui_page 'html/index.html'

dependencies {
    'ox_inventory',
    'ox_lib',
    'es_extended'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/missing.png',
    'images/*.png'
}
