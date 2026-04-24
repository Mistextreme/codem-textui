fx_version 'cerulean'
game 'gta5'
version '1.0.0'
author 'vlxrecata bigboss'

client_scripts {
	'client/*.lua',
}


ui_page "html/index.html"

files {
	'html/index.html',
	'html/css/*.css',
	'html/fonts/*.TTF',
	'html/fonts/*.*',
	'html/sound/*.*',
	'html/images/**/*.png',
	'html/images/**/**/*.png',
	'html/js/*.js',
	'html/js/**/*.js',
	'html/images/**/*.png',

}

escrow_ignore {
	'client/example.lua',
}

lua54 'yes'

export 'OpenTextUI'
export 'CloseTextUI'

dependency '/assetpacks'