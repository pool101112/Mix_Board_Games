note
	description: "[Cette classe est un wrapper englobant des fonctions de la librairie SDL 1.2 servant � la gestion des images.]"
	author: "Marc-Andr� Douville Auger"
	copyright: "Copyright (c) 2013, Marc-Andr� Douville Auger"
	date: "30 Mai 2013"
	revision: "0.13.05.30"

class
	SDL_IMAGE_WRAPPER

feature {GAME} -- Initialisation et fermeture

	frozen SDL_SetVideoMode (width, height, bitsperpixel:INTEGER; flags:NATURAL_32):POINTER
	-- Initialise l'�cran
		external
			"C (int, int, int, Uint32):SDL_Surface | <SDL.h>"
		alias
			"SDL_SetVideoMode"
		end

feature {IMAGE} -- Chargement et d�chargement des images

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

feature {IMAGE} -- Transparence

	frozen SDL_SetAlpha (surface:POINTER; flags:NATURAL_32; alpha:NATURAL_8):INTEGER
	-- Valeur alpha pour appliquer une transparance sur la surface
		external
			"C (SDL_Surface *, Uint32, Uint8):int | <SDL.h>"
		alias
			"SDL_SetAlpha"
		end

feature {IMAGE} -- SizeOf

	frozen sizeof_SDL_Rect:INTEGER
	-- Espace n�cessaire pour un SDL_Rect
		external
			"C inline use <SDL.h>"
		alias
			"sizeof(SDL_Rect)"
		end
feature {IMAGE} -- Gets

	frozen get_surface_width (SDL_Surface:POINTER):INTEGER_16
	-- Largeur de la surface
		external
			"C [struct <SDL.h>] (struct SDL_Surface):int"
		alias
			"w"
		end

	frozen get_surface_height (SDL_Surface:POINTER):INTEGER_16
	-- Hauteur de la surface
		external
			"C [struct <SDL.h>] (struct SDL_Surface):int"
		alias
			"h"
		end

feature {IMAGE} -- Sets

	frozen set_surface_area_x (SDL_Rect:POINTER; value:INTEGER_16)
	-- Change la coordonn�e horizontale d'un SDL_Rect
		external
			"C [struct <SDL.h>] (struct SDL_Rect, Sint16)"
		alias
			"x"
		end

	frozen set_surface_area_y (SDL_Rect:POINTER; value:INTEGER_16)
	-- Change la coordonn�e verticale d'un SDL_Rect
		external
			"C [struct <SDL.h>] (struct SDL_Rect, Sint16)"
		alias
			"y"
		end

	frozen set_surface_area_w (SDL_Rect:POINTER; value:INTEGER_16)
	-- Change la largeur d'un SDL_Rect
		external
			"C [struct <SDL.h>] (struct SDL_Rect, Sint16)"
		alias
			"w"
		end

	frozen set_surface_area_h (SDL_Rect:POINTER; value:INTEGER_16)
	-- Change la hauteur d'un SDL_Rect
		external
			"C [struct <SDL.h>] (struct SDL_Rect, Sint16)"
		alias
			"h"
		end


feature {GAME, IMAGE} -- Constantes

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

	frozen SDL_SRCALPHA:NATURAL_32
	-- Valeur de la constante SDL_SRCALPHA
	-- Cette constante est utilis�e pour que les valeurs alphas ne soient pas ignor�es
		external
			"C inline use <SDL.h>"
		alias
			"SDL_SRCALPHA"
		end

	frozen SDL_RLEACCEL:NATURAL_32
	-- Valeur de la constante SDL_RLEACCEL
	-- Cette constante est utilis�e pour ne pas subir de ralentissement lors du blitsurface
		external
			"C inline use <SDL.h>"
		alias
			"SDL_RLEACCEL"
		end

end
