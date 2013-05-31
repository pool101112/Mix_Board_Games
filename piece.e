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
			create_list (a_path_list.count.as_integer_16)
			from
				l_i := 1
			until
				l_i > a_path_list.count
			loop
				load_image (a_path_list[l_i])
				l_i := l_i + 1
			end
		end

feature {NONE} -- Destructeur

	destroy
	-- Libère la mémoire alloué pour `current'
		do
			free_surfaces
		end

	free_surfaces
	-- Libère les surfaces
		do
			{SDL_IMAGE_WRAPPER}.SDL_FreeSurface (surface_ptr)
		end
end
