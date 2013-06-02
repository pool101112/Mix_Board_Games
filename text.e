note
	description: "Summary description for {TEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT

inherit
	IMAGE

create
	make

feature {GAME} -- Constructeur

	make (a_screen:POINTER; a_text:STRING; a_x, a_y:INTEGER_16)
	-- Initialise `current'
	do

	end
	
feature {NONE} -- Chargement des images

	load_image_list (a_path_list:LIST[STRING])
	-- Charge les images à partir des chemins dans `a_path_list'
		local
			l_i:INTEGER_8
		do
			create_list (a_path_list.count.as_integer_16)
			from
				l_i := 1
			until
				l_i > a_path_list.count
			loop
				load_image (a_path_list[l_i])
				l_i := l_i + 1
			end
		end

feature {GAME} -- Affichage

	set_transparancy (a_value:NATURAL_8)
	-- Applique la transparence
		require
			a_value_is_at_least_0: a_value >= 0
		do
			alpha_value := a_value
		end

	apply
	-- Applique l'image à `screen'
		do
			apply_transparancy (alpha_value)
			apply_surface_to_screen
		end

feature {GAME} -- Destructeur

	destroy
	-- Libère la mémoire alloué pour `current'
		do
			free_surfaces
		end

	free_surfaces
	-- Libère les surfaces
		do
			{SDL_IMAGE_WRAPPER}.SDL_FreeSurface (surface_ptr)
		end

feature {GAME} -- Variables de classe

	alpha_value:NATURAL_8
	-- Valeur alpha utilisée lors de la transparence

end
