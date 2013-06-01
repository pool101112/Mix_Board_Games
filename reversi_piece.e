note
	description: "[Cette classe est utilis�e pour la gestion des pi�ces du jeu d'othello.]"
	author: "Marc-Andr� Douville Auger"
	copyright: "Copyright (c) 2013, Marc-Andr� Douville Auger"
	date: ""
	revision: ""

class
	REVERSI_PIECE

inherit
	PIECE

create
	make

feature {GAME} -- Constructeur

	make (a_screen:POINTER; a_path:STRING; a_board_square:INTEGER_8; a_game_board:BOARD; a_changing_color:BOOLEAN)
	-- Initialise `Current'
		require
			a_screen_is_not_null: not a_screen.is_default_pointer
			a_path_is_not_empty: not a_path.is_empty
		local
			l_string_list:ARRAYED_LIST[STRING]
		do
			screen := a_screen
			create_surface_area
			create l_string_list.make (1)
			l_string_list.extend (a_path)
			load_image_list (l_string_list)
			set_surface_ptr (1)
			set_w
			set_h
			set_x ((a_game_board.x + ((a_board_square \\ 8) * (a_game_board.w // 8))) + ((a_game_board.w // 8) // 2) - (w // 2))
			set_y ((a_game_board.y + ((a_board_square // 8) * (a_game_board.h // 8))) + ((a_game_board.h // 8) // 2) - (w // 2))
			if not a_changing_color then
				a_game_board.add_square_to_occupied_list (a_board_square + 1)
			end
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
	-- Applique l'image � `screen'
		do
			apply_transparancy (alpha_value)
			apply_surface_to_screen
		end

feature {GAME} -- Coordonn�es de l'emplacement

	change_position (a_x, a_y:INTEGER_16)
	-- Change la position de l'�l�ment sur la surface
		require
			a_x_is_at_least_0: a_x >= 0
			a_y_is_at_least_0: a_y >= 0
		do
			set_x (a_x)
			set_y (a_y)
		end

feature {NONE} -- Variables de classe

	alpha_value:NATURAL_8
	-- Valeur alpha utilis�e lors de la transparence

end
