import json
import random

with open("Logic.json", "r") as read_file:
    my_logic = json.load(read_file)
    
class Randomizer:
    
    def __init__(self, logic, seed=1):
        random.seed(seed)
        self.moves = logic['Moves']
        self.intermediates = logic['Intermediates']
        self.checks = logic['Checks']
        self.items = logic['Items']
        self.jinjos = logic["Jinjos"]
        self.jinjo_families = logic["Jinjo_Families_Pattern_1"]
        self.intermediates.update(self.jinjos)
        self.checks.update(self.jinjo_families)
        
        self.locations = {key: None for key in self.checks.keys()}
        self.available_checks = []
        self.available_moves = []
        
        #Accessible tracks which moves, intermediates, and checks are available given the collection state
        self.accessible = {}
        self.create_accessible()
    
    def create_accessible(self):
        for move in self.moves:
            self.accessible[move] = False
        for intermediate in self.intermediates:
            self.accessible[intermediate] = False
        for check in self.checks:
            self.accessible[check] = False
        for item in self.items:
            self.accessible[item] = False
        self.accessible["Silo_Bypass"] = False
        self.accessible["Glitches"] = False
        self.accessible["Insane"] = False
    
    def fill(self):
        pass
    
    def fill_no_logic(self):
        check_list = list(self.checks.keys())
        item_list = self.items.copy()
        random.shuffle(check_list)
        random.shuffle(item_list)
        for i, (check, item) in enumerate(zip(check_list, item_list)):
            self.locations[check] = item
    
    def reset(self):
        for key in self.locations:
            self.locations[key] = None
        for key in self.accessible:
            self.accessible[key] = False
        self.available_moves = []
        self.available_checks = []
    
    def evaluate_availability_of_single_condition(self, conditions):
        """Checks whether one possible access point of a check is met"""
        for condition in conditions:
            if condition not in self.accessible:
                #print(f"Error, condition {condition} does not exist")
                return False
            else:
                if self.accessible[condition] is False:
                    return False
        return True
    
    def evaluate_availability(self, conditions):
        """Checks all possible access points of a check"""
        for condition in conditions:
            if self.evaluate_availability_of_single_condition(condition):
                return True
        return False
    
    def unlock_flags_of_type(self, flag_type):
        """
        DEPRECATED
        flag_type is self.moves, self.intermediates, or self.checks
        sets newly reachable flags to True
        return indicates if new flag was set 
        """
        has_new_unlock = False
        for flag in flag_type:
            if not self.accessible[flag]:
                if self.evaluate_availability(flag_type[flag]):
                    has_new_unlock = True
                    self.accessible[flag] = True
                    print(f"{flag} now unlocked!")
        return has_new_unlock
                
    def unlock_flags(self, verbose=True):
        """Checks for new unlocks until no new unlocks found"""
        has_new_unlock = True
        while(has_new_unlock):
            has_new_unlock = False
            
            #print("Unlocking Moves...")
            for move in self.moves:
                if not self.accessible[move]:
                    if self.evaluate_availability(self.moves[move]):
                        has_new_unlock = True
                        self.accessible[move] = True
                        if verbose:
                            print(f"{move} now unlocked!")
            
            #print("Unlocking Intermediates...")
            for intermediate in self.intermediates:
                if not self.accessible[intermediate]:
                    if self.evaluate_availability(self.intermediates[intermediate]):
                        has_new_unlock = True
                        self.accessible[intermediate] = True
                        if verbose:
                            print(f"{intermediate} now unlocked!")
            
            #print("Unlocking Checks...")
            for check in self.checks:
                #print(f"Checking {check}.")
                if not self.accessible[check]:
                    if self.evaluate_availability(self.checks[check]):
                        has_new_unlock = True
                        self.accessible[check] = True
                        if verbose:
                            print(f"{check} now unlocked!")
                        #Add this check to newly available checks to fill
                        self.available_checks.append(check)
    
    def fill_random_naive(self):
        remaining_items = self.items.copy()
        random.shuffle(remaining_items)
        #Find sphere-0 checks
        self.unlock_flags()
        while len(remaining_items) > 0 and len(self.available_checks) > 0:
            #Find random item, random check, place that item there, then recurse
            item = remaining_items.pop()
            random.shuffle(self.available_checks)
            location = self.available_checks.pop()
            self.locations[location] = item
            self.accessible[item] = True
            self.unlock_flags()
    
    def place_item(self, item, location, verbose=True):
        if verbose:
            print(f"Placing {item} at {location}.")
        self.locations[location] = item
    
    def fill_human_guided(self, silo_bypass = False, verbose = True):
        self.accessible["Silo_Bypass"] = silo_bypass
        remaining_items = self.items.copy()
        random.shuffle(remaining_items)
        self.unlock_flags(verbose = verbose)
        early_items = ["Egg_Aim_Found", "Bill_Drill_Found", "MT_Mumbo_Found", "Breegull_Blaster_Found", "GGM_Mumbo_Found", "Detonator_Found"]
        limits = {
            "MT_Mumbo_Found": 4,
            "Fire_Eggs_Found": 5,
            "Egg_Aim_Found": 8,
            "JiggyWiggySpecial_Found": 10,
            "Split_Up_Found": 11,
            "Talon_Torpedo_Found": 15,
            "Springy_Step_Shoes_Found": 20
            }
        random.shuffle(early_items)
        first_item = early_items[0]
        #print(first_item)
        #print(remaining_items)
        random.shuffle(self.available_checks)
        first_location = self.available_checks.pop()
        remaining_items.remove(first_item)
        self.place_item(first_item, first_location, verbose=verbose)
        self.accessible[first_item] = True
        self.unlock_flags(verbose = verbose)
        random.shuffle(self.available_checks)
        count = 2
        while len(remaining_items) > 0 and len(self.available_checks) > 0:
            
            placed = False
                
            #Make sure key items are placed early enough
            for item in limits:
                if count == limits[item] and not self.accessible[item]:
                    remaining_items.remove(item)
                    location = self.available_checks.pop()
                    self.place_item(item, location, verbose=verbose)
                    self.accessible[item] = True
                    self.unlock_flags(verbose = verbose)
                    random.shuffle(self.available_checks)
                    count += 1
                    placed = True
                    break
            if placed:
                continue
            
            #If divine intervention not needed, place a random thing
            item = remaining_items.pop()
            random.shuffle(self.available_checks)
            location = self.available_checks.pop()
            self.place_item(item, location, verbose=verbose)
            self.accessible[item] = True
            self.unlock_flags(verbose = verbose)
            count += 1
    
    def fill_staling(self, silo_bypass=True, verbose=True, stale_factor=1.05):
        #weights new checks more heavily to counter fill being so bottom-heavy
        
        self.accessible["Silo_Bypass"] = silo_bypass
        self.accessible["Glitches"] = True
        self.accessible["Tricks"] = True
        self.accessible["Insane"] = False
        remaining_items = self.items.copy()
        random.shuffle(remaining_items)
        self.unlock_flags(verbose=verbose)
        early_items = ["Egg_Aim_Found", "Bill_Drill_Found", "MT_Mumbo_Found", "GGM_Mumbo_Found", 
                       "Detonator_Found", "Stony_Found", "Grenade_Eggs_Found",
                       "Springy_Step_Shoes_Found", "SuperBanjo_Found"]
        midgame_items = ["WW_Mumbo_Found", "Van_Found", "JRL_Mumbo_Found", "Talon_Torpedo_Found",
                         "Sub_Found", "Split_Up_Found", "Fire_Eggs_Found", "JiggyWiggySpecial_Found",
                         "Grip_Grab_Found", "Airborne_Found", "Taxi_Pack_Found", "Subaqua_Found",
                         "Ice_Eggs_Found", "Wing_Whack_Found", "Glide_Found", "Hatch_Found"]
        midgame_limit = 9
        limits = {
            "Fire_Eggs_Found": 8,
            "JiggyWiggySpecial_Found": 10,
            "Split_Up_Found": 15,
            "Talon_Torpedo_Found": 20,
            "Springy_Step_Shoes_Found": 25
            }
        inv_limits = {v: k for k, v in limits.items()}
        weights = {loc: 0 for loc in self.checks}
        self.unlock_flags(verbose=verbose)
        random.shuffle(self.available_checks)
        
        num_items_placed = 0
        new_weight = 1
        while len(remaining_items) > 0 and len(self.available_checks) > 0:
            for check in self.available_checks:
                if weights[check] != 0:
                    weights[check] = new_weight
            
            #place IoH item if is far enough along and not placed yet
            if num_items_placed in inv_limits:
                ioh_item = inv_limits[num_items_placed]
                if not self.accessible[ioh_item]:
                    if verbose:
                        print("IoH Item needed")
                    location = self.select_from_weighted_list(self.available_checks, weights)
                    self.available_checks.remove(location)
                    remaining_items.remove(ioh_item)
                    self.place_item(ioh_item, location, verbose=verbose)
                    self.accessible[ioh_item] = True
                    num_items_placed += 1
                    new_weight *= stale_factor
                    
                    self.unlock_flags(verbose=verbose)
                    random.shuffle(self.available_checks)
                    continue
            
            #If running out of checks, place a useful item
            num_in_logic_checks = num_items_placed + len(self.available_checks)
            if num_in_logic_checks >= len(self.available_checks)**2:
                if verbose:
                    print("Running Low on Checks")
                useful_items = []
                for item in early_items:
                    if not self.accessible[item]:
                        useful_items.append(item)
                if num_items_placed >= midgame_limit:
                    for item in midgame_items:
                        if not self.accessible[item]:
                            useful_items.append(item)
                random.shuffle(useful_items)
                location = self.select_from_weighted_list(self.available_checks, weights)
                self.available_checks.remove(location)
                useful_item = useful_items[0]
                remaining_items.remove(useful_item)
                self.place_item(useful_item, location, verbose=verbose)
                self.accessible[useful_item] = True
                num_items_placed += 1
                new_weight *= stale_factor
                
                self.unlock_flags(verbose=verbose)
                random.shuffle(self.available_checks)
                continue
            
            #otherwise just place random item
            location = self.select_from_weighted_list(self.available_checks, weights)
            self.available_checks.remove(location)
            item = remaining_items.pop()
            self.place_item(item, location, verbose=verbose)
            self.accessible[item] = True
            num_items_placed += 1
            new_weight *= stale_factor
            
            self.unlock_flags(verbose=verbose)
            random.shuffle(self.available_checks)
    
                
    def select_from_weighted_list(self, item_list, weights):
        if len(item_list) < 1:
            print("Empty List")
            return None
        total = 0
        for item in item_list:
            total += weights[item]
        target = random.random()*total
        running_total = 0
        for item in item_list:
            running_total += weights[item]
            if running_total >= target:
                return item
        print("random_weight_selection_error")
        return item_list[-1]
    
    def print_for_spreadsheet(self):
        count = 0
        for check in self.locations:
            if count % 10 == 0:
                print("")
                print("")
            print(self.locations[check])
            count += 1
    
r = Randomizer(my_logic, seed=15)

def check_fill_distribution(logic, n, algorithm="Guided"):
    checks = {key: 0 for key in logic["Checks"]}
    checks.update({key: 0 for key in logic["Jinjo_Families_Pattern_1"]})
    for i in range(n):
        seed = random.randint(1, 999999)
        r = Randomizer(logic, seed=seed)
        if algorithm == "Guided":
            r.fill_human_guided(silo_bypass=True, verbose=False)
        elif algorithm == "Stale":
            r.fill_staling(silo_bypass=True, verbose=False)
        for check in r.locations:
            if r.locations[check] is not None:
                checks[check] += 1
    print(checks)
    
class Settings:
    '''
    Customizeable parameters for the randomizer
    
    bypass_silos: True if moves are awarded automatically, and do not need to be learned from Jamjars
    tricks: Add unintended but non glitch techniques to logic
    glitches: Add glitches to logic
    insane: Add unreasonable tricks and glitches to logic
    add_X_to_checks: determines whether collecting object X can award something from the reward pool
    randomize_X: determines if X type of object is in the reward pool
    open_silos: True turns on all IoH silos in the network
    open_worlds: True awards the jiggywiggyspecial cheat on game start
    '''
    
    def __init__(self, bypass_silos=True, tricks=True, glitches=True, insane=False,
                 add_jiggies_to_checks=True, add_cheato_pages_to_checks=True, 
                 add_honeycombs_to_checks=True, add_jinjos_to_checks=True,
                 add_glowbos_to_checks=True, randomize_moves=True, randomize_BK_moves=False,
                 randomize_mumbo=True, randomize_humba_wumba=True, randomize_cheats=True,
                 open_silos=False, open_worlds=False):
        
        self.bypass_silos = bypass_silos
        self.tricks = tricks
        self.glitches = glitches
        self.insane = insane
        self.add_jiggies_to_checks = add_jiggies_to_checks
        self.add_cheato_pages_to_checks = add_cheato_pages_to_checks
        self.add_honeycombs_to_checks = add_honeycombs_to_checks
        self.add_jinjos_to_checks = add_jinjos_to_checks
        self.add_glowbos_to_checks = add_glowbos_to_checks
        self.randomize_moves = randomize_moves
        self.randomize_BK_moves = randomize_BK_moves
        self.randomize_mumbo = randomize_mumbo
        self.randomize_humba_wumba = randomize_humba_wumba
        self.randomize_cheats = randomize_cheats
        self.open_silos = open_silos
        self.open_worlds = open_worlds

class CollectionState:
    
    def __init__(self):
        pass