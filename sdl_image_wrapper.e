note
	description: "Summary description for {SDL_IMAGE_WRAPPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SDL_IMAGE_WRAPPER

feature {GAME} -- Initialisations et fermetures

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

	frozen SDL_SetVideoMode (width, height, bitsperpixel:INTEGER; flags:NATURAL_32):POINTER
	-- Initialise l'�cran
		external
			"C (int, int, int, Uint32):SDL_Surface | <SDL.h>"
		alias
			"SDL_SetVideoMode"
		end

feature {IMAGE, GAME} -- Chargement et d�chargement des images

	frozen IMG_Load (file:POINTER):POINTER
	-- Pointeur de l'image cr��e
		external
			"C (const char*):SDL_Surface * | <SDL_image.h>"
		alias
			"IMG_Load"
		end

	frozen SDL_FreeSurface (surface:POINTER)
	-- D�charge l'image
		external
			"C (SDL_Surface *) | <SDL.h>"
		alias
			"SDL_FreeSurface"
		end

feature {IMAGE, GAME} -- Affichage

	frozen SDL_BlitSurface (src, srcrect, dst, dstrect:POINTER):INTEGER
	-- Valeur indiquant si une erreur est survenue lors de l'application de l'image
		external
			"C (SDL_Surface *, SDL_Rect *, SDL_Surface *, SDL_Rect *):int | <SDL.h>"
		alias
			"SDL_BlitSurface"
		end

	frozen SDL_Flip (screen:POINTER):INTEGER
	-- Valeur indiquant si une erreur est survenue lors du rafra�chissement
		external
			"C (SDL_Surface *):int | <SDL.h>"
		alias
			"SDL_Flip"
		end

feature {IMAGE} -- Gets

	frozen get_surface_width (SDL_Surface:POINTER):INTEGER
	-- Largeur de la surface
		external
			"C [struct <SDL.h>] (struct SDL_Surface):int"
		alias
			"w"
		end

	frozen get_surface_height (SDL_Surface:POINTER):INTEGER
	-- Hauteur de la surface
		external
			"C [struct <SDL.h>] (struct SDL_Surface):int"
		alias
			"h"
		end

feature {GAME} -- Constantes

	frozen SDL_INIT_VIDEO:NATURAL_32
	-- Valeur de la constante SDL_INIT_VIDEO
	-- Cette constante est utilis�e pour lancer le sous-syst�me vid�o
		external
			"C inline use <SDL.h>"
		alias
			"SDL_INIT_VIDEO"
		end

	frozen SDL_SWSURFACE:NATURAL_32
	-- Valeur de la constante SDL_SWSURFACE
	-- Cette constante est utilis�e pour cr�er la surface dans la m�moire du syst�me
		external
			"C inline use <SDL.h>"
		alias
			"SDL_SWSURFACE"
		end

	frozen SDL_FULLSCREEN:NATURAL_32
	-- Valeur de la constante SDL_FULLSCREEN
	-- Cette constante est utilis�e pour un affichage plein �cran
		external
			"C inline use <SDL.h>"
		alias
			"SDL_FULLSCREEN"
		end

end
