note
	description: "[Gestion principale du jeu. Cette classe appele la plupart des autres classes pour faire fonctionner le jeu.]"
	author: "Marc-André Douville Auger"
	copyright: "Copyright (c) 2013, Marc-André Douville Auger"
	date: "27 Mai 2013"
	revision: "0.13.04.22"

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
			main_menu (l_screen)
			quit
		end

feature {NONE} -- Menus

	main_menu (a_screen:POINTER)
	-- Affiche le menu principal
		require
			a_screen_is_not_null: not a_screen.is_default_pointer
		local
			l_string_list:ARRAYED_LIST[STRING]
			l_event_ptr:POINTER
			l_quit:BOOLEAN

			l_background:BACKGROUND
			l_chess_button, l_checkers_button, l_reversi_button:MENU
		do
			create l_string_list.make (1)
			l_string_list.extend ("ressources/images/main_menu.png")
			create l_background.make (a_screen, l_string_list)
			l_string_list.wipe_out
			l_string_list.extend ("ressources/images/bouton_echecs.png")
			create l_chess_button.make (a_screen, l_string_list, 265, 200)
			l_string_list.wipe_out
			l_string_list.extend ("ressources/images/bouton_dames.png")
			create l_checkers_button.make (a_screen, l_string_list, 265, 300)
			l_string_list.wipe_out
			l_string_list.extend ("ressources/images/bouton_othello.png")
			create l_reversi_button.make (a_screen, l_string_list, 265, 400)
			l_event_ptr := sizeof_event_ptr
			from
			until
				l_quit
			loop
				from
				until
					{SDL_EVENT_WRAPPER}.SDL_PollEvent (l_event_ptr) < 1
				loop
					if click (l_event_ptr) then
						l_quit := true
					end
				end
				l_background.apply
				l_chess_button.apply
				l_checkers_button.apply
				l_reversi_button.apply
				refresh_screen (a_screen)
			end
			l_background.destroy
			l_chess_button.destroy
			l_checkers_button.destroy
			l_reversi_button.destroy
		end

feature {NONE} -- Fonctions autres de la librairie SDL (Quit, etc.)

	quit
	-- Quitte et ferme les systèmes de la librairie SDL
		do
			{SDL_IMAGE_WRAPPER}.SDL_Quit
		end

feature {NONE} -- Fonctions des images de la librairie SDL

	init_video
	-- Initialise le mode vidéo
		do
			if {SDL_IMAGE_WRAPPER}.SDL_Init ({SDL_IMAGE_WRAPPER}.SDL_INIT_VIDEO) < 0 then
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
