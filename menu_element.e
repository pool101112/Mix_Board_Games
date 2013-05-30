note
	description: "Summary description for {MENU}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_ELEMENT

inherit
	IMAGE

create
	make

feature {GAME} -- Constructeur

	make (a_screen:POINTER; a_path_list:LIST[STRING]; a_x, a_y:INTEGER_16)
	-- Initialise `Current'
		require
			a_screen_is_not_null: not a_screen.is_default_pointer
			a_path_list_is_not_empty: not a_path_list.is_empty
		do
			screen := a_screen
			create_surface_area
			load_image_list (a_path_list)
			set_surface_ptr (1)
			set_w
			set_h
			set_x (a_x)
			set_y (a_y)
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

feature {GAME} -- Dimensions

	width:INTEGER_16
	-- Largeur de l'élément `current'
		do
			result := w
		ensure
			result_is_equal_to_w: result = w
		end

	height:INTEGER_16
	-- Hauteur de l'élément `current'
		do
			result := h
		ensure
			result_is_equal_to_h: result = h
		end

feature {GAME} -- Coordonnées de l'emplacement

	change_position (a_x, a_y:INTEGER_16)
	-- Change la position de l'élément sur la surface
		require
			a_x_is_at_least_0: a_x >= 0
			a_y_is_at_least_0: a_y >= 0
		do
			set_x (a_x)
			set_y (a_y)
		end

feature {NONE} -- Variables de classe

	alpha_value:NATURAL_8
	-- Valeur alpha utilisée lors de la transparence
end
