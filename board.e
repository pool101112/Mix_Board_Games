note
	description: "[Cette classe sert à la gestion et à l'affichage du plateau.]"
	author: "Marc-André Douville Auger"
	copyright: "Copyright (c) 2013, Marc-André Douville Auger"
	date: "30 Mai 2013"
	revision: "0.13.05.30"

class
	BOARD

inherit
	IMAGE

create
	make

feature {GAME} -- Constructeur

	make (a_screen:POINTER; a_path_list:LIST[STRING]; a_x, a_y:INTEGER_16)
	-- Initialise `Current'
		require
			a_screen_is_not_null: not a_screen.is_default_pointer
			a_path_list_is_not_empty: not a_path_list.is_empty
		do
			screen := a_screen
			create_surface_area
			load_image_list (a_path_list)
			set_surface_ptr (1)
			set_w
			set_h
			set_x (a_x)
			set_y (a_y)
			alpha_value := 255
			create occupied_squares_list.make_filled (64)
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

feature {GAME} -- Affichage

	set_transparancy (a_value:NATURAL_8)
	-- Applique la transparence
		require
			a_value_is_at_least_0: a_value >= 0
		do
			alpha_value := a_value
		end

	apply
	-- Applique l'image à `screen'
		do
			apply_transparancy (alpha_value)
			apply_surface_to_screen
		end

feature {REVERSI_PIECE} -- Cases

	add_square_to_occupied_list (a_position:INTEGER_8)
	-- Ajoute une case à la liste des cases occupées
		do
			occupied_squares_list[a_position] := true
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

feature {GAME} -- Variables de classe

	alpha_value:NATURAL_8
	-- Valeur alpha utilisée lors de la transparence
	occupied_squares_list:ARRAYED_LIST[BOOLEAN]
	-- Liste des cases occupées
end
