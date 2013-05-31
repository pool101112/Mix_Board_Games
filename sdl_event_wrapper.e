note
	description: "[Cette classe est un wrapper englobant des fonctions de la librairie SDL 1.2 servant � la gestion des �v�nements.]"
	author: "Marc-Andr� Douville Auger"
	copyright: "Copyright (c) 2013, Marc-Andr� Douville Auger"
	date: "30 Mai 2013"
	revision: "0.13.05.30"

class
	SDL_EVENT_WRAPPER

feature {GAME} -- Gestion des �v�nements

	frozen SDL_PollEvent (event:POINTER):INTEGER
	-- Valeur de l'�v�nement `event'
		external
			"C (SDL_Event *):int | <SDL.h>"
		alias
			"SDL_PollEvent"
		end


feature {GAME} -- Size of

	frozen sizeof_SDL_Event:INTEGER
	-- Espace n�cessaire pour un SDL_Event
		external
			"C inline use <SDL.h>"
		alias
			"sizeof(SDL_Event)"
		end


feature {GAME} -- Gets
	frozen get_SDL_Event_type (SDL_Event:POINTER):NATURAL_8
	-- Valeur du type d'�v�nement
		external
			"C [struct <SDL.h>] (SDL_Event):Uint8"
		alias
			"type"
		end

feature {GAME} -- �v�nements de la souris

	frozen get_SDL_MouseButtonEvent_button (SDL_MouseButtonEvent:POINTER):NATURAL_8
	-- Valeur du bouton appuy� de la souris
		external
			"C [struct <SDL.h>] (SDL_MouseButtonEvent):Uint8"
		alias
			"button"
		end

	frozen get_mouse_x (SDL_MouseButtonEvent:POINTER):NATURAL_16
	-- Coordonn�e horizontale de la souris
		external
			"C [struct <SDL.h>] (SDL_MouseButtonEvent):Uint16 *"
		alias
			"x"
		end

	frozen get_mouse_y (SDL_MouseButtonEvent:POINTER):NATURAL_16
	-- Coordonn�e verticale de la souris
		external
			"C [struct <SDL.h>] (SDL_MouseButtonEvent):Uint16 *"
		alias
			"y"
		end

feature {GAME} -- Constantes de la souris

	frozen SDL_MOUSEBUTTONDOWN:NATURAL_8
	-- Valeur de l'appuie d'un bouton de la souris
		external
			"C inline use <SDL.h>"
		alias
			"SDL_MOUSEBUTTONDOWN"
		end

	frozen SDL_BUTTON_LEFT:NATURAL_8
	-- Valeur du bouton gauche de la souris
		external
			"C inline use <SDL.h>"
		alias
			"SDL_BUTTON_LEFT"
		end

	frozen SDL_BUTTON_RIGHT:NATURAL_8
	-- Valeur du bouton droit de la souris
		external
			"C inline use <SDL.h>"
		alias
			"SDL_BUTTON_RIGHT"
		end

feature {GAME} -- Constantes g�n�rales

	frozen SDL_QUIT:NATURAL_8
	-- Valeur de l'�v�nement de SDL_QUIT
		external
			"C inline use <SDL.h>"
		alias
			"SDL_QUIT"
		end

end
