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
