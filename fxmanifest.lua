fx_version 'cerulean'
game 'gta5'

name 'd4tConnection'
author 'D4NTE'
description 'MySQL connection and query layer for d4tCore resources'
version '1.0.0'
lua54 'yes'

server_only 'yes'

shared_scripts {
    'shared/config.lua',
    'shared/modules/*.lua'
}

server_scripts {
    'server/modules/*.lua'
}
