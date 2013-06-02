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

	make (a_screen:POINTER; a_board_square:INTEGER_8; a_game_board:BOARD; a_changing_color:BOOLEAN; a_color:STRING)
	-- Initialise `current'
		require
			a_screen_is_not_null: not a_screen.is_default_pointer
		local
			l_string_list:ARRAYED_LIST[STRING]
		do
			screen := a_screen
			create_surface_area
			create l_string_list.make (1)
			if a_color.is_equal ("b") then
				l_string_list.extend ("ressources/images/reversi/black_reversi.png")
			elseif a_color.is_equal ("w") then
				l_string_list.extend ("ressources/images/reversi/white_reversi.png")
			end
			load_image_list (l_string_list)
			set_surface_ptr (1)
			set_w
			set_h
			set_x ((a_game_board.x + ((a_board_square \\ 8) * (a_game_board.w // 8))) + ((a_game_board.w // 8) // 2) - (w // 2))
			set_y ((a_game_board.y + ((a_board_square // 8) * (a_game_board.h // 8))) + ((a_game_board.h // 8) // 2) - (w // 2))
			if not a_changing_color then
				a_game_board.add_square_to_occupied_list (a_board_square + 1, a_color)
			end
			alpha_value := 255
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

end
