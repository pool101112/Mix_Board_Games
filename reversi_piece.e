note
	description: "[Cette classe est utilisée pour la gestion des pièces du jeu d'othello.]"
	author: "Marc-André Douville Auger"
	copyright: "Copyright (c) 2013, Marc-André Douville Auger"
	date: ""
	revision: ""

class
	REVERSI_PIECE

inherit
	PIECE

create
	make

feature {GAME} -- Constructeur

	make (a_screen:POINTER; a_path_list:LIST[STRING]; a_position:INTEGER_8)
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
			alpha_value := 255
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

feature {GAME} -- Coordonnées de l'emplacement

	change_position (a_x, a_y:INTEGER_16)
	-- Change la position de l'élément sur la surface
		require
			a_x_is_at_least_0: a_x >= 0
			a_y_is_at_least_0: a_y >= 0
		do
			set_x (a_x)
			set_y (a_y)
		end

feature {NONE} -- Variables de classe

	alpha_value:NATURAL_8
	-- Valeur alpha utilisée lors de la transparence

end
