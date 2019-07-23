--Copyright ZAUB1
--N'hesitez pas a rejoindre mon discord : https://discord.gg/yFuSEGj
--Et a me contacter directement pour tout bug ou suggestions
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937' -- See https://docs.fivem.net/scripting-reference/resource-manifest/resource-manifest/#resource-manifest-version

description 'ESX Pizza Job'

version '1.0.1'

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'client.lua',
    'config.lua'
}

server_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'server.lua',
    'config.lua'
}