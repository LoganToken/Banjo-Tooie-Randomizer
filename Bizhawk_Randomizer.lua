local p_top_of_temple = 0x46;
local p_bill_drill = 0x1E;
local p_bill_drill_bit = 2;
local flag_block_pointer = 0x12C770;

local check_array = {
	{byte=0x45, bit=0, name="Jiggy: MT: Targitzan", type="Jiggy"},
	{byte=0x45, bit=1, name="Jiggy: MT: Targitzan's Slightly Sacred Chamber", type="Jiggy"},
	{byte=0x45, bit=2, name="Jiggy: MT: Kickball", type="Jiggy"},
	{byte=0x45, bit=3, name="Jiggy: MT: Bovina", type="Jiggy"},
	{byte=0x45, bit=4, name="Jiggy: MT: Treasure Chamber", type="Jiggy"},
	{byte=0x45, bit=5, name="Jiggy: MT: Jade Snake Grove: Golden Goliath", type="Jiggy"},
	{byte=0x45, bit=6, name="Jiggy: MT: Prison Compound Quicksand", type="Jiggy"},
	{byte=0x45, bit=7, name="Jiggy: MT: Pillars", type="Jiggy"},
	{byte=0x46, bit=0, name="Jiggy: MT: Top of Temple", type="Jiggy"},
	{byte=0x46, bit=1, name="Jiggy: MT: Ssslumber", type="Jiggy"},
	{byte=0x46, bit=2, name="Jiggy: GGM: Old King Coal", type="Jiggy"},
	{byte=0x46, bit=3, name="Jiggy: GGM: Canary Mary Race", type="Jiggy"},
	{byte=0x46, bit=4, name="Jiggy: GGM: Generator Cavern", type="Jiggy"},
	{byte=0x46, bit=5, name="Jiggy: GGM: Waterfall Cavern", type="Jiggy"},
	{byte=0x46, bit=6, name="Jiggy: GGM: Ordnance Storage", type="Jiggy"},
	{byte=0x46, bit=7, name="Jiggy: GGM: Dilberta", type="Jiggy"},
	{byte=0x47, bit=0, name="Jiggy: GGM: Crushing Shed", type="Jiggy"},
	{byte=0x47, bit=1, name="Jiggy: GGM: Waterfall", type="Jiggy"},
	{byte=0x47, bit=2, name="Jiggy: GGM: Power Hut Basement", type="Jiggy"},
	{byte=0x47, bit=3, name="Jiggy: GGM: Flooded Caves", type="Jiggy"},
	{byte=0x47, bit=4, name="Jiggy: WW: Hoop Hurry", type="Jiggy"},
	{byte=0x47, bit=5, name="Jiggy: WW: Dodgems", type="Jiggy"},
	{byte=0x47, bit=6, name="Jiggy: WW: Mr. Patch", type="Jiggy"},
	{byte=0x47, bit=7, name="Jiggy: WW: Saucer of Peril", type="Jiggy"},
	{byte=0x48, bit=0, name="Jiggy: WW: Balloon Burst", type="Jiggy"},
	{byte=0x48, bit=1, name="Jiggy: WW: Dive of Death", type="Jiggy"},
	{byte=0x48, bit=2, name="Jiggy: WW: Mrs. Boggy", type="Jiggy"},
	{byte=0x48, bit=3, name="Jiggy: WW: Star Spinner", type="Jiggy"},
	{byte=0x48, bit=4, name="Jiggy: WW: The Inferno", type="Jiggy"},
	{byte=0x48, bit=5, name="Jiggy: WW: Cactus of Strength", type="Jiggy"},
	{byte=0x48, bit=6, name="Jiggy: JRL: Mini-Sub Challenge", type="Jiggy"},
	{byte=0x48, bit=7, name="Jiggy: JRL: Tiptup", type="Jiggy"},
	{byte=0x49, bit=0, name="Jiggy: JRL: Chris P. Bacon", type="Jiggy"},
	{byte=0x49, bit=1, name="Jiggy: JRL: Piglet's Pool", type="Jiggy"},
	{byte=0x49, bit=2, name="Jiggy: JRL: Smuggler's Cavern", type="Jiggy"},
	{byte=0x49, bit=3, name="Jiggy: JRL: Merry Maggie Malpass", type="Jiggy"},
	{byte=0x49, bit=4, name="Jiggy: JRL: Lord Woo Fak Fak", type="Jiggy"},
	{byte=0x49, bit=5, name="Jiggy: JRL: Seemee", type="Jiggy"},
	{byte=0x49, bit=6, name="Jiggy: JRL: Pawno's", type="Jiggy"},
	{byte=0x49, bit=7, name="Jiggy: JRL: UFO", type="Jiggy"},
	{byte=0x4A, bit=0, name="Jiggy: TDL: Under Terry's Nest", type="Jiggy"},
	{byte=0x4A, bit=1, name="Jiggy: TDL: Dippy", type="Jiggy"},
	{byte=0x4A, bit=2, name="Jiggy: TDL: Scrotty", type="Jiggy"},
	{byte=0x4A, bit=3, name="Jiggy: TDL: Terry Defeated", type="Jiggy"},
	{byte=0x4A, bit=4, name="Jiggy: TDL: Oogle Boogle Tribe", type="Jiggy"},
	{byte=0x4A, bit=5, name="Jiggy: TDL: Chompa's Belly", type="Jiggy"},
	{byte=0x4A, bit=6, name="Jiggy: TDL: Terry's Babies Hatched", type="Jiggy"},
	{byte=0x4A, bit=7, name="Jiggy: TDL: Stomping Plains", type="Jiggy"},
	{byte=0x4B, bit=0, name="Jiggy: TDL: Rocknut Tribe", type="Jiggy"},
	{byte=0x4B, bit=1, name="Jiggy: TDL: Code of the Dinosaurs", type="Jiggy"},
	{byte=0x4B, bit=2, name="Jiggy: GI: Waste Disposal Underwater", type="Jiggy"},
	{byte=0x4B, bit=3, name="Jiggy: GI: Weldar", type="Jiggy"},
	{byte=0x4B, bit=4, name="Jiggy: GI: Clinker's Cavern", type="Jiggy"},
	{byte=0x4B, bit=5, name="Jiggy: GI: Laundry", type="Jiggy"},
	{byte=0x4B, bit=6, name="Jiggy: GI: Floor 5", type="Jiggy"},
	{byte=0x4B, bit=7, name="Jiggy: GI: Quality Control", type="Jiggy"},
	{byte=0x4C, bit=0, name="Jiggy: GI: Floor 1 Guarded", type="Jiggy"},
	{byte=0x4C, bit=1, name="Jiggy: GI: Trash Compactor", type="Jiggy"},
	{byte=0x4C, bit=2, name="Jiggy: GI: Packing Room", type="Jiggy"},
	{byte=0x4C, bit=3, name="Jiggy: GI: Waste Disposal Box", type="Jiggy"},
	{byte=0x4C, bit=4, name="Jiggy: HFP: Dragon Brothers Defeated", type="Jiggy"},
	{byte=0x4C, bit=5, name="Jiggy: HFP: Inside the Volcano", type="Jiggy"},
	{byte=0x4C, bit=6, name="Jiggy: HFP: Sabreman", type="Jiggy"},
	{byte=0x4C, bit=7, name="Jiggy: HFP: Boggy", type="Jiggy"},
	{byte=0x4D, bit=0, name="Jiggy: HFP: Icy Side Train Station", type="Jiggy"},
	{byte=0x4D, bit=1, name="Jiggy: HFP: Oil Drill", type="Jiggy"},
	{byte=0x4D, bit=2, name="Jiggy: HFP: Stomping Plains Connection", type="Jiggy"},
	{byte=0x4D, bit=3, name="Jiggy: HFP: Kickball", type="Jiggy"},
	{byte=0x4D, bit=4, name="Jiggy: HFP: Alien", type="Jiggy"},
	{byte=0x4D, bit=5, name="Jiggy: HFP: Lava Waterfall", type="Jiggy"},
	{byte=0x4D, bit=6, name="Jiggy: CCL: Mingy Jongo", type="Jiggy"},
	{byte=0x4D, bit=7, name="Jiggy: CCL: Mr. Fit", type="Jiggy"},
	{byte=0x4E, bit=0, name="Jiggy: CCL: Pot o' Gold", type="Jiggy"},
	{byte=0x4E, bit=1, name="Jiggy: CCL: Canary Mary", type="Jiggy"},
	{byte=0x4E, bit=2, name="Jiggy: CCL: Zubba's Nest", type="Jiggy"},
	{byte=0x4E, bit=3, name="Jiggy: CCL: Eyeballus Jiggium Plant", type="Jiggy"},
	{byte=0x4E, bit=4, name="Jiggy: CCL: Cheese Wedge", type="Jiggy"},
	{byte=0x4E, bit=5, name="Jiggy: CCL: Trash Can", type="Jiggy"},
	{byte=0x4E, bit=6, name="Jiggy: CCL: Superstash", type="Jiggy"},
	{byte=0x4E, bit=7, name="Jiggy: CCL: Jelly Castle", type="Jiggy"},
	{byte=0x4F, bit=0, name="Jiggy: IoH: White Jinjo Family", type="Jiggy"},
	{byte=0x4F, bit=1, name="Jiggy: IoH: Orange Jinjo Family", type="Jiggy"},
	{byte=0x4F, bit=2, name="Jiggy: IoH: Yellow Jinjo Family", type="Jiggy"},
	{byte=0x4F, bit=3, name="Jiggy: IoH: Brown Jinjo Family", type="Jiggy"},
	{byte=0x4F, bit=4, name="Jiggy: IoH: Green Jinjo Family", type="Jiggy"},
	{byte=0x4F, bit=5, name="Jiggy: IoH: Red Jinjo Family", type="Jiggy"},
	{byte=0x4F, bit=6, name="Jiggy: IoH: Blue Jinjo Family", type="Jiggy"},
	{byte=0x4F, bit=7, name="Jiggy: IoH: Purple Jinjo Family", type="Jiggy"},
	{byte=0x50, bit=0, name="Jiggy: IoH: Black Jinjo Family", type="Jiggy"},
	{byte=0x50, bit=1, name="Jiggy: IoH: King Jingaling Intro", type="Jiggy"}
};

local ability_array = {
	{byte=0x18, bit=5, name="Ability: Beak Barge", nomap=true, type="Ability"},
	{byte=0x18, bit=6, name="Ability: Beak Bomb", nomap=true, type="Ability"},
	{byte=0x18, bit=7, name="Ability: Beak Buster", nomap=true, type="Ability"},
	--{byte=0x19, bit=0, name="Ability: Seen Camera Tutorial?"}, -- Set on boot
	{byte=0x19, bit=1, name="Ability: Bear Punch Replacement Peck", nomap=true, type="Ability"},
	{byte=0x19, bit=2, name="Ability: Climb Trees", nomap=true, type="Ability"},
	{byte=0x19, bit=3, name="Ability: Blue Eggs", nomap=true, type="Ability"},
	{byte=0x19, bit=4, name="Ability: Feathery Flap", nomap=true, type="Ability"},
	{byte=0x19, bit=5, name="Ability: Flap Flip", nomap=true, type="Ability"},
	{byte=0x19, bit=6, name="Ability: Fly Pad", nomap=true, type="Ability"},
	{byte=0x19, bit=7, name="Ability: Full Jump Height", nomap=true, type="Ability"},
	{byte=0x1A, bit=0, name="Ability: Rat-a-tat Rap", nomap=true, type="Ability"},
	{byte=0x1A, bit=1, name="Ability: Roll", nomap=true, type="Ability"},
	{byte=0x1A, bit=2, name="Ability: Shock Spring Pad", nomap=true, type="Ability"},
	{byte=0x1A, bit=3, name="Ability: Wading Boots", nomap=true, type="Ability"},
	{byte=0x1A, bit=4, name="Ability: Dive", nomap=true, type="Ability"},
	{byte=0x1A, bit=5, name="Ability: Talon Trot", nomap=true, type="Ability"},
	{byte=0x1A, bit=6, name="Ability: Turbo Trainers", nomap=true, type="Ability"},
	{byte=0x1A, bit=7, name="Ability: Wonderwing", nomap=true, type="Ability"},
	--{byte=0x1B, bit=0, name="FT Note Door Molehill Seen?", type="FTT"}, -- Set on boot
	{byte=0x1B, bit=1, name="Ability: Grip Grab", type="Ability"},
	{byte=0x1B, bit=2, name="Ability: Breegull Blaster", type="Ability"},
	{byte=0x1B, bit=3, name="Ability: Egg Aim", type="Ability"},
	-- 0x1B > 4
	--{byte=0x1B, bit=5, name="Ability: Fire/Grenade Eggs?", type="Ability"},
	{byte=0x1B, bit=6, name="Ability: Bill Drill", type="Ability"},
	{byte=0x1B, bit=7, name="Ability: Beak Bayonet", type="Ability"},
	{byte=0x1C, bit=0, name="Ability: Airborne Egg Aiming", type="Ability"}, -- TODO: Double Check
	{byte=0x1C, bit=1, name="Ability: Split Up", type="Ability"}, -- TODO: Double Check
	{byte=0x1C, bit=2, name="Ability: Wing Whack", type="Ability"}, -- TODO: Double Check
	{byte=0x1C, bit=3, name="Ability: Talon Torpedo", type="Ability"}, -- TODO: Double Check
	{byte=0x1C, bit=4, name="Ability: Sub-Aqua Egg Aiming", type="Ability"}, -- TODO: Double Check
	-- 0x1C > 5 - Talon Torpedo?
	{byte=0x1C, bit=6, name="Ability: Shack Pack", type="Ability"},
	{byte=0x1C, bit=7, name="Ability: Glide", type="Ability"},
	{byte=0x1D, bit=0, name="Ability: Snooze Pack", type="Ability"},
	{byte=0x1D, bit=1, name="Ability: Leg Spring", type="Ability"},
	{byte=0x1D, bit=2, name="Ability: Claw Clamber Boots", type="Ability"},
	{byte=0x1D, bit=3, name="Ability: Springy Step Shoes", type="Ability"},
	{byte=0x1D, bit=4, name="Ability: Taxi Pack", type="Ability"},
	{byte=0x1D, bit=5, name="Ability: Hatch", type="Ability"},
	{byte=0x1D, bit=6, name="Ability: Pack Whack", type="Ability"},
	{byte=0x1D, bit=7, name="Ability: Sack Pack", type="Ability"},
	{byte=0x1E, bit=0, name="Ability: Amaze-O-Gaze Goggles", type="Ability"},
	{byte=0x1E, bit=1, name="Ability: Fire Eggs", type="Ability"},
	{byte=0x1E, bit=2, name="Ability: Grenade Eggs", type="Ability"},
	{byte=0x1E, bit=3, name="Ability: Clockwork Kazooie Eggs", type="Ability"},
	{byte=0x1E, bit=4, name="Ability: Ice Eggs", type="Ability"},
	{byte=0x1E, bit=5, name="Ability: Fast Swimming", type="Ability"},
	{byte=0x1E, bit=6, name="FT Ability Use? (1)"}, -- Set on boot -- Egg Switch?
	{byte=0x1E, bit=7, name="Ability: Breegull Bash", type="Ability"},
	{byte=0x15, bit=6, name="Humba Wumba: Glowbo Paid (MT)", type="Glowbo Paid"},
	{byte=0x15, bit=7, name="Humba Wumba: Glowbo Paid (GGM)", type="Glowbo Paid"},
	{byte=0x16, bit=0, name="Humba Wumba: Glowbo Paid (WW)", type="Glowbo Paid"},
	{byte=0x16, bit=1, name="Humba Wumba: Glowbo Paid (JRL)", type="Glowbo Paid"},
	{byte=0x16, bit=2, name="Humba Wumba: Glowbo Paid (TDL)", type="Glowbo Paid"},
	{byte=0x16, bit=3, name="Humba Wumba: Glowbo Paid (GI)", type="Glowbo Paid"},
	{byte=0x16, bit=4, name="Humba Wumba: Glowbo Paid (HFP)", type="Glowbo Paid"},
	{byte=0x16, bit=5, name="Humba Wumba: Glowbo Paid (CCL)", type="Glowbo Paid"},
	{byte=0x16, bit=6, name="Humba Wumba: Glowbo Paid (IoH)", type="Glowbo Paid"},
	{byte=0x6A, bit=7, name="Mumbo: Glowbo Paid (MT)", type="Glowbo Paid"},
	{byte=0x6B, bit=0, name="Mumbo: Glowbo Paid (GGM)", type="Glowbo Paid"},
	{byte=0x6B, bit=1, name="Mumbo: Glowbo Paid (WW)", type="Glowbo Paid"},
	{byte=0x6B, bit=2, name="Mumbo: Glowbo Paid (JRL)", type="Glowbo Paid"},
	{byte=0x6B, bit=3, name="Mumbo: Glowbo Paid (TDL)", type="Glowbo Paid"},
	{byte=0x6B, bit=4, name="Mumbo: Glowbo Paid (HFP)", type="Glowbo Paid"},
	{byte=0x6B, bit=5, name="Mumbo: Glowbo Paid (CCL)", type="Glowbo Paid"},
	{byte=0x6B, bit=6, name="Mumbo: Glowbo Paid (IoH)", type="Glowbo Paid"},
	{byte=0x6B, bit=7, name="Mumbo: Glowbo Paid (GI)", type="Glowbo Paid"},
	{byte=0xA1, bit=4, name="Cheat Active: Double Maximum Feathers", type="Cheat"},
	{byte=0xA1, bit=5, name="Cheat Active: Double Maximum Eggs", type="Cheat"},
	{byte=0xA1, bit=6, name="Cheat Active: No Energy Loss From Falling", type="Cheat"},
	{byte=0xA1, bit=7, name="Cheat Active: Automatic Energy Regain", type="Cheat"},
	{byte=0xA2, bit=0, name="Cheat Active: Jolly's Jukebox", type="Cheat"},
	{byte=0xA2, bit=1, name="Cheat Active: Jiggywiggy Temple Signposts", type="Cheat"},
	{byte=0xA2, bit=2, name="Cheat Active: Fast Banjo", type="Cheat"},
	{byte=0xA2, bit=3, name="Cheat Active: Fast Baddies", type="Cheat"},
	{byte=0xA2, bit=4, name="Cheat Active: No Energy Or Air Loss", type="Cheat"},
	{byte=0xA2, bit=5, name="Cheat Active: Infinite Eggs And Feathers", type="Cheat"},
	{byte=0x04, bit=4, name="Cheat Active: Open Up All World Doors", type="Cheat"}
};

local internal_to_my_name_table = {
	["Jiggy: MT: Targitzan"] = "Targitzan",
	["Jiggy: MT: Targitzan's Slightly Sacred Chamber"] = "Slightly_Sacred_Chamber",
	["Jiggy: MT: Kickball"] = "MT_Kickball",
	["Jiggy: MT: Bovina"] = "Bovina",
	["Jiggy: MT: Treasure Chamber"] = "Relic_Thingy",
	["Jiggy: MT: Jade Snake Grove: Golden Goliath"] = "Golden_Goliath",
	["Jiggy: MT: Prison Compound Quicksand"] = "Swamp",
	["Jiggy: MT: Pillars"] = "Pillars",
	["Jiggy: MT: Top of Temple"] = "Top_Of_Temple",
	["Jiggy: MT: Ssslumber"] = "Ssslumber",
	["Jiggy: GGM: Old King Coal"] = "Old_King_Coal",
	["Jiggy: GGM: Canary Mary Race"] = "Canary_Mary_1",
	["Jiggy: GGM: Generator Cavern"] = "Generator_Cavern",
	["Jiggy: GGM: Waterfall Cavern"] = "Waterfall_Cavern",
	["Jiggy: GGM: Ordnance Storage"] = "Ordnance_Storage",
	["Jiggy: GGM: Dilberta"] = "Dilberta",
	["Jiggy: GGM: Crushing Shed"] = "Crushing_Shed",
	["Jiggy: GGM: Waterfall"] = "Small_Waterfall",
	["Jiggy: GGM: Power Hut Basement"] = "Power_Hut",
	["Jiggy: GGM: Flooded Caves"] = "Flooded_Caves",
	["Jiggy: WW: Hoop Hurry"] = "Hoop_Hurry",
	["Jiggy: WW: Dodgems"] = "Dodgem_Dome",
	["Jiggy: WW: Mr. Patch"] = "Patch",
	["Jiggy: WW: Saucer of Peril"] = "Saucer_of_Peril",
	["Jiggy: WW: Balloon Burst"] = "Balloon_Burst",
	["Jiggy: WW: Dive of Death"] = "Dive_of_Death",
	["Jiggy: WW: Mrs. Boggy"] = "Boggys_Kids",
	["Jiggy: WW: Star Spinner"] = "Star_Spinner",
	["Jiggy: WW: The Inferno"] = "Top_Of_Inferno",
	["Jiggy: WW: Cactus of Strength"] = "Cactus_of_Strength",
	["Jiggy: JRL: Mini-Sub Challenge"] = "Sub_Minigame",
	["Jiggy: JRL: Tiptup"] = "Tiptup",
	["Jiggy: JRL: Chris P. Bacon"] = "Chris_P_Bacon",
	["Jiggy: JRL: Piglet's Pool"] = "Pig_Pool",
	["Jiggy: JRL: Smuggler's Cavern"] = "Smugglers_Cavern",
	["Jiggy: JRL: Merry Maggie Malpass"] = "Merry_Maggie",
	["Jiggy: JRL: Lord Woo Fak Fak"] = "Lord_Woo_Fak_Fak",
	["Jiggy: JRL: Seemee"] = "Seemee_Fish",
	["Jiggy: JRL: Pawno's"] = "Pawno",
	["Jiggy: JRL: UFO"] = "Aliens",
	["Jiggy: TDL: Under Terry's Nest"] = "Terry_Nest",
	["Jiggy: TDL: Dippy"] = "Dippy",
	["Jiggy: TDL: Scrotty"] = "Styrac_Family",
	["Jiggy: TDL: Terry Defeated"] = "Terry",
	["Jiggy: TDL: Oogle Boogle Tribe"] = "Oogle_Boogles",
	["Jiggy: TDL: Chompa's Belly"] = "Chompa",
	["Jiggy: TDL: Terry's Babies Hatched"] = "Terrys_Kids",
	["Jiggy: TDL: Stomping Plains"] = "Stomping_Plains",
	["Jiggy: TDL: Rocknut Tribe"] = "Rocknuts_Jiggy",
	["Jiggy: TDL: Code of the Dinosaurs"] = "Roar_Cage",
	["Jiggy: GI: Waste Disposal Underwater"] = "Toxic_Waste_Pool",
	["Jiggy: GI: Weldar"] = "Weldar",
	["Jiggy: GI: Clinker's Cavern"] = "Clinkers_Cavern",
	["Jiggy: GI: Laundry"] = "Workers_Jiggy",
	["Jiggy: GI: Floor 5"] = "Attic",
	["Jiggy: GI: Quality Control"] = "Quality_Control",
	["Jiggy: GI: Floor 1 Guarded"] = "Tintops",
	["Jiggy: GI: Trash Compactor"] = "Trash_Compactor",
	["Jiggy: GI: Packing Room"] = "Twinklies_Packing",
	["Jiggy: GI: Waste Disposal Box"] = "Toxic_Waste_Box",
	["Jiggy: HFP: Dragon Brothers Defeated"] = "Dragon_Brothers",
	["Jiggy: HFP: Inside the Volcano"] = "Volcano",
	["Jiggy: HFP: Sabreman"] = "Sabreman",
	["Jiggy: HFP: Boggy"] = "Boggys_Fish",
	["Jiggy: HFP: Icy Side Train Station"] = "Ice_Train",
	["Jiggy: HFP: Oil Drill"] = "Oil_Drill",
	["Jiggy: HFP: Stomping Plains Connection"] = "Ice_Wall",
	["Jiggy: HFP: Kickball"] = "HFP_Kickball",
	["Jiggy: HFP: Alien"] = "Alien_Kids",
	["Jiggy: HFP: Lava Waterfall"] = "Colosseum",
	["Jiggy: CCL: Mingy Jongo"] = "Mingy_Jongo",
	["Jiggy: CCL: Mr. Fit"] = "Mr_Fit",
	["Jiggy: CCL: Pot o' Gold"] = "Pot_O_Gold",
	["Jiggy: CCL: Canary Mary"] = "Canary_Mary_3",
	["Jiggy: CCL: Zubba's Nest"] = "Zubbas",
	["Jiggy: CCL: Eyeballus Jiggium Plant"] = "Eyeball_Plants",
	["Jiggy: CCL: Cheese Wedge"] = "Cheese_Wedge",
	["Jiggy: CCL: Trash Can"] = "Trash_Can",
	["Jiggy: CCL: Superstash"] = "Superstash",
	["Jiggy: CCL: Jelly Castle"] = "Jelly_Castle",
	["Jiggy: IoH: White Jinjo Family"] = "White_Jinjos",
	["Jiggy: IoH: Orange Jinjo Family"] = "Orange_Jinjos",
	["Jiggy: IoH: Yellow Jinjo Family"] = "Yellow_Jinjos",
	["Jiggy: IoH: Brown Jinjo Family"] = "Brown_Jinjos",
	["Jiggy: IoH: Green Jinjo Family"] = "Green_Jinjos",
	["Jiggy: IoH: Red Jinjo Family"] = "Red_Jinjos",
	["Jiggy: IoH: Blue Jinjo Family"] = "Blue_Jinjos",
	["Jiggy: IoH: Purple Jinjo Family"] = "Purple_Jinjos",
	["Jiggy: IoH: Black Jinjo Family"] = "Black_Jinjos",
	["Jiggy: IoH: King Jingaling Intro"] = "King_Jingaling"
};

local my_to_internal_name_table = {
	["Placeholder_1"] = "Ability: Beak Barge",
	["Placeholder_2"] = "Ability: Beak Bomb",
	["Placeholder_3"] = "Ability: Beak Buster",
	["Placeholder_4"] = "Ability: Bear Punch Replacement Peck",
	["Placeholder_5"] = "Ability: Climb Trees",
	["Placeholder_6"] = "Ability: Blue Eggs",
	["Placeholder_7"] = "Ability: Feathery Flap",
	["Placeholder_8"] = "Ability: Flap Flip",
	["Placeholder_9"] = "Ability: Fly Pad",
	["Placeholder_10"] = "Ability: Full Jump Height",
	["Placeholder_11"] = "Ability: Rat-a-tat Rap",
	["Placeholder_12"] = "Ability: Roll",
	["Placeholder_13"] = "Ability: Shock Spring Pad",
	["Placeholder_14"] = "Ability: Wading Boots",
	["Placeholder_15"] = "Ability: Dive",
	["Placeholder_16"] = "Ability: Talon Trot",
	["Placeholder_17"] = "Ability: Turbo Trainers",
	["Placeholder_18"] = "Ability: Wonderwing",
	["Grip_Grab_Found"] = "Ability: Grip Grab",
	["Breegull_Blaster_Found"] = "Ability: Breegull Blaster",
	["Egg_Aim_Found"] = "Ability: Egg Aim",
	["Bill_Drill_Found"] = "Ability: Bill Drill",
	["Beak_Bayonet_Found"] = "Ability: Beak Bayonet",
	["Airborne_Found"] = "Ability: Airborne Egg Aiming",
	["Split_Up_Found"] = "Ability: Split Up",
	["Wing_Whack_Found"] = "Ability: Wing Whack",
	["Talon_Torpedo_Found"] = "Ability: Talon Torpedo",
	["Subaqua_Found"] = "Ability: Sub-Aqua Egg Aiming",
	["Shack_Pack_Found"] = "Ability: Shack Pack",
	["Glide_Found"] = "Ability: Glide",
	["Snooze_Pack_Found"] = "Ability: Snooze Pack",
	["Leg_Spring_Found"] = "Ability: Leg Spring",
	["Claw_Clambers_Found"] = "Ability: Claw Clamber Boots",
	["Springy_Step_Shoes_Found"] = "Ability: Springy Step Shoes",
	["Taxi_Pack_Found"] = "Ability: Taxi Pack",
	["Hatch_Found"] = "Ability: Hatch",
	["Pack_Whack_Found"] = "Ability: Pack Whack",
	["Sack_Pack_Found"] = "Ability: Sack Pack",
	["Goggles_Found"] = "Ability: Amaze-O-Gaze Goggles",
	["Fire_Eggs_Found"] = "Ability: Fire Eggs",
	["Grenade_Eggs_Found"] = "Ability: Grenade Eggs",
	["Clockworks_Found"] = "Ability: Clockwork Kazooie Eggs",
	["Ice_Eggs_Found"] = "Ability: Ice Eggs",
	["Double_Air_Found"] = "Ability: Fast Swimming",
	["Placeholder_45"] = "Ability: Breegull Bash",
	["Stony_Found"] = "Humba Wumba: Glowbo Paid (MT)",
	["Detonator_Found"] = "Humba Wumba: Glowbo Paid (GGM)",
	["Van_Found"] = "Humba Wumba: Glowbo Paid (WW)",
	["Sub_Found"] = "Humba Wumba: Glowbo Paid (JRL)",
	["Dinosaur_Found"] = "Humba Wumba: Glowbo Paid (TDL)",
	["Washing_Machine_Found"] = "Humba Wumba: Glowbo Paid (GI)",
	["Snowball_Found"] = "Humba Wumba: Glowbo Paid (HFP)",
	["Bee_Found"] = "Humba Wumba: Glowbo Paid (CCL)",
	["Dragon_Kazooie_Found"] = "Humba Wumba: Glowbo Paid (IoH)",
	["MT_Mumbo_Found"] = "Mumbo: Glowbo Paid (MT)",
	["GGM_Mumbo_Found"] = "Mumbo: Glowbo Paid (GGM)",
	["WW_Mumbo_Found"] = "Mumbo: Glowbo Paid (WW)",
	["JRL_Mumbo_Found"] = "Mumbo: Glowbo Paid (JRL)",
	["TDL_Mumbo_Found"] = "Mumbo: Glowbo Paid (TDL)",
	["HFP_Mumbo_Found"] = "Mumbo: Glowbo Paid (HFP)",
	["CCL_Mumbo_Found"] = "Mumbo: Glowbo Paid (CCL)",
	["IoH_Mumbo_Found"] = "Mumbo: Glowbo Paid (IoH)",
	["GI_Mumbo_Found"] = "Mumbo: Glowbo Paid (GI)",
	["Placeholder_64"] = "Cheat Active: Double Maximum Feathers",
	["Placeholder_65"] = "Cheat Active: Double Maximum Eggs",
	["Placeholder_66"] = "Cheat Active: No Energy Loss From Falling",
	["HoneyBack_Found"] = "Cheat Active: Automatic Energy Regain",
	["Placeholder_68"] = "Cheat Active: Jolly's Jukebox",
	["Placeholder_69"] = "Cheat Active: Jiggywiggy Temple Signposts",
	["SuperBanjo_Found"] = "Cheat Active: Fast Banjo",
	["Placeholder_71"] = "Cheat Active: Fast Baddies",
	["Placeholder_72"] = "Cheat Active: No Energy Or Air Loss",
	["NestKing_Found"] = "Cheat Active: Infinite Eggs And Feathers",
	["JiggyWiggySpecial_Found"] = "Cheat Active: Open Up All World Doors"
};

local rewards_table = {
	['Bovina'] = {name='Dragon_Kazooie_Found', set=false},
	['Golden_Goliath'] = {name='Grenade_Eggs_Found', set=false},
	['Ssslumber'] = {name='Egg_Aim_Found', set=false},
	['MT_Kickball'] = {name='GI_Mumbo_Found', set=false},
	['Relic_Thingy'] = {name='Split_Up_Found', set=false},
	['Top_Of_Temple'] = {name='Sub_Found', set=false},
	['Slightly_Sacred_Chamber'] = {name='MT_Mumbo_Found', set=false},
	['Targitzan'] = {name='Fire_Eggs_Found', set=false},
	['Swamp'] = {name='Washing_Machine_Found', set=false},
	['Pillars'] = {name='None', set=false},
	['Dilberta'] = {name='None', set=false},
	['Ordnance_Storage'] = {name='None', set=false},
	['Crushing_Shed'] = {name='TDL_Mumbo_Found', set=false},
	['Old_King_Coal'] = {name='Snowball_Found', set=false},
	['Generator_Cavern'] = {name='Springy_Step_Shoes_Found', set=false},
	['Power_Hut'] = {name='Goggles_Found', set=false},
	['Waterfall_Cavern'] = {name='Snooze_Pack_Found', set=false},
	['Flooded_Caves'] = {name='Breegull_Blaster_Found', set=false},
	['Canary_Mary_1'] = {name='WW_Mumbo_Found', set=false},
	['Small_Waterfall'] = {name='None', set=false},
	['Cactus_of_Strength'] = {name='CCL_Mumbo_Found', set=false},
	['Dive_of_Death'] = {name='None', set=false},
	['Top_Of_Inferno'] = {name='HFP_Mumbo_Found', set=false},
	['Hoop_Hurry'] = {name='GGM_Mumbo_Found', set=false},
	['Balloon_Burst'] = {name='None', set=false},
	['Saucer_of_Peril'] = {name='Beak_Bayonet_Found', set=false},
	['Star_Spinner'] = {name='SuperBanjo_Found', set=false},
	['Dodgem_Dome'] = {name='IoH_Mumbo_Found', set=false},
	['Patch'] = {name='Double_Air_Found', set=false},
	['Boggys_Kids'] = {name='None', set=false},
	['Pawno'] = {name='None', set=false},
	['Chris_P_Bacon'] = {name='None', set=false},
	['Seemee_Fish'] = {name='Glide_Found', set=false},
	['Aliens'] = {name='None', set=false},
	['Merry_Maggie'] = {name='Clockworks_Found', set=false},
	['Sub_Minigame'] = {name='Claw_Clambers_Found', set=false},
	['Lord_Woo_Fak_Fak'] = {name='None', set=false},
	['Tiptup'] = {name='None', set=false},
	['Smugglers_Cavern'] = {name='None', set=false},
	['Pig_Pool'] = {name='Shack_Pack_Found', set=false},
	['Terry'] = {name='None', set=false},
	['Terry_Nest'] = {name='None', set=false},
	['Chompa'] = {name='Van_Found', set=false},
	['Rocknuts_Jiggy'] = {name='None', set=false},
	['Roar_Cage'] = {name='None', set=false},
	['Oogle_Boogles'] = {name='None', set=false},
	['Terrys_Kids'] = {name='None', set=false},
	['Stomping_Plains'] = {name='Detonator_Found', set=false},
	['Styrac_Family'] = {name='None', set=false},
	['Dippy'] = {name='HoneyBack_Found', set=false},
	['Trash_Compactor'] = {name='Talon_Torpedo_Found', set=false},
	['Twinklies_Packing'] = {name='None', set=false},
	['Weldar'] = {name='None', set=false},
	['Quality_Control'] = {name='Subaqua_Found', set=false},
	['Clinkers_Cavern'] = {name='None', set=false},
	['Attic'] = {name='None', set=false},
	['Workers_Jiggy'] = {name='None', set=false},
	['Toxic_Waste_Pool'] = {name='None', set=false},
	['Tintops'] = {name='Sack_Pack_Found', set=false},
	['Toxic_Waste_Box'] = {name='JRL_Mumbo_Found', set=false},
	['Ice_Wall'] = {name='Dinosaur_Found', set=false},
	['HFP_Kickball'] = {name='Bill_Drill_Found', set=false},
	['Colosseum'] = {name='Taxi_Pack_Found', set=false},
	['Volcano'] = {name='Pack_Whack_Found', set=false},
	['Boggys_Fish'] = {name='None', set=false},
	['Dragon_Brothers'] = {name='None', set=false},
	['Sabreman'] = {name='None', set=false},
	['Alien_Kids'] = {name='None', set=false},
	['Oil_Drill'] = {name='Wing_Whack_Found', set=false},
	['Ice_Train'] = {name='None', set=false},
	['Pot_O_Gold'] = {name='None', set=false},
	['Trash_Can'] = {name='Bee_Found', set=false},
	['Mingy_Jongo'] = {name='None', set=false},
	['Canary_Mary_3'] = {name='None', set=false},
	['Eyeball_Plants'] = {name='Hatch_Found', set=false},
	['Zubbas'] = {name='Grip_Grab_Found', set=false},
	['Superstash'] = {name='None', set=false},
	['Jelly_Castle'] = {name='None', set=false},
	['Cheese_Wedge'] = {name='None', set=false},
	['Mr_Fit'] = {name='None', set=false},
	['King_Jingaling'] = {name='Airborne_Found', set=false},
	['White_Jinjos'] = {name='NestKing_Found', set=false},
	['Orange_Jinjos'] = {name='JiggyWiggySpecial_Found', set=false},
	['Yellow_Jinjos'] = {name='None', set=false},
	['Brown_Jinjos'] = {name='Leg_Spring_Found', set=false},
	['Green_Jinjos'] = {name='Stony_Found', set=false},
	['Red_Jinjos'] = {name='None', set=false},
	['Blue_Jinjos'] = {name='None', set=false},
	['Purple_Jinjos'] = {name='Ice_Eggs_Found', set=false},
	['Black_Jinjos'] = {name='None', set=false}
};

local function dereferencePointer(address)
	local RDRAMBase = 0x80000000;
	return mainmemory.read_u32_be(address) - RDRAMBase;
end

local flags = dereferencePointer(flag_block_pointer);

local function getAbilityFlagByName(flagName)
	for i = 1, #ability_array do
		if flagName == ability_array[i].name then
			return ability_array[i];
		end
	end
end

function setFlag(byte, _bit)
	if type(byte) == "number" and type(_bit) == "number" and _bit >= 0 and _bit < 8 then
		--local flags = dereferencePointer(Game.Memory.flag_block_pointer);
		local currentValue = mainmemory.readbyte(flags + byte);
		mainmemory.writebyte(flags + byte, bit.set(currentValue, _bit));
	end
end

local function setRewardFlag(reward_internal)
	local flag = getAbilityFlagByName(reward_internal);
	setFlag(flag.byte, flag.bit)
end

local function rewardCheck(check_name_my)
	local reward = rewards_table[check_name_my];
	if reward.name == "None" then
		print("You get NOTHING!");
		reward.set = true;
	else
		--print(reward.name);
		local reward_internal = my_to_internal_name_table[reward.name];
		print(reward_internal);
		setRewardFlag(reward_internal);
		reward.set = true;
	end
end

local function loopChecks()
	for i = 1, #check_array do
		local flag_value = mainmemory.readbyte(flags + check_array[i].byte)
		if bit.check(flag_value, check_array[i].bit) then
			local check_name = check_array[i].name
			local check_name_my = internal_to_my_name_table[check_array[i].name];
			if not rewards_table[check_name_my].set then
				--print(rewards_table[check_name_my].set)
				print(check_name);
				--print(check_name_my);
				rewardCheck(check_name_my);
			end
		end
	end
end

--set pattern 1
local jinjo_pattern_byte = 0x6A;
--mainmemory.writebyte(flags + byte, 1);
local function setJinjoPattern(value)
	mainmemory.writebyte(flags + jinjo_pattern_byte, value);
end


while true do
	--flag_value = mainmemory.readbyte(flags + p_top_of_temple);
	--if flag_value == 1 then
		--local currentValue = mainmemory.readbyte(flags + p_bill_drill);
		--mainmemory.writebyte(flags + p_bill_drill, bit.set(currentValue, p_bill_drill_bit));
	--end
	flags = dereferencePointer(flag_block_pointer)
	if emu.framecount() % 10 == 0 then
		loopChecks()
	end

	emu.frameadvance();
end
