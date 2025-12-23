fx_version 'cerulean'
game 'gta5'
lua54 'yes'

title "Corey-Resources"
author "CoreyJB247" -- github
description "A script containing multiple essential roleplay functionalities utilising ox lib"
version "0.0.1"

shared_script '@ox_lib/init.lua'

client_scripts {
    'client/*.lua'
}

shared_scripts {
    'config.lua'
}
