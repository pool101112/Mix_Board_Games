note
	description: "Summary description for {BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

inherit
	IMAGE

create
	make

feature {GAME} -- Constructeur

	make (a_path_list:LIST[STRING])
		do

		end

feature {NONE} -- Chargement des images

	load_image_list (a_path_list:LIST[STRING])
	-- Charge les images � partir des chemins dans `a_path_list'
		local
			l_i:INTEGER_8
		do
			from
				l_i := 1
			until
				l_i > a_path_list.count
			loop
				load_image (a_path_list[l_i])
			end
		end

feature {GAME} -- Destructeur

	destroy
	-- Lib�re la m�moire allou� pour `current'
		do
			free_surfaces
		end

	free_surfaces
	-- Lib�re les surfaces
		do
			{SDL_IMAGE_WRAPPER}.SDL_FreeSurface (surface_ptr)
		end
end
