note
	description: "[Gestion principale du jeu. Cette classe appelle la plupart des autres classes pour faire fonctionner le jeu.]"
	author: "Marc-André Douville Auger"
	copyright: "Copyright (c) 2013, Marc-André Douville Auger"
	date: "31 Mai 2013"
	revision: "0.13.05.31"

class
	GAME

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialisation de l'application

	make
	-- Lance l'application
		local
			l_screen:POINTER
		do
			init_video
			l_screen := init_screen(800, 600)
			apply_title
			game_selection_menu (l_screen)
			quit
		end

feature {NONE} -- Menus

	game_selection_menu (a_screen:POINTER)
	-- Affiche le menu principal
		require
			a_screen_is_not_null: not a_screen.is_default_pointer
		local
			l_string_list:ARRAYED_LIST[STRING]
			l_event_ptr:POINTER
			l_quit:BOOLEAN
			l_profile_name:STRING

			l_background:BACKGROUND
			l_chess_button, l_checkers_button, l_reversi_button, l_profile_bubble:MENU_ELEMENT
		do
			create l_string_list.make (1)
			l_string_list.extend ("ressources/images/menu/main_menu.png")
			create l_background.make (a_screen, l_string_list)
			l_chess_button := create_menu_object (a_screen, "ressources/images/menu/bouton_echecs.png", 265, 200)
			l_checkers_button := create_menu_object (a_screen, "ressources/images/menu/bouton_dames.png", 265, 300)
			l_reversi_button := create_menu_object (a_screen, "ressources/images/menu/bouton_othello.png", 265, 400)
			l_profile_bubble := create_menu_object (a_screen, "ressources/images/menu/profile_bubble.png", 0, 0)
			l_profile_bubble.change_position(((800 // 2) - (l_profile_bubble.w // 2)).as_integer_16, (600 - l_profile_bubble.h).as_integer_16)
			l_event_ptr := sizeof_event_ptr
			l_profile_name := "DouDou"
			from
			until
				l_quit
			loop
				from
				until
					{SDL_EVENT_WRAPPER}.SDL_PollEvent (l_event_ptr) < 1
				loop
					if quit_requested (l_event_ptr) then
						l_quit := true
					elseif over_button (l_chess_button, l_event_ptr) then
						if click (l_event_ptr) then
							print ("Chess!")
						end
					elseif over_button (l_checkers_button, l_event_ptr) then
						if click (l_event_ptr) then
							print ("Checkers!")
						end
					elseif over_button (l_reversi_button, l_event_ptr) then
						if click (l_event_ptr) then
							l_background.apply
							reversi_game (a_screen, l_profile_name)
						end
					end
				end
				l_background.apply
				l_chess_button.apply
				l_checkers_button.apply
				l_reversi_button.apply
				l_profile_bubble.apply
				refresh_screen (a_screen)
			end
			l_background.destroy
			l_chess_button.destroy
			l_checkers_button.destroy
			l_reversi_button.destroy
			l_profile_bubble.destroy
		end

	create_menu_object (a_screen:POINTER; a_path:STRING; a_x, a_y:INTEGER_16):MENU_ELEMENT
	-- Objet de type MENU
		local
			l_string_list:ARRAYED_LIST[STRING]
			l_menu:MENU_ELEMENT
		do
			create l_string_list.make (1)
			l_string_list.extend (a_path)
			create l_menu.make (a_screen, l_string_list, a_x, a_y)
			result := l_menu
		end

	over_button (a_button:MENU_ELEMENT; a_event_ptr:POINTER):BOOLEAN
	-- Confirmation que la souris est au-dessus d'un element
		local
			l_mouse_x, l_mouse_y:INTEGER_16
		do
			l_mouse_x := {SDL_EVENT_WRAPPER}.get_mouse_x (a_event_ptr).as_integer_16
			l_mouse_y := {SDL_EVENT_WRAPPER}.get_mouse_y (a_event_ptr).as_integer_16
			result := false
			if (l_mouse_x >= a_button.x and l_mouse_x <= (a_button.x + a_button.w)) and (l_mouse_y >= a_button.y and l_mouse_y <= (a_button.y + a_button.h)) then
				result := true
			end
		end

feature {NONE} -- Jeux

	reversi_game (a_screen:POINTER; a_profile_name:STRING)
	-- Lance le jeu d'Othello
		local
			l_game_board:BOARD
			l_string_list:ARRAYED_LIST[STRING]
			l_pieces_list:ARRAYED_LIST[REVERSI_PIECE]
			l_quit, l_white_player_turn, l_valid_move:BOOLEAN
			l_i:INTEGER
			l_event_ptr:POINTER
			l_board_square, l_next_piece:INTEGER_8
			l_color:STRING
		do
			create l_string_list.make (1)
			l_string_list.extend ("ressources/images/reversi/reversi_board.png")
			create l_game_board.make (a_screen, l_string_list, 200, 150)
			create l_pieces_list.make_filled (64)
			l_pieces_list[28] := (create {REVERSI_PIECE}.make (a_screen, 27, l_game_board, false, "w"))
			l_pieces_list[37] := (create {REVERSI_PIECE}.make (a_screen, 36, l_game_board, false, "w"))
			l_pieces_list[29] := (create {REVERSI_PIECE}.make (a_screen, 28, l_game_board, false, "b"))
			l_pieces_list[36] := (create {REVERSI_PIECE}.make (a_screen, 35, l_game_board, false, "b"))
			l_event_ptr := sizeof_event_ptr
			l_white_player_turn := true
			from
			until
				l_quit
			loop
				from
				until
					{SDL_EVENT_WRAPPER}.SDL_PollEvent (l_event_ptr) < 1
				loop
					if quit_requested (l_event_ptr) then
						l_quit := true
					elseif click (l_event_ptr) then
						print ("Your move is starting... ")
						io.put_new_line
						print ("------------------------ ")
						io.put_new_line
						if l_white_player_turn then
							l_color := "w"
						else
							l_color := "b"
						end
						if is_not_occupied (l_game_board, l_event_ptr) then
							l_board_square := board_square (l_game_board, l_event_ptr) + 1
							if is_valid_move (l_game_board, l_board_square, l_white_player_turn, -1, -8) >= 0 then
								l_valid_move := true
								l_next_piece := is_valid_move (l_game_board, l_board_square, l_white_player_turn, -1, -8)
								change_pieces_color (l_game_board, l_board_square, l_next_piece, -1, -8, l_color, l_pieces_list, a_screen)
							end
							if is_valid_move (l_game_board, l_board_square, l_white_player_turn, -1, 0) >= 0 then
								l_valid_move := true
								l_next_piece := is_valid_move (l_game_board, l_board_square, l_white_player_turn, -1, 0)
								change_pieces_color (l_game_board, l_board_square, l_next_piece, -1, 0, l_color, l_pieces_list, a_screen)
							end
							if is_valid_move (l_game_board, l_board_square, l_white_player_turn, -1, 8) >= 0 then
								l_valid_move := true
								l_next_piece := is_valid_move (l_game_board, l_board_square, l_white_player_turn, -1, 8)
								change_pieces_color (l_game_board, l_board_square, l_next_piece, -1, 8, l_color, l_pieces_list, a_screen)
							end
							if is_valid_move (l_game_board, l_board_square, l_white_player_turn, 0, -8) >= 0 then
								l_valid_move := true
								l_next_piece := is_valid_move (l_game_board, l_board_square, l_white_player_turn, 0, -8)
								change_pieces_color (l_game_board, l_board_square, l_next_piece, 0, -8, l_color, l_pieces_list, a_screen)
							end
							if is_valid_move (l_game_board, l_board_square, l_white_player_turn, 0, 8) >= 0 then
								l_valid_move := true
								l_next_piece := is_valid_move (l_game_board, l_board_square, l_white_player_turn, 0, 8)
								change_pieces_color (l_game_board, l_board_square, l_next_piece, 0, 8, l_color, l_pieces_list, a_screen)
							end
							if is_valid_move (l_game_board, l_board_square, l_white_player_turn, 1, -8) >= 0 then
								l_valid_move := true
								l_next_piece := is_valid_move (l_game_board, l_board_square, l_white_player_turn, 1, -8)
								change_pieces_color (l_game_board, l_board_square, l_next_piece, 1, -8, l_color, l_pieces_list, a_screen)
							end
							if is_valid_move (l_game_board, l_board_square, l_white_player_turn, 1, 0) >= 0 then
								l_valid_move := true
								l_next_piece := is_valid_move (l_game_board, l_board_square, l_white_player_turn, 1, 0)
								change_pieces_color (l_game_board, l_board_square, l_next_piece, 1, 0, l_color, l_pieces_list, a_screen)
							end
							if is_valid_move (l_game_board, l_board_square, l_white_player_turn, 1, 8) >= 0 then
								l_valid_move := true
								l_next_piece := is_valid_move (l_game_board, l_board_square, l_white_player_turn, 1, 8)
								change_pieces_color (l_game_board, l_board_square, l_next_piece, 1, 8, l_color, l_pieces_list, a_screen)
							end

							if l_valid_move then
								l_pieces_list[l_board_square] := (create {REVERSI_PIECE}.make (a_screen, l_board_square - 1, l_game_board, false, l_color))
								if l_white_player_turn then
									l_white_player_turn := false
								else
									l_white_player_turn := true
								end
								l_valid_move := false
							end
						else
							print ("Occupied")
							io.put_new_line
						end
						print ("Your move is done!")
						print ("||||||||||||||||||")
						io.put_new_line
					end
				end
				l_game_board.apply
				from
					l_i := 1
				until
					l_i > l_pieces_list.count
				loop
					if l_pieces_list[l_i] /= void then
						l_pieces_list[l_i].apply
					end
					l_i := l_i + 1
				end
				refresh_screen (a_screen)
			end
			l_game_board.destroy
			from
				l_i := 1
			until
				l_i > l_pieces_list.count
			loop
				if l_pieces_list[l_i] /= void then
						l_pieces_list[l_i].destroy
					end
				l_i := l_i + 1
			end
		end

feature {NONE} -- Autres

	quit_requested (a_event_ptr:POINTER):BOOLEAN
	-- Confirmation d'une demande de quitter l'application
		local
			l_event:NATURAL_8
		do
			l_event := {SDL_EVENT_WRAPPER}.get_SDL_Event_type(a_event_ptr)
			if l_event = {SDL_EVENT_WRAPPER}.SDL_QUIT then
				Result := True
			else
				Result := False
			end
		end

	apply_title
	-- Applique un nom à la fenêtre
		local
			l_screen_title:C_STRING
		do
			create l_screen_title.make ("Mix Board Games")
			{SDL_GENERAL_WRAPPER}.SDL_WM_SetCaption (l_screen_title.item, create{POINTER})
		end

feature {NONE} -- Cases valides

	board_square (a_game_board:BOARD; a_event_ptr:POINTER):INTEGER_8
	-- Numéro de la case du plateau
		local
			l_mouse_x, l_mouse_y:INTEGER_16
		do
			l_mouse_x := {SDL_EVENT_WRAPPER}.get_mouse_x (a_event_ptr).as_integer_16
			l_mouse_y := {SDL_EVENT_WRAPPER}.get_mouse_y (a_event_ptr).as_integer_16
			if (l_mouse_x > a_game_board.x and l_mouse_x < (a_game_board.x + a_game_board.w)) and (l_mouse_y > a_game_board.y and l_mouse_y < (a_game_board.y + a_game_board.h)) then
				result := (((l_mouse_x - a_game_board.x) // (a_game_board.w // 8)) + (((l_mouse_y - a_game_board.y) // (a_game_board.h // 8) * 8))).as_integer_8
			end
		end

	is_not_occupied (a_game_board:BOARD; a_event_ptr:POINTER):BOOLEAN
	-- Confirmation que la case est libre
		local
			l_mouse_x, l_mouse_y:INTEGER_16
			l_board_square:INTEGER_16
		do
			l_mouse_x := {SDL_EVENT_WRAPPER}.get_mouse_x (a_event_ptr).as_integer_16
			l_mouse_y := {SDL_EVENT_WRAPPER}.get_mouse_y (a_event_ptr).as_integer_16
			result := false
			if (l_mouse_x > a_game_board.x and l_mouse_x < (a_game_board.x + a_game_board.w)) and (l_mouse_y > a_game_board.y and l_mouse_y < (a_game_board.y + a_game_board.h)) then
				l_board_square := (((l_mouse_x - a_game_board.x) // (a_game_board.w // 8)) + (((l_mouse_y - a_game_board.y) // (a_game_board.h // 8) * 8)))
				if a_game_board.occupied_squares_list[l_board_square + 1].is_equal ("none") then
					result := true
				end
			end
		end

	is_valid_move (a_board_game:BOARD; a_board_square:INTEGER_8; a_white_player_turn:BOOLEAN; a_x, a_y:INTEGER_8):INTEGER_8
	-- Confirmation que le mouvement est valide selon la pièce en haut à gauche
		local
			l_board_square, l_x_limit:INTEGER_8
			l_enemy_color, l_player_color:STRING
		do
			result := - 1
			l_board_square := a_board_square
			if a_white_player_turn then
				l_enemy_color := "b"
				l_player_color := "w"
			else
				l_enemy_color := "w"
				l_player_color := "b"
			end

			if a_y = 0 then
				if a_x = -1 then
					l_x_limit := ((8 * ((l_board_square - 1) // 8)) + 1).as_integer_8
				elseif a_x = 1 then
					l_x_limit := (((8 * ((l_board_square - 1) // 8)) + 7) + 1).as_integer_8
				end
			end

			if (l_board_square + a_x + a_y) < 1 or (l_board_square + a_x + a_y) > 64 then
				result := - 1
			elseif a_board_game.occupied_squares_list[l_board_square + a_x + a_y].is_equal (l_enemy_color) then
				from
					result := -2
				until
					result > -2
				loop
					l_board_square := l_board_square + a_x + a_y
					if l_board_square < 1 or l_board_square > 64 then
						result := -1
					elseif a_board_game.occupied_squares_list[l_board_square].is_equal (l_player_color) then
						result := l_board_square
					elseif a_board_game.occupied_squares_list[l_board_square].is_equal ("none") then
						result := -1
					end
					if a_x = 1 and a_y = 0 then
						if l_board_square > l_x_limit then
							result := -1
						end
					elseif a_x = -1 and a_y = 0 then
						if l_board_square < l_x_limit then
							result := -1
						end
					end
				end
			end
		end

	change_pieces_color (a_game_board:BOARD; a_board_square, a_board_final_square, a_x, a_y:INTEGER_8; a_color:STRING; a_pieces_list:ARRAYED_LIST[REVERSI_PIECE]; a_screen:POINTER)
	-- Change la couleur des pièces
	local
		l_board_square:INTEGER_8
	do
		l_board_square := a_board_square
		from
			l_board_square := l_board_square + a_x + a_y
		until
			l_board_square = a_board_final_square
		loop
			print ("Going to destroy square " + (l_board_square - 1).out + "... ")
			a_pieces_list[l_board_square].destroy
			print ("Done! Creating new piece... ")
			a_pieces_list[l_board_square] := (create {REVERSI_PIECE}.make (a_screen, l_board_square - 1, a_game_board, true, a_color))
			print ("Done! Changing datas... ")
			a_game_board.occupied_squares_list[l_board_square] := a_color
			print ("Done!")
			io.put_new_line
			l_board_square := l_board_square + a_x + a_y
		end
	end

feature {NONE} -- Fonctions autres de la librairie SDL (Quit, etc.)

	quit
	-- Quitte et ferme les systèmes de la librairie SDL
		do
			{SDL_GENERAL_WRAPPER}.SDL_Quit
		end

feature {NONE} -- Fonctions des images de la librairie SDL

	init_video
	-- Initialise le mode vidéo
		do
			if {SDL_GENERAL_WRAPPER}.SDL_Init ({SDL_IMAGE_WRAPPER}.SDL_INIT_VIDEO) < 0 then
				print ("Erreur: Une erreur est survenue lors de l'initialisation du mode video.")
			end
		end

	init_screen (a_width, a_height:INTEGER):POINTER
	-- Pointeur de l'écran
		do
			result := {SDL_IMAGE_WRAPPER}.SDL_SetVideoMode (a_width, a_height, 32, {SDL_IMAGE_WRAPPER}.SDL_SWSURFACE)
		ensure
			result_is_not_null : not result.is_default_pointer
		end

	refresh_screen (a_screen:POINTER)
	-- Valeur de retour indiquant si le rafraîchissement de l'écran `a_screen' a échouée
		require
			a_screen_is_not_null: not a_screen.is_default_pointer
		do
			if {SDL_IMAGE_WRAPPER}.SDL_Flip (a_screen) < 0 then
				print ("Erreur lors du rafraîchissement de l'écran")
			end
			{SDL_GENERAL_WRAPPER}.SDL_Delay (12)
		end

feature {NONE} -- Fonctions des événements de la librairie SDL

	click (a_event_ptr:POINTER):BOOLEAN
	-- Confirmation d'un clic
		require
			a_event_ptr_is_not_null: not a_event_ptr.is_default_pointer
		local
			l_event:NATURAL_8
		do
			result := false
			l_event := {SDL_EVENT_WRAPPER}.get_SDL_Event_type (a_event_ptr)
			if l_event = {SDL_EVENT_WRAPPER}.SDL_MOUSEBUTTONDOWN then
				result := true
			end
		end

	sizeof_event_ptr:POINTER
	-- Taille d'un pointeur de type event
		local
			l_memory_manager:POINTER
		do
			result := l_memory_manager.memory_alloc({SDL_EVENT_WRAPPER}.sizeof_SDL_Event)
		ensure
			result_is_not_null: not result.is_default_pointer
		end

end
