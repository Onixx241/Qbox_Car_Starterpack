fx_version 'adamant' 
game 'gta5' 
lua54 'yes'

server_script '@oxmysql/lib/MySQL.lua'

shared_script
{
	'@ox_lib/init.lua',
	'@qbx_core/modules/lib.lua'
} 

client_scripts { 
	"client/client.lua" 
} 
 
server_scripts { 
	"server/server.lua"
} 
