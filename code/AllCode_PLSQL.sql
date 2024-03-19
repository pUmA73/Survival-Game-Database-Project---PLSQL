 create sequence seq_server
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_player
 start with 100
 increment by 25
 nomaxvalue
 nocycle;
 
 create sequence seq_stats
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_item
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_weather
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_biome
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_npc
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_medical
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_inventory
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_location
 start with 5
 increment by 234
 nomaxvalue
 nocycle;
 
 create sequence seq_food
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_drinks
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_clothing
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_melee
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 create sequence seq_firearms
 start with 1
 increment by 1
 nomaxvalue
 nocycle;
 
 CREATE TABLE BIOME (
    Biome_ID number(1) PRIMARY KEY,
    Biome_Name varchar2(20), 
    Biome_Desc varchar2(255)
    );

CREATE TABLE WEATHER (
    Weather_ID number(1) PRIMARY KEY,
    Weather_Name varchar2(20),
    Weather_Desc varchar(255)
    );
    
CREATE TABLE NPC (
    NPC_ID number(2) PRIMARY KEY,
    NPC_Name varchar2(20) not null,
    Friendly varchar2(3) not null,
    Damage number(3) not null,
    NPC_Desc varchar2(255)
    );

CREATE TABLE PLAYER (
    Player_ID number(4) PRIMARY KEY,
    Player_Name varchar2(20) not null,
    Player_Skill_Level number(1) not null
    );
    
CREATE TABLE SERVER (
    Server_ID number(3) PRIMARY KEY, 
    Player_ID number(4) not null,
    Log_Time date,
    FOREIGN KEY(Player_ID) 
    REFERENCES Player(Player_ID)
    );
    
CREATE TABLE STATS (
    Stats_ID number(3) PRIMARY KEY,
    Player_ID number(4) not null,
    Health number(3) not null,
    Stamina number(3) not null,
    Hunger number(3) not null,
    Thirst number(3) not null,
    Temperature number(3) not null,
    FOREIGN KEY(Player_ID) 
    REFERENCES Player(Player_ID)
    );
    
CREATE TABLE INVENTORY (
    Inventory_ID number(3) PRIMARY KEY,
    Player_ID number(4) not null,
    FOREIGN KEY(Player_ID) 
    REFERENCES Player(Player_ID)
    );
    
CREATE TABLE ITEM (
    Item_ID number(3) PRIMARY KEY,
    Item_Name varchar2(20),
    Item_Type varchar2(20),
    Item_Desc varchar2(255)
    );
    
CREATE TABLE MEDICAL (
    Medical_ID number(3) PRIMARY KEY,
    Item_ID number(3) not null, 
    Health_Effect number(3) not null,
    Stamina_Effect number(3) not null,
    FOREIGN KEY(Item_ID)
    REFERENCES ITEM(Item_ID)
    );

CREATE TABLE FOOD (
    Food_ID number(3) PRIMARY KEY,
    Item_ID number(3) not null,
    Health_Effect number(3) not null,
    Stamina_Effect number(3) not null,
    Requires_Cooking varchar2(3) not null,
    FOREIGN KEY(Item_ID)
    REFERENCES ITEM(Item_ID)
    );
    
CREATE TABLE DRINKS (
    Drinks_ID number(3) PRIMARY KEY,
    Item_ID number(3) not null,
    Health_Effect number(3) not null,
    Stamina_Effect number(3) not null,
    FOREIGN KEY(Item_ID)
    REFERENCES ITEM(Item_ID)
    );
    
CREATE TABLE CLOTHING (
    Clothing_ID number(3) PRIMARY KEY,
    Item_ID number(3) not null,
    Temperature_Effect number(3) not null,
    FOREIGN KEY(Item_ID)
    REFERENCES ITEM(Item_ID)
    );
    
CREATE TABLE MELEE_WEAPONS (
    Melee_ID number(3) PRIMARY KEY,
    Item_ID number(3) not null,
    Durability number(3) not null,
    Damage number(3) not null,
    FOREIGN KEY(Item_ID)
    REFERENCES ITEM(Item_ID)
    );

CREATE TABLE FIREARMS (
    Firearm_ID number(3) PRIMARY KEY,
    Item_ID number(3) not null,
    Durability number(3) not null,
    Damage number(3) not null,
    Range number(4) not null,
    Ammo_Type varchar2(10),
    Ammo_Capacity number(2) not null,
    FOREIGN KEY(Item_ID)
    REFERENCES ITEM(Item_ID)
    );
    
CREATE TABLE LOCATION (
    Location_ID number(4) PRIMARY KEY,
    Player_ID number(4) not null,
    Biome_ID number(1) not null,
    Weather_ID number(1) not null,
    Coord_X number(4) not null,
    Coord_Y number(4) not null,
    FOREIGN KEY(Player_ID) REFERENCES PLAYER(Player_ID),
    FOREIGN KEY(Biome_ID) REFERENCES BIOME(Biome_ID),
    FOREIGN KEY(Weather_ID) REFERENCES WEATHER(Weather_ID)
    );
    
CREATE TABLE CONTAINS (
    Inventory_ID number(3) not null,
    Item_ID number(3) not null,
    Quantity number(3) not null,
    PRIMARY KEY(Inventory_ID, Item_ID),
    FOREIGN KEY(Inventory_ID) REFERENCES INVENTORY(Inventory_ID),
    FOREIGN KEY(Item_ID) REFERENCES ITEM(Item_ID)
    );
    
CREATE TABLE BIOMES_WEATHER (
    Biome_ID number(1) not null,
    Weather_ID number(1) not null,
    Chance varchar2(15) not null,
    PRIMARY KEY(Biome_ID, Weather_ID),
    FOREIGN KEY(Biome_ID) REFERENCES BIOME(Biome_ID),
    FOREIGN KEY(Weather_ID) REFERENCES WEATHER(Weather_ID)
    );
    
CREATE TABLE ITEMS_IN_BIOMES (
    Biome_ID number(1) not null,
    Item_ID number(3) not null,
    Spawn_Rate varchar2(15) not null,
    PRIMARY KEY(Biome_ID, Item_ID),
    FOREIGN KEY(Biome_ID) REFERENCES BIOME(Biome_ID),
    FOREIGN KEY(Item_ID) REFERENCES ITEM(Item_ID)
    );
    
CREATE TABLE NPC_IN_BIOMES (
    Biome_ID number(1) not null,
    NPC_ID number(2) not null,
    Spawn_Rate varchar2(15) not null,
    PRIMARY KEY(Biome_ID, NPC_ID),
    FOREIGN KEY(Biome_ID) REFERENCES BIOME(Biome_ID),
    FOREIGN KEY(NPC_ID) REFERENCES NPC(NPC_ID)
    );
    
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


--6
CREATE OR REPLACE PROCEDURE add_survival_kit
    (w_name WEATHER.weather_name%TYPE)
    IS
        --tablou indexat pentru a retine id-urile jucatorilor
        TYPE player_ids IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
        --tablou imbricat care retine itemele din kit
        TYPE kit_items IS TABLE OF NUMBER;
        --vector pentru a retine cate iteme de fiecare tip 
        --sunt adaugate
        TYPE items_vect IS VARRAY(10) OF NUMBER;
        
        CURSOR med_items(pid PLAYER.player_id%TYPE) IS
            SELECT it.item_id
            FROM ITEM it
            JOIN CONTAINS c on c.item_id = it.item_id
            JOIN INVENTORY i on i.inventory_id = c.inventory_id
            WHERE i.player_id = pid AND it.item_type = 'Medical'; 
        
        qnt         items_vect := items_vect(1, 1, 2, 1, 1);
        itms        kit_items;
        p_ids       player_ids;
        v_inv_id    CONTAINS.inventory_id%TYPE;
        v_exists    BOOLEAN;
    BEGIN
        --selectam jucatorii care se afla in locatii
        --cu vremea primita ca argument
        SELECT PLAYER_ID BULK COLLECT
        INTO p_ids
        FROM (SELECT L.PLAYER_ID
              FROM LOCATION L
              JOIN WEATHER W ON W.weather_id = L.weather_id
              WHERE UPPER(W.weather_name) = UPPER(w_name)
            );
            
        --selectam itemele
        SELECT item_id BULK COLLECT
        INTO itms
        FROM ITEM
        WHERE ITEM.item_type = 'Medical';
        
        --adaugam itemele in inventarele jucatorilor
        FOR i IN p_ids.FIRST..p_ids.LAST LOOP
            SELECT inventory_id INTO v_inv_id
            FROM INVENTORY
            WHERE PLAYER_ID = p_ids(i);
                
            FOR j IN itms.FIRST..itms.LAST LOOP
                v_exists := FALSE;
                
                FOR k IN med_items(p_ids(i)) LOOP
                    IF k.item_id = itms(j) THEN
                        v_exists := TRUE;
                        EXIT;
                    END IF;
                END LOOP;
                
                --daca exista unul din iteme in inventar
                IF v_exists THEN
                    CONTINUE;
                END IF;
                
                INSERT INTO CONTAINS VALUES(v_inv_id, itms(j), qnt(j));
            END LOOP;
        END LOOP;
    END add_survival_kit;
/

BEGIN
    add_survival_kit('Rainy');
END;
/


--7
CREATE OR REPLACE PROCEDURE p_power
    (sv_name  SERVER.server_name%TYPE)
IS 
    pwr        FIREARMS.damage%TYPE;
        
    CURSOR ppower(pid PLAYER.player_id%TYPE) IS
        SELECT damage
        FROM FIREARMS f
        JOIN ITEM it ON it.item_id = f.item_id
        JOIN CONTAINS c ON c.item_id = it.item_id
        JOIN INVENTORY i ON i.inventory_id = c.inventory_id
        WHERE i.player_id = pid
        UNION
        SELECT damage
        FROM MELEE_WEAPONS mw
        JOIN ITEM it ON it.item_id = mw.item_id
        JOIN CONTAINS c ON c.item_id = it.item_id
        JOIN INVENTORY i ON i.inventory_id = c.inventory_id
        WHERE i.player_id = pid;
        
    v_pow               FIREARMS.damage%TYPE;
    v_no_weapons        NUMBER;
    v_pid               PLAYER.player_id%TYPE;
    v_pname             PLAYER.player_name%TYPE;
    v_pl                NUMBER;
BEGIN
    v_pl := 0;
    pwr := 0;
    FOR i IN (  SELECT p.player_name, p.player_id
                FROM PLAYER p
                JOIN SERVER_CONNECTIONS sc ON sc.player_id = p.player_id
                JOIN SERVER s ON s.server_id = sc.server_id
                WHERE s.server_name = sv_name
                    )LOOP
        v_pow := 0;
        v_no_weapons := 0;
        v_pl := v_pl + 1;
        FOR j IN ppower(i.player_id) LOOP
            v_pow := v_pow + j.damage;
            v_no_weapons := v_no_weapons + 1;
        END LOOP;
    pwr := pwr + v_pow;
    END LOOP;
    IF v_pl = 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Serverul nu are jucatori!');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Puterea totala a jucatorilor de pe ' || 
    sv_name || ' este ' || pwr);
END p_power;
/


--8
CREATE OR REPLACE FUNCTION player_health_data
    (p_name PLAYER.player_name%TYPE)
    RETURN VARCHAR2 IS
        
    CURSOR player_medical(pid PLAYER.player_id%TYPE) IS
        SELECT m.health_effect 
        FROM MEDICAL m
        JOIN ITEM it ON it.item_id = m.item_id
        JOIN CONTAINS c ON c.item_id = it.item_id
        JOIN INVENTORY i ON i.inventory_id = c.inventory_id
        WHERE i.player_id = pid;
        
    v_medical           MEDICAL.health_effect%TYPE;
    --numarul de iteme medicale din inventar
    v_medical_it        NUMBER;
    v_pid               PLAYER.player_id%TYPE;
    v_name              PLAYER.player_name%TYPE;
    v_health_total      STATS.health%TYPE;
    v_avg_healing       MEDICAL.health_effect%TYPE;
    --numarul de minute supravietuite
    v_min               NUMBER;
    v_ret               VARCHAR2(25);
    
    --exceptii
    e_player_dead               EXCEPTION;
    e_player_epi_only           EXCEPTION;
    e_player_no_medical         EXCEPTION;
    e_player_not_found          EXCEPTION;
    
BEGIN
    v_medical := 0;
    v_medical_it := 0;
    
    --calculam media abilitatilor medicale
    --ale jucatorilor
    SELECt avg(health_ability)
    INTO v_avg_healing
    FROM(
        SELECT p.player_id, sum(m.health_effect) as health_ability
        FROM player p
        JOIN inventory i on i.player_id = p.player_id
        JOIN contains c on c.inventory_id = i.inventory_id
        JOIN medical m on m.item_id = c.item_id
        GROUP BY p.player_id
        );
        
    --gasim id-ul si numele jucatorului
    SELECT p.player_id, p.player_name
    INTO v_pid, v_name
    FROM PLAYER p
    WHERE UPPER(p.player_name) LIKE UPPER(p_name);
    
    --gasim viata initiala a jucatorului
    SELECT s.health
    INTO v_health_total
    FROM STATS s
    WHERE s.player_id = v_pid;
    
    --calculam abilitatea medicala a jucatorului
    FOR i IN player_medical(v_pid) LOOP
        v_medical := v_medical + i.health_effect;
        v_medical_it := v_medical_it + 1;
    END LOOP;
    
    IF v_health_total = 0 THEN
        RAISE e_player_dead;
    END IF;
    
    v_health_total := v_health_total + v_medical;
    v_min := FLOOR(v_health_total / 15);
    
    IF v_medical < v_avg_healing THEN
        v_ret := 'sub medie';
    ELSIF v_medical = v_avg_healing THEN
        v_ret := 'medii';
    ELSE
        v_ret := 'peste medie';
    END IF;
    
    IF v_medical = 0 AND v_medical_it = 0 THEN
        RAISE e_player_no_medical;
    ELSIF v_medical = 0 AND v_medical_it <> 0 THEN
        RAISE e_player_epi_only;
    END IF;
    
    --returnam info
    RETURN 'Jucatorul ' || v_name || ' are abilitatea medicala ' ||
            v_medical || ' si poate rezista ' || v_min || ' minute.' ||
            ' Jucatorul are abilitati medicale ' || v_ret;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Nu a fost gasit un jucator cu numele dat';
    WHEN e_player_no_medical THEN
        RETURN 'Jucatorul nu are iteme medicale';
    WHEN e_player_epi_only THEN
        RETURN 'Jucatorul are doar EpiPen-uri in inventar';
    WHEN e_player_dead THEN
        RETURN 'Personajul jucatorului nu mai este in viata';
END player_health_data;
/


--9
CREATE OR REPLACE VIEW weapons_damage AS
SELECT f.item_id, it.item_name, f.damage 
FROM FIREARMS f
JOIN ITEM it on it.item_id = f.item_id
UNION
SELECT mw.item_id, it.item_name, mw.damage
FROM MELEE_WEAPONS mw
JOIN ITEM it on it.item_id = mw.item_id
ORDER BY damage DESC;

--9
CREATE OR REPLACE PROCEDURE best_weapon
    (n_name NPC.npc_name%TYPE,
    s_rate NPC_IN_BIOMES.spawn_rate%TYPE) IS
    
    TYPE players_vect IS VARRAY(25) OF VARCHAR2(50);
    
    v_biome_name        BIOME.biome_name%TYPE;
    v_item_id           ITEM.item_id%TYPE;
    v_item_name         ITEM.item_name%TYPE;
    v_item_dmg          FIREARMS.damage%TYPE;
    v_players           players_vect := players_vect();
    
    e_no_players        EXCEPTION;
    
BEGIN
    --gasim biome-ul in care npc-ul dat se spawneaza 
    --cu spawn rate-ul dat
    BEGIN
        SELECT b.biome_name
        INTO v_biome_name
        FROM BIOME b
        JOIN NPC_IN_BIOMES nb on nb.biome_id = b.biome_id
        JOIN NPC n on n.npc_id = nb.npc_id
        WHERE UPPER(n.npc_name) LIKE UPPER(n_name)
            AND UPPER(nb.spawn_rate) LIKE UPPER(s_rate);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NPC-ul dat nu se spawneaza in niciun biome cu spawn rate-ul dat.');
            RETURN; --iesim din procedura
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Npc-ul dat se spawneaza cu spawn rate-ul dat in mai multe biome-uri.');
            RETURN;
    END;
    
    DBMS_OUTPUT.PUT_LINE(v_biome_name);
    
    --cautam arma cu cel mai mult damage
    --din biome-ul gasit
    BEGIN
        SELECT wd.item_id, wd.item_name
        INTO v_item_id, v_item_name
        FROM weapons_damage wd
        JOIN ITEMS_IN_BIOMES ib on ib.item_id = wd.item_id
        JOIN BIOME b on b.biome_id = ib.biome_id
        WHERE UPPER(b.biome_name) LIKE UPPER(v_biome_name)
        AND wd.damage = (SELECT MAX(wd.damage) 
                         FROM weapons_damage wd
                         JOIN ITEMS_IN_BIOMES ib on ib.item_id = wd.item_id
                         JOIN BIOME b on b.biome_id = ib.biome_id
                         WHERE UPPER(b.biome_name) LIKE UPPER(v_biome_name)
                         );
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu se spawneaza arme in biome-ul gasit.');
            RETURN;
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Se spawneaza mai multe arme cu putere maxima in biome-ul gasit.');
            RETURN;
    END;
    
    DBMS_OUTPUT.PUT_LINE(v_item_name);
    
    --verificam daca arma apare in 
    --inventarul unui jucator
    SELECT p.player_name
    BULK COLLECT INTO v_players
    FROM PLAYER p
    JOIN INVENTORY i on i.player_id = p.player_id
    JOIN CONTAINS C on c.inventory_id = i.inventory_id
    JOIN LOCATION l on l.player_id = p.player_id
    JOIN BIOME B on b.biome_id = l.biome_id
    WHERE UPPER(b.biome_name) LIKE UPPER(v_biome_name)
    AND c.item_id = v_item_id;
    
    IF v_players.COUNT = 0 THEN
        RAISE e_no_players;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Jucatorii din biome-ul gasit care detin item-ul de putere maxima:');
    FOR i IN v_players.FIRST..v_players.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(v_players(i));
    END LOOP;
    
EXCEPTION
    WHEN e_no_players THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista jucatori in biome-ul gasit care sa detine item-ul de putere maxima');
END;
/


--10
CREATE OR REPLACE TRIGGER max_servers
    AFTER INSERT OR DELETE ON SERVER
DECLARE
    v_no_servers        NUMBER := 0;
    event_type          VARCHAR2(20);
BEGIN
    SELECT COUNT(server_id)
    INTO v_no_servers
    FROM SERVER;
    
    IF INSERTING AND v_no_servers > 6 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Numarul maxim de servere a fost atins');    
    ELSIF DELETING AND v_no_servers < 3 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Numarul minim de servere a fost atins');
    END IF;
END;
/


--11
CREATE OR REPLACE TRIGGER mod_firearms
    BEFORE UPDATE OF damage ON FIREARMS
    FOR EACH ROW
BEGIN 
    IF(:NEW.damage < 20) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Puterea armelor de foc nu poate scadea sub 20');
    ELSIF(:NEW.damage > 200) THEN
        RAISE_APPLICATION_ERROR(-20004, 'Puterea armelor de foc nu poate creste peste 200');
    END IF;
END;
/


--12
CREATE SEQUENCE log_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE TABLE MODIFICATIONS_LOG (
    log_id          NUMBER PRIMARY KEY,
    op_user         VARCHAR2(50),
    op_time         TIMESTAMP,
    operation       VARCHAR2(50),
    obj_name        VARCHAR2(50)
);

CREATE OR REPLACE TRIGGER MOD_TRIGGER
    BEFORE DROP OR CREATE OR ALTER ON SCHEMA
DECLARE
    v_user      VARCHAR2(100);
BEGIN
    SELECT USER INTO v_user FROM DUAL;
    
    IF UPPER(v_user) = 'PPUM' THEN
        INSERT INTO MODIFICATIONS_LOG(log_id, op_user, op_time, operation, obj_name)
        VALUES (log_seq.NEXTVAL, v_user, SYSTIMESTAMP, sys.sysevent, sys.dictionary_obj_name);
    ELSE
        RAISE_APPLICATION_ERROR(-20005, 'Operatie LDD neautorizata facuta de ' || v_user);
    END IF;
END;
/



--13
CREATE OR REPLACE PACKAGE FUNC_PROC AS
    PROCEDURE       add_survival_kit(w_name WEATHER.weather_name%TYPE);
    PROCEDURE       p_power(sv_name  SERVER.server_name%TYPE);
    FUNCTION        player_health_data(p_name PLAYER.player_name%TYPE)
                    RETURN VARCHAR2;
    PROCEDURE       best_weapon(n_name NPC.npc_name%TYPE,
    s_rate NPC_IN_BIOMES.spawn_rate%TYPE);
END FUNC_PROC;
/

CREATE OR REPLACE PACKAGE BODY FUNC_PROC AS
    --6
    PROCEDURE add_survival_kit
    (w_name WEATHER.weather_name%TYPE)
    IS
        --tablou indexat pentru a retine id-urile jucatorilor
        TYPE player_ids IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
        --tablou imbricat care retine itemele din kit
        TYPE kit_items IS TABLE OF NUMBER;
        --vector pentru a retine cate iteme de fiecare tip 
        --sunt adaugate
        TYPE items_vect IS VARRAY(10) OF NUMBER;
        
        CURSOR med_items(pid PLAYER.player_id%TYPE) IS
            SELECT it.item_id
            FROM ITEM it
            JOIN CONTAINS c on c.item_id = it.item_id
            JOIN INVENTORY i on i.inventory_id = c.inventory_id
            WHERE i.player_id = pid AND it.item_type = 'Medical'; 
        
        qnt         items_vect := items_vect(1, 1, 2, 1, 1);
        itms        kit_items;
        p_ids       player_ids;
        v_inv_id    CONTAINS.inventory_id%TYPE;
        v_exists    BOOLEAN;
    BEGIN
        --selectam jucatorii care se afla in locatii
        --cu vremea primita ca argument
        SELECT PLAYER_ID BULK COLLECT
        INTO p_ids
        FROM (SELECT L.PLAYER_ID
              FROM LOCATION L
              JOIN WEATHER W ON W.weather_id = L.weather_id
              WHERE UPPER(W.weather_name) = UPPER(w_name)
            );
            
        --selectam itemele
        SELECT item_id BULK COLLECT
        INTO itms
        FROM ITEM
        WHERE ITEM.item_type = 'Medical';
        
        --adaugam itemele in inventarele jucatorilor
        FOR i IN p_ids.FIRST..p_ids.LAST LOOP
            SELECT inventory_id INTO v_inv_id
            FROM INVENTORY
            WHERE PLAYER_ID = p_ids(i);
                
            FOR j IN itms.FIRST..itms.LAST LOOP
                v_exists := FALSE;
                
                FOR k IN med_items(p_ids(i)) LOOP
                    IF k.item_id = itms(j) THEN
                        v_exists := TRUE;
                        EXIT;
                    END IF;
                END LOOP;
                
                --daca exista unul din iteme in inventar
                IF v_exists THEN
                    CONTINUE;
                END IF;
                
                INSERT INTO CONTAINS VALUES(v_inv_id, itms(j), qnt(j));
            END LOOP;
        END LOOP;
    END add_survival_kit;

    --7
    PROCEDURE p_power
    (sv_name  SERVER.server_name%TYPE)
    IS 
        pwr        FIREARMS.damage%TYPE;
            
        CURSOR ppower(pid PLAYER.player_id%TYPE) IS
            SELECT damage
            FROM FIREARMS f
            JOIN ITEM it ON it.item_id = f.item_id
            JOIN CONTAINS c ON c.item_id = it.item_id
            JOIN INVENTORY i ON i.inventory_id = c.inventory_id
            WHERE i.player_id = pid
            UNION
            SELECT damage
            FROM MELEE_WEAPONS mw
            JOIN ITEM it ON it.item_id = mw.item_id
            JOIN CONTAINS c ON c.item_id = it.item_id
            JOIN INVENTORY i ON i.inventory_id = c.inventory_id
            WHERE i.player_id = pid;
            
        v_pow               FIREARMS.damage%TYPE;
        v_no_weapons        NUMBER;
        v_pid               PLAYER.player_id%TYPE;
        v_pname             PLAYER.player_name%TYPE;
        v_pl                NUMBER;
    BEGIN
        v_pl := 0;
        pwr := 0;
        FOR i IN (  SELECT p.player_name, p.player_id
                    FROM PLAYER p
                    JOIN SERVER_CONNECTIONS sc ON sc.player_id = p.player_id
                    JOIN SERVER s ON s.server_id = sc.server_id
                    WHERE s.server_name = sv_name
                        )LOOP
            v_pow := 0;
            v_no_weapons := 0;
            v_pl := v_pl + 1;
            FOR j IN ppower(i.player_id) LOOP
                v_pow := v_pow + j.damage;
                v_no_weapons := v_no_weapons + 1;
            END LOOP;
        pwr := pwr + v_pow;
        END LOOP;
        IF v_pl = 0 THEN
            RAISE_APPLICATION_ERROR(-20000, 'Serverul nu are jucatori!');
        END IF;
        DBMS_OUTPUT.PUT_LINE('Puterea totala a jucatorilor de pe ' || 
        sv_name || ' este ' || pwr);
    END p_power;
    
    
    --8
    FUNCTION player_health_data
    (p_name PLAYER.player_name%TYPE)
    RETURN VARCHAR2 IS
        
    CURSOR player_medical(pid PLAYER.player_id%TYPE) IS
        SELECT m.health_effect 
        FROM MEDICAL m
        JOIN ITEM it ON it.item_id = m.item_id
        JOIN CONTAINS c ON c.item_id = it.item_id
        JOIN INVENTORY i ON i.inventory_id = c.inventory_id
        WHERE i.player_id = pid;
        
    v_medical           MEDICAL.health_effect%TYPE;
    --numarul de iteme medicale din inventar
    v_medical_it        NUMBER;
    v_pid               PLAYER.player_id%TYPE;
    v_name              PLAYER.player_name%TYPE;
    v_health_total      STATS.health%TYPE;
    v_avg_healing       MEDICAL.health_effect%TYPE;
    --numarul de minute supravietuite
    v_min               NUMBER;
    v_ret               VARCHAR2(25);
    
    --exceptii
    e_player_dead               EXCEPTION;
    e_player_epi_only           EXCEPTION;
    e_player_no_medical         EXCEPTION;
    e_player_not_found          EXCEPTION;
    
    BEGIN
        v_medical := 0;
        v_medical_it := 0;
        
        --calculam media abilitatilor medicale
        --ale jucatorilor
        SELECt avg(health_ability)
        INTO v_avg_healing
        FROM(
            SELECT p.player_id, sum(m.health_effect) as health_ability
            FROM player p
            JOIN inventory i on i.player_id = p.player_id
            JOIN contains c on c.inventory_id = i.inventory_id
            JOIN medical m on m.item_id = c.item_id
            GROUP BY p.player_id
            );
            
        --gasim id-ul si numele jucatorului
        SELECT p.player_id, p.player_name
        INTO v_pid, v_name
        FROM PLAYER p
        WHERE UPPER(p.player_name) LIKE UPPER(p_name);
        
        --gasim viata initiala a jucatorului
        SELECT s.health
        INTO v_health_total
        FROM STATS s
        WHERE s.player_id = v_pid;
        
        --calculam abilitatea medicala a jucatorului
        FOR i IN player_medical(v_pid) LOOP
            v_medical := v_medical + i.health_effect;
            v_medical_it := v_medical_it + 1;
        END LOOP;
        
        IF v_health_total = 0 THEN
            RAISE e_player_dead;
        END IF;
        
        v_health_total := v_health_total + v_medical;
        v_min := FLOOR(v_health_total / 15);
        
        IF v_medical < v_avg_healing THEN
            v_ret := 'sub medie';
        ELSIF v_medical = v_avg_healing THEN
            v_ret := 'medii';
        ELSE
            v_ret := 'peste medie';
        END IF;
        
        IF v_medical = 0 AND v_medical_it = 0 THEN
            RAISE e_player_no_medical;
        ELSIF v_medical = 0 AND v_medical_it <> 0 THEN
            RAISE e_player_epi_only;
        END IF;
        
        --returnam info
        RETURN 'Jucatorul ' || v_name || ' are abilitatea medicala ' ||
                v_medical || ' si poate rezista ' || v_min || ' minute.' ||
                ' Jucatorul are abilitati medicale ' || v_ret;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'Nu a fost gasit un jucator cu numele dat';
        WHEN e_player_no_medical THEN
            RETURN 'Jucatorul nu are iteme medicale';
        WHEN e_player_epi_only THEN
            RETURN 'Jucatorul are doar EpiPen-uri in inventar';
        WHEN e_player_dead THEN
            RETURN 'Personajul jucatorului nu mai este in viata';
    END player_health_data;
    
    
    --9
    PROCEDURE best_weapon
    (n_name NPC.npc_name%TYPE,
    s_rate NPC_IN_BIOMES.spawn_rate%TYPE) IS
    
    TYPE players_vect IS VARRAY(25) OF VARCHAR2(50);
    
    v_biome_name        BIOME.biome_name%TYPE;
    v_item_id           ITEM.item_id%TYPE;
    v_item_name         ITEM.item_name%TYPE;
    v_item_dmg          FIREARMS.damage%TYPE;
    v_players           players_vect := players_vect();
    
    e_no_players        EXCEPTION;
    
    BEGIN
    --gasim biome-ul in care npc-ul dat se spawneaza 
    --cu spawn rate-ul dat
    BEGIN
        SELECT b.biome_name
        INTO v_biome_name
        FROM BIOME b
        JOIN NPC_IN_BIOMES nb on nb.biome_id = b.biome_id
        JOIN NPC n on n.npc_id = nb.npc_id
        WHERE UPPER(n.npc_name) LIKE UPPER(n_name)
            AND UPPER(nb.spawn_rate) LIKE UPPER(s_rate);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NPC-ul dat nu se spawneaza in niciun biome cu spawn rate-ul dat.');
            RETURN; --iesim din procedura
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Npc-ul dat se spawneaza cu spawn rate-ul dat in mai multe biome-uri.');
            RETURN;
    END;
    
    DBMS_OUTPUT.PUT_LINE(v_biome_name);
    
    --cautam arma cu cel mai mult damage
    --din biome-ul gasit
    BEGIN
        SELECT wd.item_id, wd.item_name
        INTO v_item_id, v_item_name
        FROM weapons_damage wd
        JOIN ITEMS_IN_BIOMES ib on ib.item_id = wd.item_id
        JOIN BIOME b on b.biome_id = ib.biome_id
        WHERE UPPER(b.biome_name) LIKE UPPER(v_biome_name)
        AND wd.damage = (SELECT MAX(wd.damage) 
                         FROM weapons_damage wd
                         JOIN ITEMS_IN_BIOMES ib on ib.item_id = wd.item_id
                         JOIN BIOME b on b.biome_id = ib.biome_id
                         WHERE UPPER(b.biome_name) LIKE UPPER(v_biome_name)
                         );
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu se spawneaza arme in biome-ul gasit.');
            RETURN;
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Se spawneaza mai multe arme cu putere maxima in biome-ul gasit.');
            RETURN;
    END;
    
    DBMS_OUTPUT.PUT_LINE(v_item_name);
    
    --verificam daca arma apare in 
    --inventarul unui jucator
    SELECT p.player_name
    BULK COLLECT INTO v_players
    FROM PLAYER p
    JOIN INVENTORY i on i.player_id = p.player_id
    JOIN CONTAINS C on c.inventory_id = i.inventory_id
    JOIN LOCATION l on l.player_id = p.player_id
    JOIN BIOME B on b.biome_id = l.biome_id
    WHERE UPPER(b.biome_name) LIKE UPPER(v_biome_name)
    AND c.item_id = v_item_id;
    
    IF v_players.COUNT = 0 THEN
        RAISE e_no_players;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Jucatorii din biome-ul gasit care detin item-ul de putere maxima:');
    FOR i IN v_players.FIRST..v_players.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(v_players(i));
    END LOOP;
    
    EXCEPTION
        WHEN e_no_players THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista jucatori in biome-ul gasit care sa detine item-ul de putere maxima');
    END best_weapon;

END FUNC_PROC;
/
