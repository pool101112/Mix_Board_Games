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
			l_string_list.extend ("ressources/images/main_menu.png")
			create l_background.make (a_screen, l_string_list)
			l_chess_button := create_menu_object (a_screen, "ressources/images/bouton_echecs.png", 265, 200)
			l_checkers_button := create_menu_object (a_screen, "ressources/images/bouton_dames.png", 265, 300)
			l_reversi_button := create_menu_object (a_screen, "ressources/images/bouton_othello.png", 265, 400)
			l_profile_bubble := create_menu_object (a_screen, "ressources/images/profile_bubble.png", 0, 0)
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
			if (l_mouse_x >= a_button.x and l_mouse_x <= (a_button.x + a_button.w)) and (l_mouse_y >= a_button.y and l_mouse_y <= (a_button.y + a_button.h))   then
				result := true
			end
		end

feature {NONE} -- Jeux

	reversi_game (a_screen:POINTER; a_profile_name:STRING)
		local
			l_game_board:BOARD
			l_string_list:ARRAYED_LIST[STRING]
			l_quit:BOOLEAN
			l_event_ptr:POINTER
			l_bg:BACKGROUND
		do
			create l_string_list.make (1)
			l_string_list.extend ("ressources/images/board2.png")
			create l_game_board.make (a_screen, l_string_list, 200, 150)
			l_event_ptr := sizeof_event_ptr
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
					end
				end
				l_game_board.apply
				refresh_screen (a_screen)
			end
			l_game_board.destroy
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
