fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description "Simle QBR-Core Admin Menu Using QBR-Menu || Thrasherrr#9224"
author "Thrasherrr#9224"
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
	-- '@qbr-core/shared/locale.lua',
	-- 'locales/en.lua',
  'config.lua'
}

client_scripts {
  'client/*.lua',
}

files {
  'html/index.html',
  'html/index.js'
}

server_script 'server/*.lua'