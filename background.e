note
	description: "[Cette classe sert à gérer et afficher l'arrière-plan.]"
	author: "Marc-André Douville Auger"
	copyright: "Copyright (c) 2013, Marc-André Douville Auger"
	date: "30 Mai 2013"
	revision: "0.13.05.30"

class
	BACKGROUND

inherit
	IMAGE

create
	make

feature {GAME} -- Constructeur

	make (a_screen:POINTER; a_path_list:LIST[STRING])
	-- Initialise `Current'
		require
			a_screen_is_not_null: not a_screen.is_default_pointer
			a_path_list_is_not_empty: not a_path_list.is_empty
		do
			screen := a_screen
			create_surface_area
			load_image_list (a_path_list)
			set_surface_ptr (1)
			set_x (0)
			set_y (0)
			set_w
			set_h
		end

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

feature {GAME} -- Application de l'image

	apply
	-- Applique `current' à `screen'
		do
			apply_surface_to_screen
		end

feature {GAME} -- Destructeur

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
