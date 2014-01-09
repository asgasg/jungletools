-- mods/jungletools/init.lua

minetest.register_abm({
	nodenames = {"default:leaves"},
	interval = 120,
	chance = 1000,
	action = function(pos)
		minetest.add_node(pos, {name="default:jungleleaves"})
	end,
})

minetest.register_craft({
	type = "shapeless",
	output = "jungletools:jungle_spore 3",
	recipe = {"default:gold_lump", "default:jungleleaves", "default:jungleleaves"},
})

minetest.register_craftitem("jungletools:jungle_spore", {
	description = "Jungle Spore",
	inventory_image = "jungletools_jungle_spore.png",
})

minetest.register_craftitem("jungletools:jungle_dust", {
	description = "Jungle Dust",
	inventory_image = "jungletools_jungle_dust.png",
})

minetest.register_craft({
	output = "jungletools:jungle_bar",
	recipe = {
		{"jungletools:jungle_dust","jungletools:jungle_dust","jungletools:jungle_dust"},
		{"","bucket:bucket_water",""},
	},
	replacements = {  
		{"bucket:bucket_water", "bucket:bucket_empty"}, 
	},
})

minetest.register_craftitem("jungletools:jungle_bar", {
	description = "Jungle Bar",
	inventory_image = "jungletools_jungle_bar.png",
})

minetest.register_craft({
	output = "jungletools:sword_jungle",
	recipe = {
		{"jungletools:jungle_bar"},
		{"jungletools:jungle_bar"},
		{"group:stick"},
	}
})

minetest.register_tool("jungletools:sword_jungle", {
	description = "Blade of Grass",
	inventory_image = "jungletools_jungle_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.60, [2]=1.00, [3]=0.60}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	}
})

minetest.register_craft({
	output = "jungletools:pax_jungle",
	recipe = {
		{"jungletools:jungle_bar","jungletools:jungle_bar","jungletools:jungle_bar"},
		{"jungletools:jungle_bar","group:stick","jungletools:jungle_bar"},
		{"","group:stick",""},
	}
})

minetest.register_tool("jungletools:pax_jungle", {
	description = "Pax of Grass",
	inventory_image = "jungletools_jungle_pax.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=3,
		groupcaps={
			choppy = {times={[1]=1.50, [2]=0.80, [3]=0.50}, uses=40, maxlevel=2},
			cracky = {times={[1]=1.50, [2]=0.80, [3]=0.50}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_craft({
	output = "jungletools:shovel_jungle",
	recipe = {
		{"jungletools:jungle_bar"},
		{"group:stick"},
		{"group:stick"},
	}
})

minetest.register_tool("jungletools:shovel_jungle", {
	description = "Spear of Grass",
	inventory_image = "jungletools_jungle_shovel.png",
	wield_image = "jungletools_jungle_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.80, [3]=0.40}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_craft({
	output = "jungletools:hoe_jungle",
	recipe = {
		{"","jungletools:jungle_bar",""},
		{"jungletools:jungle_bar","group:stick","jungletools:jungle_bar"},
		{"","group:stick",""},
	}
})


--code initially from qwrwed

if minetest.get_modpath("technic") then	
	technic.register_grinder_recipe({input="jungletools:jungle_spore", output="jungletools:jungle_dust 1"})
end

minetest.register_tool("jungletools:hoe_jungle", {
    description = "Staff of Grass",
    inventory_image = "jungletools_jungle_hoe.png",
    liquids_pointable = true,
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then
            return
        end
        node = minetest.get_node(pointed_thing.under)
        liquiddef = bucket.liquids["default:water_source"]
        if liquiddef ~= nil and liquiddef.itemname ~= nil and (node.name == liquiddef.source or
            (node.name == "default:water_source"or node.name == "default:lava_source")) then
            minetest.add_node(pointed_thing.under, {name="default:dirt_with_grass"})
        itemstack:add_wear(65535/70)
        return itemstack
        end
    end
})

minetest.register_craft({
		output = "jungletools:block_jungle",
		recipe = {
				{"jungletools:jungle_bar","jungletools:jungle_bar","jungletools:jungle_bar"},
				{"jungletools:jungle_bar","jungletools:jungle_bar","jungletools:jungle_bar"},
				{"jungletools:jungle_bar","jungletools:jungle_bar","jungletools:jungle_bar"},
		}
})

minetest.register_craft({
	type = "shapeless",
	output = "jungletools:jungle_bar 9",
	recipe = {"jungletools:block_jungle"},
})
	
minetest.register_node("jungletools:block_jungle", {
    description = "Jungle Block",
	tiles = {"jungletools_jungle_block.png"},
	light_source = 4,
    groups = {cracky=1,level=3},
    sounds = default.node_sound_stone_defaults(),
})


minetest.register_craft({
	output = "jungletools:spore_grinder", 
	recipe = {
		{"default:steelblock","jungletools:jungle_spore","default:steelblock"},
		{"jungletools:jungle_spore","default:diamond","jungletools:jungle_spore"},
		{"default:steelblock","jungletools:jungle_spore","default:steelblock"},
	}
})

-- code initially by qwrwed
	
local sporegrinderformspec = 
	"size[8,8]"..
	"label[4,0;Spore Grinder]"..
	"list[current_name;spore;3,1;1,1;]"..
	"label[2,1;  Spore:]"..
	"list[current_name;dust;3,3;1,1;]"..
	"label[2,3; Dust:]"..
	"list[current_player;main;0,4;8,4;]"..
	"button[4,2;1,1;grind;Grind]"



minetest.register_node("jungletools:spore_grinder", {
	description = "Spore Grinder",
	tiles = {"spore_grinder_top.png", "spore_grinder_bottom.png", "spore_grinder_side.png", "spore_grinder_side.png", "spore_grinder_side.png", "spore_grinder_front.png"},
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",sporegrinderformspec)
		meta:set_string("infotext", "Spore Grinder")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		inv:set_size("spore", 1*1)
		inv:set_size("dust", 1*1)	
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname == "spore" then
			return stack:get_count()
		else
			return 0
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if to_list == "dust" then
			return 0
		else
			return 1
		end
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("spore") then
			return false
		elseif not inv:is_empty("dust") then
			return false
		end
		return true
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		local amount_spores = (inv:get_stack("spore", 1):get_count())
		local amount_dust = (inv:get_stack("dust", 1):get_count())
		if fields.grind then
			if inv:get_stack("spore", 1):get_name() == "jungletools:jungle_spore" and (inv:is_empty("dust") or inv:get_stack("dust", 1):get_name() == "jungletools:jungle_dust") then
				local amount_total = (amount_spores + amount_dust)
				if amount_total <= 99 then
					inv:add_item("dust", "jungletools:jungle_dust "..amount_spores)
					inv:remove_item("spore", "jungletools:jungle_spore "..amount_spores)
				else
					local amount_max = 99-amount_dust
					inv:add_item("dust", "jungletools:jungle_dust "..amount_max)
					inv:remove_item("spore", "jungletools:jungle_spore "..amount_max)
				end
			end
		end
	end,
	groups = {choppy=3,oddly_breakable_by_hand=3},
})




