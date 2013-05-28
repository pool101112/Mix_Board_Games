note
	description: "Summary description for {IMAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IMAGE

feature {NONE} -- Chargement des images

	load_image_list (a_path_list:LIST[STRING])
	-- Lance le chargement des images de la liste `a_path_list'
		require
			a_path_list_not_empty: not a_path_list.is_empty
		deferred
		end

	free_surfaces
		deferred
		end

	create_list (a_length:INTEGER_16)
	-- Cr�� une liste de taille `a_length' contenant les pointeurs des images
		do
			create {ARRAYED_LIST[POINTER]} surface_ptr_list.make (a_length)
		end

	load_image (a_path:STRING)
	-- Charge l'image situ� au chemin `a_path'
		require
			a_path_is_not_empty: not a_path.is_empty
		local
			l_path_c:C_STRING
		do
			create l_path_c.make (a_path)
			surface_ptr_list.extend ({SDL_IMAGE_WRAPPER}.IMG_Load (l_path_c.item))
		ensure
			last_ptr_is_not_null: not surface_ptr_list.last.is_default_pointer
		end

feature {NONE} -- Application d'une image

	apply_surface_to_screen
	-- Applique l'image `surface_ptr' sur la surface `screen'
		do
			if {SDL_IMAGE_WRAPPER}.SDL_BlitSurface(surface_ptr, create{POINTER}, screen, create{POINTER}) < 0 then
				set_error_flag
			end
		end

feature {NONE} -- Changement des variables (Set)

	set_x (a_x:INTEGER_16)
	-- Change la coordonn�e `x' pour `a_x'
		do
			x := a_x
		ensure
			x_is_set: x = a_x
		end

	set_y (a_y:INTEGER_16)
	-- Change la coordonn�e `y' pour `a_y'
		do
			y := a_y
		ensure
			y_is_set: y = a_y
		end

	set_w
	-- Change la valeur de w pour la largeur de `surface_ptr'
		require
			surface_ptr_is_not_null: not surface_ptr.is_default_pointer
		do
			w := {SDL_IMAGE_WRAPPER}.get_surface_width (surface_ptr)
		end

	set_h
	-- Change la valeur de h pour la hauteur de `surface_ptr'
		require
			surface_ptr_is_not_null: not surface_ptr.is_default_pointer
		do
			h := {SDL_IMAGE_WRAPPER}.get_surface_height (surface_ptr)
		end

	set_surface_ptr (a_index:INTEGER_8)
	-- Change le pointeur actuel pour `a_surface_ptr_list[`a_index']'
		require
			a_index_is_above_0: a_index > 0
		do
			surface_ptr := surface_ptr_list[a_index]
		ensure
			surface_ptr_is_not_null: not surface_ptr.is_default_pointer
		end

feature {NONE} -- Erreur

	set_error_flag
	-- Applique un flag indiquant qu'une erreur a eu lieu
		do
			is_error := true
			ensure
				is_error_true: is_error = true
		end

feature {NONE} -- Variables de classe

	surface_ptr:POINTER
	-- Pointeur d'une surface
	surface_ptr_list:LIST[POINTER]
	-- Liste de pointeurs de surfaces
	screen:POINTER
	-- Pointeur de la surface de l'�cran
	x:INTEGER_16 assign set_x
	-- Coordonn�e horizontale de l'image
	y:INTEGER_16 assign set_y
	-- Coordonn�e verticale de l'image
	w:INTEGER_32
	-- Largeur de l'image
	h:INTEGER_32
	-- Hauteur de l'image
	is_error:BOOLEAN
	-- Confirmation d'une erreur

invariant
	is_error_is_false: is_error = false
	w_is_above_0: w > 0
	h_is_above_0: h > 0

end
