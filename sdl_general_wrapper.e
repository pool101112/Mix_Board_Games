note
	description: "[Cette classe est un wrapper englobant des fonctions g�n�rales et autres de la librairie SDL 1.2.]"
	author: "Marc-Andr� Douville Auger"
	copyright: "Copyright (c) 2013, Marc-Andr� Douville Auger"
	date: "30 Mai 2013"
	revision: "0.13.05.30"

class
	SDL_GENERAL_WRAPPER

feature {GAME} -- Initialisation et fermeture

	frozen SDL_Init (flags:NATURAL_32):INTEGER
	-- Valeur indiquant si une erreur est survenue lors de l'initialisation
		external
			"C (Uint32):int | <SDL.h>"
		alias
			"SDL_Init"
		end

	frozen SDL_Quit ()
	-- Ferme tous les sous-syst�mes
		external
			"C | <SDL.h>"
		alias
			"SDL_Quit"
		end

feature {GAME} -- Temps

	frozen SDL_Delay (a_ms:NATURAL_32)
	-- Met l'application en attente pendant `a_ms' millisecondes
		external
			"C (Uint32) | <SDL.h>"
		alias
			"SDL_Delay"
		end

feature {GAME} -- Fen�tre

	frozen SDL_WM_SetCaption(title, icon:POINTER)
	-- Applique `title' comme nom de la fen�tre
		external
			"C inline use <SDL.h>"
		alias
			"SDL_WM_SetCaption((char *)$title, (char *)$icon)"
		end

	frozen SDL_WM_SetIcon(icon:POINTER; mask:POINTER)
	-- Applique `icon' comme ic�ne de la fen�tre
		external
			"C inline use <SDL.h>"
		alias
			"SDL_WM_SetIcon((SDL_Surface *)$icon, (Uint8 *)$mask)"
		end
end
