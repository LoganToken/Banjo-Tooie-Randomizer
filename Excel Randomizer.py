import json
import random

with open("Logic.json", "r") as read_file:
    data = json.load(read_file)

"""
MOVES = data['Moves']
INTERMEDIATES = data['Intermediates']
CHECKS = data['Checks']

LOCATIONS = {key: None for key in data["Checks"].keys()}

ACCESSIBLE = {}
for key in MOVES.keys():
    ACCESSIBLE[key] = False
for key in INTERMEDIATES.keys():
    ACCESSIBLE[key] = False
for key in CHECKS.keys():
    ACCESSIBLE[key] = False
for key in FINDS:
    ACCESSIBLE[key] = False
    
FIND_PLACED = {key: False for key in FINDS}
    
FRONTIER = []

COLLECTIBLES = data["Test_Moves"]

def check_accessible(conditions):
    for condition in conditions:
        gettable = True
        for sub_condition in condition:
            if sub_condition in ACCESSIBLE:
                if ACCESSIBLE[sub_condition] is False:
                    gettable = False
                    break
            else:
                gettable = False
                break
        if gettable:
            return True
    return False

def update_cycle():
    
    for intermediate in INTERMEDIATES:
        if ACCESSIBLE[intermediate]:
            continue
        if check_accessible(INTERMEDIATES[intermediate]):
            print(intermediate)
            ACCESSIBLE[intermediate] = True
    
    for check in CHECKS:
        if ACCESSIBLE[check]:
            continue
        if check_accessible(CHECKS[check]):
            print(check)
            ACCESSIBLE[check] = True
            FRONTIER.append(check)
            
    for move in MOVES:
        if ACCESSIBLE[move]:
            continue
        if check_accessible(MOVES[move]):
            print(move)
            ACCESSIBLE[move] = True
        
def make_seed(seed=1):
    random.seed(seed)
    update_cycle()
    while len(FRONTIER) > 0 and len(FINDS) > 0:
        new_check = random.choice(FRONTIER)
        new_find = random.choice(FINDS)
        FRONTIER.remove(new_check)
        FINDS.remove(new_find)
        LOCATIONS[new_check] = new_find
        ACCESSIBLE[new_find] = True
        update_cycle()
        update_cycle()
    print(LOCATIONS)
"""
    
class Randomizer:
    
    def __init__(self, data, seed=1):
        random.seed(seed)
        self.moves = data['Moves']
        self.intermediates = data['Intermediates']
        self.checks = data['Checks']
        self.items = data['Items']
        self.jinjos = data["Jinjos"]
        self.jinjo_families = data["Jinjo_Families_Pattern_1"]
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
                
    def unlock_flags(self):
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
                        print(f"{move} now unlocked!")
            
            #print("Unlocking Intermediates...")
            for intermediate in self.intermediates:
                if not self.accessible[intermediate]:
                    if self.evaluate_availability(self.intermediates[intermediate]):
                        has_new_unlock = True
                        self.accessible[intermediate] = True
                        print(f"{intermediate} now unlocked!")
            
            #print("Unlocking Checks...")
            for check in self.checks:
                #print(f"Checking {check}.")
                if not self.accessible[check]:
                    if self.evaluate_availability(self.checks[check]):
                        has_new_unlock = True
                        self.accessible[check] = True
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
    
    def place_item(self, item, location):
        print(f"Placing {item} at {location}.")
        self.locations[location] = item
    
    def fill_human_guided(self, silo_bypass = False):
        self.accessible["Silo_Bypass"] = silo_bypass
        remaining_items = self.items.copy()
        random.shuffle(remaining_items)
        self.unlock_flags()
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
        self.place_item(first_item, first_location)
        self.accessible[first_item] = True
        self.unlock_flags()
        random.shuffle(self.available_checks)
        count = 2
        while len(remaining_items) > 0 and len(self.available_checks) > 0:
            
            placed = False
                
            #Make sure key items are placed early enough
            for item in limits:
                if count == limits[item] and not self.accessible[item]:
                    remaining_items.remove(item)
                    location = self.available_checks.pop()
                    self.place_item(item, location)
                    self.accessible[item] = True
                    self.unlock_flags()
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
            self.place_item(item, location)
            self.accessible[item] = True
            self.unlock_flags()
            count += 1
    
    def print_for_spreadsheet(self):
        count = 0
        for check in self.locations:
            if count % 10 == 0:
                print("")
                print("")
            print(self.locations[check])
            count += 1
    
r = Randomizer(data, seed=2)
def use_test_unlocks(rando):
    test_unlocks = ["Bill_Drill_Found", "Grenade_Eggs_Found", "Egg_Aim_Found"]
    for flag in test_unlocks:
        rando.accessible[flag] = True
#use_test_unlocks(r)


