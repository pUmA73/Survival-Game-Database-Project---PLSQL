--player
INSERT INTO PLAYER VALUES(seq_player.nextval, 'TheWalkingManZ', 4);
INSERT INTO PLAYER VALUES(seq_player.nextval, 'BobbyTommy', 3);
INSERT INTO PLAYER VALUES(seq_player.nextval, 'CrazyJohn', 8);
INSERT INTO PLAYER VALUES(seq_player.nextval, 'DangerMann', 1);
INSERT INTO PLAYER VALUES(seq_player.nextval, 'Rudy', 9);

--item
INSERT INTO ITEM VALUES(seq_item.nextval, 'Wood', 'Material', 'Easily accessible resource. Best choice for a little shelter');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Stone', 'Material', 'Crucial for crafting and construction. Found in the rugged landscapes');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Iron', 'Material', 'Used for forging essential tools and equipment');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Mud', 'Material', 'Found, well, nearly everywhere really');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Leaves', 'Material', 'Best used for building roofs');

INSERT INTO ITEM VALUES(seq_item.nextval, 'Duct Tape', 'Miscellaneous', 'Fix that broken bat');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Rope', 'Miscellaneous', 'For securing stuff');

INSERT INTO ITEM VALUES(seq_item.nextval, 'Bandage', 'Medical', 'Quick fix for scratches');
INSERT INTO ITEM VALUES(seq_item.nextval, 'First Aid Kit', 'Medical', 'Used for more serios injuries');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Disinfectant', 'Medical', 'Keeps infections out of your wounds');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Tetracyline Pills', 'Medical', 'Used to treat infections');
INSERT INTO ITEM VALUES(seq_item.nextval, 'EpiPen', 'Medical', 'Used to boost stamina for a short time');

INSERT INTO ITEM VALUES(seq_item.nextval, 'Canned Beans', 'Food', 'A nutritious can of beans');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Apple', 'Food', 'The worst enemy of doctors');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Steak', 'Food', 'Make sure to cook before eating');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Crackers', 'Food', 'Great for when you are on the go');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Jam', 'Food', 'Very very sweet');

INSERT INTO ITEM VALUES(seq_item.nextval, 'Water', 'Drinks', 'The liquid of life');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Fronta', 'Drinks', 'Used to be the most popular soda company');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Apple juice', 'Drinks', 'Made from squishing apples');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Pispi', 'Drinks', 'Used to be the second most popular soda company');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Kvass', 'Drinks', 'Drink at your own risk');

INSERT INTO ITEM VALUES(seq_item.nextval, 'Pea Coat', 'Clothing', 'Keeps you warm, stylish too');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Gloves', 'Clothing', 'Take care of your hands');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Beanie', 'Clothing', 'Gotta keep the most important part warm');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Jeans', 'Clothing', 'Never go out of style');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Sunglasses', 'Clothing', 'You can still look cool');

INSERT INTO ITEM VALUES(seq_item.nextval, 'Knife', 'Melee', 'Mans best friend');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Bat', 'Melee', 'Not used for baseball anymore');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Spiked bat', 'Melee', 'Upgraded bat, found in survivor houses');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Axe', 'Melee', 'Very usefull tool and weapon');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Craiova Sword', 'Melee', 'Legendary, very hard to acquire');

INSERT INTO ITEM VALUES(seq_item.nextval, 'PSL', 'Firearm', 'Perfect from afar');
INSERT INTO ITEM VALUES(seq_item.nextval, 'ISJ-70', 'Firearm', 'Was popular amongst police forces');
INSERT INTO ITEM VALUES(seq_item.nextval, 'Mosin m91/30', 'Firearm', 'Iron sights are not that bad');
INSERT INTO ITEM VALUES(seq_item.nextval, 'SKS', 'Firearm', 'Old reliable');
INSERT INTO ITEM VALUES(seq_item.nextval, 'BK-34', 'Firearm', 'Shotgun for home defense');

select * from item;

--medical
INSERT INTO MEDICAL VALUES(seq_medical.nextval, 8, 20, 0);
INSERT INTO MEDICAL VALUES(seq_medical.nextval, 9, 100, 0);
INSERT INTO MEDICAL VALUES(seq_medical.nextval, 10, 10, 0);
INSERT INTO MEDICAL VALUES(seq_medical.nextval, 11, 5, 0);
INSERT INTO MEDICAL VALUES(seq_medical.nextval, 12, 0, 100);

--food
INSERT INTO FOOD VALUES(seq_food.nextval, 13, 10, 10, 'No');
INSERT INTO FOOD VALUES(seq_food.nextval, 14, 5, 15, 'No');
INSERT INTO FOOD VALUES(seq_food.nextval, 15, 20, 20, 'Yes');
INSERT INTO FOOD VALUES(seq_food.nextval, 16, 5, 0, 'No');
INSERT INTO FOOD VALUES(seq_food.nextval, 17, 10, 20, 'No');

--drinks
INSERT INTO DRINKS VALUES(seq_drinks.nextval, 18, 0, 5);
INSERT INTO DRINKS VALUES(seq_drinks.nextval, 19, 5, 10);
INSERT INTO DRINKS VALUES(seq_drinks.nextval, 20, 10, 15);
INSERT INTO DRINKS VALUES(seq_drinks.nextval, 21, 5, 10);
INSERT INTO DRINKS VALUES(seq_drinks.nextval, 22, -5, 5);

--clothing
INSERT INTO CLOTHING VALUES(seq_clothing.nextval, 23, 60);
INSERT INTO CLOTHING VALUES(seq_clothing.nextval, 24, 15);
INSERT INTO CLOTHING VALUES(seq_clothing.nextval, 25, 10);
INSERT INTO CLOTHING VALUES(seq_clothing.nextval, 26, 10);
INSERT INTO CLOTHING VALUES(seq_clothing.nextval, 27, 0);

--melee
INSERT INTO MELEE_WEAPONS VALUES(seq_melee.nextval, 28, 50, 20);
INSERT INTO MELEE_WEAPONS VALUES(seq_melee.nextval, 29, 60, 30);
INSERT INTO MELEE_WEAPONS VALUES(seq_melee.nextval, 30, 67, 45);
INSERT INTO MELEE_WEAPONS VALUES(seq_melee.nextval, 31, 143, 60);
INSERT INTO MELEE_WEAPONS VALUES(seq_melee.nextval, 32, 200, 85);

--firearms
INSERT INTO FIREARMS VALUES(seq_firearms.nextval, 33, 360, 70, 800, '7.62 X 54', 10);
INSERT INTO FIREARMS VALUES(seq_firearms.nextval, 34, 245, 30, 50, '.380 Auto', 12);
INSERT INTO FIREARMS VALUES(seq_firearms.nextval, 35, 788, 90, 600, '7.62 X 54', 5);
INSERT INTO FIREARMS VALUES(seq_firearms.nextval, 36, 800, 60, 500,  '7.62 X 39', 10);
INSERT INTO FIREARMS VALUES(seq_firearms.nextval, 37, 448, 80, 30, 'Buckshot', 2);

--weather
INSERT INTO WEATHER
VALUES (seq_weather.nextval, 'Sunny', 'Clear skies with abundant sunshine.');

INSERT INTO WEATHER
VALUES (seq_weather.nextval, 'Cloudy', 'Overcast sky with no direct sunlight.');

INSERT INTO WEATHER
VALUES (seq_weather.nextval, 'Rainy', 'Continuous precipitation with wet conditions.');

INSERT INTO WEATHER
VALUES (seq_weather.nextval, 'Stormy', 'Violent atmospheric disturbance: thunder, lightning, and heavy rain.');

INSERT INTO WEATHER
VALUES (seq_weather.nextval, 'Foggy', 'Thick fog reducing visibility.');

--biomes
INSERT INTO BIOME
VALUES (seq_biome.nextval, 'Forest', 'A twisted and eerie forest, overrun with dangerous creatures.');

INSERT INTO BIOME
VALUES (seq_biome.nextval, 'Wasteland Desert', 'A desolate and barren wasteland, scattered with remnants of civilization and plagued by sandstorms.');

INSERT INTO BIOME
VALUES (seq_biome.nextval, 'Toxic Swamplands', 'A toxic and hazardous swamp, filled with poisonous gases, mutated creatures, and decaying ruins.');

INSERT INTO BIOME
VALUES (seq_biome.nextval, 'Ruined Cityscape', 'The remnants of a once thriving city, now reduced to ruins, rubble, and danger at every turn.');

INSERT INTO BIOME
VALUES (seq_biome.nextval, 'Industrial Zone', 'An industrial area in decay, filled with waste, malfunctioning machinery, and hostile scavengers.');

--npc
INSERT INTO NPC
VALUES (seq_npc.nextval, 'Mutant', 'No', 15, 'A grotesque mutant creature, heavily affected by radiation. Highly hostile and dangerous.');

INSERT INTO NPC
VALUES (seq_npc.nextval, 'Sand Scavenger', 'Yes', 10, 'A resourceful scavenger surviving in the wasteland desert. Mostly non-hostile but wary of outsiders.');

INSERT INTO NPC
VALUES (seq_npc.nextval, 'Toxic Gas Emissary', 'No', 26, 'An NPC equipped with hazardous gas-emitting devices, guarding the toxic swamplands fiercely.');

INSERT INTO NPC
VALUES (seq_npc.nextval, 'Raider', 'No', 12, 'A ruthless scavenger lurking in the ruined cityscape, preying on unsuspecting explorers.');

INSERT INTO NPC
VALUES (seq_npc.nextval, 'Marauder', 'No', 30, 'An aggressive raider, armed and dangerous, found mostly in toxic swamps.');

INSERT INTO NPC
VALUES (seq_npc.nextval, 'Nomad', 'Yes', 13, 'A nomadic wanderer surviving the scorched wastelands, offering assistance to fellow travelers.');

--server 
ALTER TABLE SERVER DROP COLUMN Player_ID;
ALTER TABLE SERVER DROP COLUMN Log_Time;
ALTER TABLE SERVER ADD Server_Name varchar2(20);

INSERT INTO SERVER VALUES(seq_server.nextval, 'Community 1');
INSERT INTO SERVER VALUES(seq_server.nextval, 'Community 2');
INSERT INTO SERVER VALUES(seq_server.nextval, 'The Survival Cave');
INSERT INTO SERVER VALUES(seq_server.nextval, 'The Wasteland');
INSERT INTO SERVER VALUES(seq_server.nextval, 'Los Muertos');

--stats
INSERT INTO STATS VALUES(seq_stats.nextval, 100, 100, 100, 80, 60, 25);
INSERT INTO STATS VALUES(seq_stats.nextval, 125, 35, 70, 20, 50, 60);
INSERT INTO STATS VALUES(seq_stats.nextval, 150, 65, 100, 90, 90, 80);
INSERT INTO STATS VALUES(seq_stats.nextval, 175, 80, 10, 15, 10, 15);
INSERT INTO STATS VALUES(seq_stats.nextval, 200, 100, 100, 100, 100, 95);

--location
INSERT INTO LOCATION VALUES(seq_location.nextval, 100, 2, 1, 450, 1200);
INSERT INTO LOCATION VALUES(seq_location.nextval, 125, 2, 1, 454, 1202);
INSERT INTO LOCATION VALUES(seq_location.nextval, 150, 5, 3, 1000, 13);
INSERT INTO LOCATION VALUES(seq_location.nextval, 175, 3, 5, 45, 750);
INSERT INTO LOCATION VALUES(seq_location.nextval, 200, 4, 4, 0, 117);

--inventory
INSERT INTO INVENTORY VALUES(seq_inventory.nextval, 100);
INSERT INTO INVENTORY VALUES(seq_inventory.nextval, 125);
INSERT INTO INVENTORY VALUES(seq_inventory.nextval, 150);
INSERT INTO INVENTORY VALUES(seq_inventory.nextval, 175);
INSERT INTO INVENTORY VALUES(seq_inventory.nextval, 200);

--contains
INSERT INTO CONTAINS VALUES(1, 24, 1);
INSERT INTO CONTAINS VALUES(1, 25, 1);
INSERT INTO CONTAINS VALUES(1, 1, 3);
INSERT INTO CONTAINS VALUES(2, 23, 1);
INSERT INTO CONTAINS VALUES(2, 29, 1);
INSERT INTO CONTAINS VALUES(3, 23, 1);
INSERT INTO CONTAINS VALUES(3, 25, 1);
INSERT INTO CONTAINS VALUES(3, 26, 1);
INSERT INTO CONTAINS VALUES(3, 36, 1);
INSERT INTO CONTAINS VALUES(4, 24, 1);
INSERT INTO CONTAINS VALUES(4, 28, 2);
INSERT INTO CONTAINS VALUES(5, 23, 1);
INSERT INTO CONTAINS VALUES(5, 24, 1);
INSERT INTO CONTAINS VALUES(5, 25, 1);
INSERT INTO CONTAINS VALUES(5, 26, 1);
INSERT INTO CONTAINS VALUES(5, 32, 1);
INSERT INTO CONTAINS VALUES(5, 35, 1);
INSERT INTO CONTAINS VALUES(5, 12, 1);

--npc_in_biomes
INSERT INTO NPC_IN_BIOMES VALUES(1, 1, 'Very High');
INSERT INTO NPC_IN_BIOMES VALUES(1, 4, 'Normal');
INSERT INTO NPC_IN_BIOMES VALUES(1, 5, 'Low');
INSERT INTO NPC_IN_BIOMES VALUES(2, 2, 'High');
INSERT INTO NPC_IN_BIOMES VALUES(2, 1, 'Very Low');
INSERT INTO NPC_IN_BIOMES VALUES(3, 3, 'Very High');
INSERT INTO NPC_IN_BIOMES VALUES(3, 1, 'Normal');
INSERT INTO NPC_IN_BIOMES VALUES(3, 5, 'High');
INSERT INTO NPC_IN_BIOMES VALUES(4, 1, 'Very High');
INSERT INTO NPC_IN_BIOMES VALUES(4, 4, 'Very High');
INSERT INTO NPC_IN_BIOMES VALUES(5, 1, 'Low');
INSERT INTO NPC_IN_BIOMES VALUES(5, 6, 'Normal');
INSERT INTO NPC_IN_BIOMES VALUES(5, 4, 'Normal');

--items-in-biomes
INSERT INTO ITEMS_IN_BIOMES VALUES(1, 1, 'Very High');
INSERT INTO ITEMS_IN_BIOMES VALUES(1, 8, 'Very Low');
INSERT INTO ITEMS_IN_BIOMES VALUES(1, 14, 'High');
INSERT INTO ITEMS_IN_BIOMES VALUES(2, 10, 'Normal');
INSERT INTO ITEMS_IN_BIOMES VALUES(2, 16, 'Low');
INSERT INTO ITEMS_IN_BIOMES VALUES(2, 28, 'Normal');
INSERT INTO ITEMS_IN_BIOMES VALUES(3, 7, 'Normal');
INSERT INTO ITEMS_IN_BIOMES VALUES(3, 12, 'Low');
INSERT INTO ITEMS_IN_BIOMES VALUES(3, 22, 'Very High');
INSERT INTO ITEMS_IN_BIOMES VALUES(4, 23, 'High');
INSERT INTO ITEMS_IN_BIOMES VALUES(4, 30, 'High');
INSERT INTO ITEMS_IN_BIOMES VALUES(4, 32, 'Very Low');
INSERT INTO ITEMS_IN_BIOMES VALUES(5, 31, 'Normal');
INSERT INTO ITEMS_IN_BIOMES VALUES(5, 35, 'Low');
INSERT INTO ITEMS_IN_BIOMES VALUES(5, 24, 'High');
INSERT INTO ITEMS_IN_BIOMES VALUES(5, 7, 'Normal');

--biomes_weather
INSERT INTO BIOMES_WEATHER VALUES(1, 2, 'High');
INSERT INTO BIOMES_WEATHER VALUES(1, 3, 'Normal');
INSERT INTO BIOMES_WEATHER VALUES(1, 5, 'Low');
INSERT INTO BIOMES_WEATHER VALUES(2, 1, 'High');
INSERT INTO BIOMES_WEATHER VALUES(2, 2, 'Very Low');
INSERT INTO BIOMES_WEATHER VALUES(3, 3, 'Normal');
INSERT INTO BIOMES_WEATHER VALUES(3, 5, 'Very High');
INSERT INTO BIOMES_WEATHER VALUES(4, 1, 'Low');
INSERT INTO BIOMES_WEATHER VALUES(4, 3, 'Very High');
INSERT INTO BIOMES_WEATHER VALUES(5, 4, 'High');
INSERT INTO BIOMES_WEATHER VALUES(5, 3, 'Very High');
INSERT INTO BIOMES_WEATHER VALUES(5, 2, 'Low');

--server_connections
CREATE TABLE SERVER_CONNECTIONS (
     Server_ID number(3) not null,
     Player_ID number(4) not null,
     Log_Time Date,
     PRIMARY KEY(Server_ID, Player_ID),
     FOREIGN KEY(Server_ID)
     REFERENCES SERVER(server_ID),
     FOREIGN KEY(Player_ID)
     REFERENCES PLAYER(Player_ID)
     );
     
INSERT INTO SERVER_CONNECTIONS VALUES(12, 100, TO_DATE('2023-05-26 08:15:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO SERVER_CONNECTIONS VALUES(12, 125, TO_DATE('2023-05-26 09:20:30', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO SERVER_CONNECTIONS VALUES(12, 175, TO_DATE('2023-05-26 10:10:32', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO SERVER_CONNECTIONS VALUES(14, 150, TO_DATE('2023-05-26 13:40:37', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO SERVER_CONNECTIONS VALUES(14, 200, TO_DATE('2023-05-26 15:55:00', 'YYYY-MM-DD HH24:MI:SS'));

commit;