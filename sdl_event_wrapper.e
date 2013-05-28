note
	description: "Summary description for {SDL_EVENT_WRAPPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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

	frozen sizeof_SDL_Event:INTEGER
	-- Espace n�cessaire pour un SDL_Event
		external
			"C inline use <SDL.h>"
		alias
			"sizeof(SDL_Event)"
		end

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

end
