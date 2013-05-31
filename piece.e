note
	description: "[Cette classe abstraite est utilisée pour la gestion des pièces en général.]"
	author: "Marc-André Douville Auger"
	copyright: "Copyright (c) 2013, Marc-André Douville Auger"
	date: ""
	revision: ""

deferred class
	PIECE

inherit
	IMAGE

feature {NONE} -- Chargement des images

	load_image_list (a_path_list:LIST[STRING])
	-- Charge les images à partir des chemins dans `a_path_list'
		local
			l_i:INTEGER_8
		do
			from
				l_i := 1
			until
				l_i > a_path_list.count
			loop
				load_image (a_path_list[l_i])
			end
		end
end
