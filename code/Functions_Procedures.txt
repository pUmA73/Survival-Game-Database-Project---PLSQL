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
