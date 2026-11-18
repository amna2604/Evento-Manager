
INSERT INTO cities (name) VALUES ('Sarajevo'), ('Zenica'), ('Mostar'), ('Banja Luka'), ('Tuzla'), ('Bihać'), ('Travnik'), ('Doboj'), ('Brčko'), ('Livno'), ('Trebinje'), ('Goražde');

INSERT INTO users (username, password_hash, full_name, role, city_id) VALUES ('menadzer', '{{DEMO_HASH}}', 'Amna Bećak', 'MENADZER', NULL);
INSERT INTO users (username, password_hash, full_name, role, city_id) VALUES ('menadzer2', '{{DEMO_HASH}}', 'Adnan Hodžić', 'MENADZER', NULL);
INSERT INTO users (username, password_hash, full_name, role, city_id) VALUES ('tarik.mehic', '{{DEMO_HASH}}', 'Tarik Mehić', 'KOORDINATOR', (SELECT id FROM cities WHERE name = 'Sarajevo'));
INSERT INTO users (username, password_hash, full_name, role, city_id) VALUES ('emir.hadzic', '{{DEMO_HASH}}', 'Emir Hadžić', 'KOORDINATOR', (SELECT id FROM cities WHERE name = 'Zenica'));
INSERT INTO users (username, password_hash, full_name, role, city_id) VALUES ('lejla.kovac', '{{DEMO_HASH}}', 'Lejla Kovač', 'KOORDINATOR', (SELECT id FROM cities WHERE name = 'Mostar'));
INSERT INTO users (username, password_hash, full_name, role, city_id) VALUES ('selma.begic', '{{DEMO_HASH}}', 'Selma Begić', 'KOORDINATOR', (SELECT id FROM cities WHERE name = 'Tuzla'));
INSERT INTO users (username, password_hash, full_name, role, city_id) VALUES ('dino.savic', '{{DEMO_HASH}}', 'Dino Savić', 'KOORDINATOR', (SELECT id FROM cities WHERE name = 'Banja Luka'));

INSERT INTO clients (name, contact) VALUES ('Konzum', 'nabavka@konzum.example'), ('Bingo', 'marketing@bingo.example'), ('DM', 'promocije@dm.example'), ('Amko', 'komercijala@amko.example');

INSERT INTO products (name, client_id, stock_qty) VALUES ('Kafa Aroma 200g', (SELECT id FROM clients WHERE name = 'Konzum'), 900);
INSERT INTO products (name, client_id, stock_qty) VALUES ('Čokolada Mliječna 100g', (SELECT id FROM clients WHERE name = 'Konzum'), 1500);
INSERT INTO products (name, client_id, stock_qty) VALUES ('Sok od narandže 1L', (SELECT id FROM clients WHERE name = 'Bingo'), 1200);
INSERT INTO products (name, client_id, stock_qty) VALUES ('Napolitanke 250g', (SELECT id FROM clients WHERE name = 'Bingo'), 1000);
INSERT INTO products (name, client_id, stock_qty) VALUES ('Šampon Fresh 250ml', (SELECT id FROM clients WHERE name = 'DM'), 800);
INSERT INTO products (name, client_id, stock_qty) VALUES ('Krema za ruke 75ml', (SELECT id FROM clients WHERE name = 'DM'), 700);
INSERT INTO products (name, client_id, stock_qty) VALUES ('Deterdžent Plus 2kg', (SELECT id FROM clients WHERE name = 'Amko'), 500);
INSERT INTO products (name, client_id, stock_qty) VALUES ('Omekšivač Lavanda 1L', (SELECT id FROM clients WHERE name = 'Amko'), 650);
INSERT INTO stock_changes (product_id, delta, reason, user_id) SELECT id, stock_qty, 'Početno stanje', (SELECT id FROM users WHERE username = 'menadzer') FROM products;

INSERT INTO equipment (name, category, total_qty) VALUES ('Promotivni pult', 'Pultovi', 12), ('Stalak za proizvode', 'Stalci', 20), ('Roll-up banner', 'Banneri', 15), ('Šator 3x3', 'Šatori', 6), ('Barska stolica', 'Namještaj', 30);

INSERT INTO promoters (full_name, phone, city_id) VALUES ('Amila Salihović', '061 111 201', (SELECT id FROM cities WHERE name = 'Zenica'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Haris Zukić', '061 111 202', (SELECT id FROM cities WHERE name = 'Zenica'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Ena Muratović', '061 111 203', (SELECT id FROM cities WHERE name = 'Zenica'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Nejra Hodžić', '062 222 301', (SELECT id FROM cities WHERE name = 'Sarajevo'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Kenan Ibrahimović', '062 222 302', (SELECT id FROM cities WHERE name = 'Sarajevo'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Lamija Džafić', '062 222 303', (SELECT id FROM cities WHERE name = 'Sarajevo'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Armin Selimović', '062 222 304', (SELECT id FROM cities WHERE name = 'Sarajevo'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Ivana Marić', '063 333 401', (SELECT id FROM cities WHERE name = 'Mostar'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Matej Perić', '063 333 402', (SELECT id FROM cities WHERE name = 'Mostar'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Sara Kordić', '063 333 403', (SELECT id FROM cities WHERE name = 'Mostar'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Adna Čaušević', '061 444 501', (SELECT id FROM cities WHERE name = 'Tuzla'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Benjamin Hrustić', '061 444 502', (SELECT id FROM cities WHERE name = 'Tuzla'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Milica Jovanović', '065 555 601', (SELECT id FROM cities WHERE name = 'Banja Luka'));
INSERT INTO promoters (full_name, phone, city_id) VALUES ('Nikola Babić', '065 555 602', (SELECT id FROM cities WHERE name = 'Banja Luka'));

-- promocije
INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Konzum – Zenica', (SELECT id FROM clients WHERE name = 'Konzum'), (SELECT id FROM cities WHERE name = 'Zenica'), 'Konzum Zenica, Fra Ivana Jukića', DATE_ADD(CURDATE(), INTERVAL -40 DAY), 'ZAVRSENA', (SELECT id FROM users WHERE username = 'emir.hadzic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p1 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p1, id, 240, 196, 40, 40, 40 FROM products WHERE name = 'Kafa Aroma 200g';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p1, id, 300, 251, 60, 60, 45 FROM products WHERE name = 'Čokolada Mliječna 100g';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p1, id, 40.00 FROM promoters WHERE full_name = 'Amila Salihović';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p1, id, 40.00 FROM promoters WHERE full_name = 'Haris Zukić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p1, (SELECT id FROM cities WHERE name = 'Zenica'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -42 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p1, (SELECT id FROM cities WHERE name = 'Zenica'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -39 DAY), NULL, (SELECT id FROM users WHERE username = 'emir.hadzic') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p1, (SELECT id FROM cities WHERE name = 'Zenica'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -42 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Roll-up banner';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p1, (SELECT id FROM cities WHERE name = 'Zenica'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -39 DAY), NULL, (SELECT id FROM users WHERE username = 'emir.hadzic') FROM equipment WHERE name = 'Roll-up banner';
INSERT INTO reports (promotion_id, author_id, summary, status, submitted_at, reviewed_at, reviewer_id, manager_comment) VALUES (@p1, (SELECT id FROM users WHERE username = 'emir.hadzic'), 'Promocija je protekla odlično. Veliko interesovanje za kafu, degustacija je privukla porodice s djecom. Gratis proizvodi su podijeljeni do 14 časova.', 'ODOBREN', DATE_ADD(NOW(), INTERVAL -39 DAY), DATE_ADD(NOW(), INTERVAL -37 DAY), (SELECT id FROM users WHERE username = 'menadzer'), NULL);

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Bingo – Sarajevo', (SELECT id FROM clients WHERE name = 'Bingo'), (SELECT id FROM cities WHERE name = 'Sarajevo'), 'Bingo City Center Sarajevo', DATE_ADD(CURDATE(), INTERVAL -33 DAY), 'ZAVRSENA', (SELECT id FROM users WHERE username = 'tarik.mehic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p2 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p2, id, 360, 300, 50, 50, 50 FROM products WHERE name = 'Sok od narandže 1L';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p2, id, 280, 221, 40, 40, 39 FROM products WHERE name = 'Napolitanke 250g';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p2, id, 40.00 FROM promoters WHERE full_name = 'Nejra Hodžić';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p2, id, 40.00 FROM promoters WHERE full_name = 'Kenan Ibrahimović';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p2, id, 40.00 FROM promoters WHERE full_name = 'Lamija Džafić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p2, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'POSLANO', 2, DATE_ADD(CURDATE(), INTERVAL -35 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p2, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'VRACENO', 2, DATE_ADD(CURDATE(), INTERVAL -32 DAY), NULL, (SELECT id FROM users WHERE username = 'tarik.mehic') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p2, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'POSLANO', 2, DATE_ADD(CURDATE(), INTERVAL -35 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Stalak za proizvode';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p2, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'VRACENO', 2, DATE_ADD(CURDATE(), INTERVAL -32 DAY), NULL, (SELECT id FROM users WHERE username = 'tarik.mehic') FROM equipment WHERE name = 'Stalak za proizvode';
INSERT INTO reports (promotion_id, author_id, summary, status, submitted_at, reviewed_at, reviewer_id, manager_comment) VALUES (@p2, (SELECT id FROM users WHERE username = 'tarik.mehic'), 'Veliki broj posjetilaca vikendom. Sok se prodavao brže od očekivanog, napolitanke su se najviše uzimale kao gratis.', 'ODOBREN', DATE_ADD(NOW(), INTERVAL -32 DAY), DATE_ADD(NOW(), INTERVAL -30 DAY), (SELECT id FROM users WHERE username = 'menadzer'), NULL);

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('DM – Mostar', (SELECT id FROM clients WHERE name = 'DM'), (SELECT id FROM cities WHERE name = 'Mostar'), 'DM Mostar, Rondo', DATE_ADD(CURDATE(), INTERVAL -27 DAY), 'ZAVRSENA', (SELECT id FROM users WHERE username = 'lejla.kovac'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p3 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p3, id, 200, 162, 30, 30, 38 FROM products WHERE name = 'Šampon Fresh 250ml';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p3, id, 180, 131, 30, 28, 49 FROM products WHERE name = 'Krema za ruke 75ml';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p3, id, 50.00 FROM promoters WHERE full_name = 'Ivana Marić';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p3, id, 50.00 FROM promoters WHERE full_name = 'Matej Perić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p3, (SELECT id FROM cities WHERE name = 'Mostar'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -29 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p3, (SELECT id FROM cities WHERE name = 'Mostar'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -26 DAY), NULL, (SELECT id FROM users WHERE username = 'lejla.kovac') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p3, (SELECT id FROM cities WHERE name = 'Mostar'), 'POSLANO', 2, DATE_ADD(CURDATE(), INTERVAL -29 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Barska stolica';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p3, (SELECT id FROM cities WHERE name = 'Mostar'), 'VRACENO', 2, DATE_ADD(CURDATE(), INTERVAL -26 DAY), NULL, (SELECT id FROM users WHERE username = 'lejla.kovac') FROM equipment WHERE name = 'Barska stolica';
INSERT INTO reports (promotion_id, author_id, summary, status, submitted_at, reviewed_at, reviewer_id, manager_comment) VALUES (@p3, (SELECT id FROM users WHERE username = 'lejla.kovac'), 'Promocija bez problema. Kupci su najviše tražili uzorke kreme za ruke.', 'ODOBREN', DATE_ADD(NOW(), INTERVAL -26 DAY), DATE_ADD(NOW(), INTERVAL -24 DAY), (SELECT id FROM users WHERE username = 'menadzer'), NULL);

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Konzum – Tuzla', (SELECT id FROM clients WHERE name = 'Konzum'), (SELECT id FROM cities WHERE name = 'Tuzla'), 'Konzum Tuzla, Slatina', DATE_ADD(CURDATE(), INTERVAL -21 DAY), 'ZAVRSENA', (SELECT id FROM users WHERE username = 'selma.begic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p4 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p4, id, 260, 205, 40, 40, 55 FROM products WHERE name = 'Kafa Aroma 200g';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p4, id, 320, 270, 60, 60, 50 FROM products WHERE name = 'Čokolada Mliječna 100g';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p4, id, 40.00 FROM promoters WHERE full_name = 'Adna Čaušević';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p4, id, 40.00 FROM promoters WHERE full_name = 'Benjamin Hrustić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p4, (SELECT id FROM cities WHERE name = 'Tuzla'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -23 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p4, (SELECT id FROM cities WHERE name = 'Tuzla'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -20 DAY), NULL, (SELECT id FROM users WHERE username = 'selma.begic') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO reports (promotion_id, author_id, summary, status, submitted_at, reviewed_at, reviewer_id, manager_comment) VALUES (@p4, (SELECT id FROM users WHERE username = 'selma.begic'), 'Dobra posjećenost u poslijepodnevnim satima. Čokolada je rasprodata prije kraja promocije.', 'PREDAN', DATE_ADD(NOW(), INTERVAL -20 DAY), NULL, NULL, NULL);

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Bingo – Zenica', (SELECT id FROM clients WHERE name = 'Bingo'), (SELECT id FROM cities WHERE name = 'Zenica'), 'Bingo Zenica, Crkvice', DATE_ADD(CURDATE(), INTERVAL -16 DAY), 'ZAVRSENA', (SELECT id FROM users WHERE username = 'emir.hadzic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p5 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p5, id, 300, 248, 50, 50, 52 FROM products WHERE name = 'Sok od narandže 1L';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p5, id, 250, 204, 40, 40, 46 FROM products WHERE name = 'Napolitanke 250g';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p5, id, 40.00 FROM promoters WHERE full_name = 'Amila Salihović';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p5, id, 40.00 FROM promoters WHERE full_name = 'Haris Zukić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p5, (SELECT id FROM cities WHERE name = 'Zenica'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -18 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Šator 3x3';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p5, (SELECT id FROM cities WHERE name = 'Zenica'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -15 DAY), NULL, (SELECT id FROM users WHERE username = 'emir.hadzic') FROM equipment WHERE name = 'Šator 3x3';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p5, (SELECT id FROM cities WHERE name = 'Zenica'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -18 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Stalak za proizvode';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p5, (SELECT id FROM cities WHERE name = 'Zenica'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -15 DAY), NULL, (SELECT id FROM users WHERE username = 'emir.hadzic') FROM equipment WHERE name = 'Stalak za proizvode';
INSERT INTO reports (promotion_id, author_id, summary, status, submitted_at, reviewed_at, reviewer_id, manager_comment) VALUES (@p5, (SELECT id FROM users WHERE username = 'emir.hadzic'), 'Vremenski uslovi su bili povoljni, promocija održana na otvorenom ispred objekta.', 'ODOBREN', DATE_ADD(NOW(), INTERVAL -15 DAY), DATE_ADD(NOW(), INTERVAL -13 DAY), (SELECT id FROM users WHERE username = 'menadzer'), NULL);

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Amko – Banja Luka', (SELECT id FROM clients WHERE name = 'Amko'), (SELECT id FROM cities WHERE name = 'Banja Luka'), 'Amko Banja Luka, Centar', DATE_ADD(CURDATE(), INTERVAL -12 DAY), 'ZAVRSENA', (SELECT id FROM users WHERE username = 'dino.savic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p6 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p6, id, 150, 98, 20, 18, 52 FROM products WHERE name = 'Deterdžent Plus 2kg';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p6, id, 160, 115, 20, 20, 45 FROM products WHERE name = 'Omekšivač Lavanda 1L';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p6, id, 40.00 FROM promoters WHERE full_name = 'Milica Jovanović';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p6, id, 40.00 FROM promoters WHERE full_name = 'Nikola Babić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p6, (SELECT id FROM cities WHERE name = 'Banja Luka'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -14 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p6, (SELECT id FROM cities WHERE name = 'Banja Luka'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -11 DAY), NULL, (SELECT id FROM users WHERE username = 'dino.savic') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO reports (promotion_id, author_id, summary, status, submitted_at, reviewed_at, reviewer_id, manager_comment) VALUES (@p6, (SELECT id FROM users WHERE username = 'dino.savic'), 'Promocija održana prema planu.', 'VRACEN', DATE_ADD(NOW(), INTERVAL -11 DAY), DATE_ADD(NOW(), INTERVAL -9 DAY), (SELECT id FROM users WHERE username = 'menadzer'), 'Dopunite izvještaj brojem posjetilaca i razlogom slabije prodaje deterdženta.');

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Konzum – Sarajevo', (SELECT id FROM clients WHERE name = 'Konzum'), (SELECT id FROM cities WHERE name = 'Sarajevo'), 'Konzum Sarajevo, Alipašino Polje', DATE_ADD(CURDATE(), INTERVAL -9 DAY), 'ZAVRSENA', (SELECT id FROM users WHERE username = 'tarik.mehic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p7 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p7, id, 280, 232, 40, 40, 48 FROM products WHERE name = 'Kafa Aroma 200g';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p7, id, 340, 290, 60, 59, 50 FROM products WHERE name = 'Čokolada Mliječna 100g';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p7, id, 40.00 FROM promoters WHERE full_name = 'Nejra Hodžić';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p7, id, 40.00 FROM promoters WHERE full_name = 'Kenan Ibrahimović';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p7, id, 40.00 FROM promoters WHERE full_name = 'Lamija Džafić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p7, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -11 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p7, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -8 DAY), NULL, (SELECT id FROM users WHERE username = 'tarik.mehic') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p7, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'POSLANO', 2, DATE_ADD(CURDATE(), INTERVAL -11 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Roll-up banner';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p7, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'VRACENO', 2, DATE_ADD(CURDATE(), INTERVAL -8 DAY), NULL, (SELECT id FROM users WHERE username = 'tarik.mehic') FROM equipment WHERE name = 'Roll-up banner';

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('DM – Sarajevo', (SELECT id FROM clients WHERE name = 'DM'), (SELECT id FROM cities WHERE name = 'Sarajevo'), 'DM Sarajevo, SCC', DATE_ADD(CURDATE(), INTERVAL -5 DAY), 'ZAVRSENA', (SELECT id FROM users WHERE username = 'tarik.mehic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p8 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p8, id, 220, 184, 30, 30, 36 FROM products WHERE name = 'Šampon Fresh 250ml';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p8, id, 200, 170, 30, 30, 30 FROM products WHERE name = 'Krema za ruke 75ml';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p8, id, 50.00 FROM promoters WHERE full_name = 'Nejra Hodžić';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p8, id, 50.00 FROM promoters WHERE full_name = 'Kenan Ibrahimović';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p8, id, 50.00 FROM promoters WHERE full_name = 'Lamija Džafić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p8, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -7 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p8, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -4 DAY), NULL, (SELECT id FROM users WHERE username = 'tarik.mehic') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p8, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'POSLANO', 2, DATE_ADD(CURDATE(), INTERVAL -7 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Barska stolica';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p8, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'VRACENO', 2, DATE_ADD(CURDATE(), INTERVAL -4 DAY), NULL, (SELECT id FROM users WHERE username = 'tarik.mehic') FROM equipment WHERE name = 'Barska stolica';
INSERT INTO reports (promotion_id, author_id, summary, status, submitted_at, reviewed_at, reviewer_id, manager_comment) VALUES (@p8, (SELECT id FROM users WHERE username = 'tarik.mehic'), 'Izuzetno dobra realizacija, plan je ispunjen u cijelosti.', 'ODOBREN', DATE_ADD(NOW(), INTERVAL -4 DAY), DATE_ADD(NOW(), INTERVAL -2 DAY), (SELECT id FROM users WHERE username = 'menadzer'), NULL);

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Bingo – Mostar', (SELECT id FROM clients WHERE name = 'Bingo'), (SELECT id FROM cities WHERE name = 'Mostar'), 'Bingo Mostar, Avenija', DATE_ADD(CURDATE(), INTERVAL -2 DAY), 'ZAVRSENA', (SELECT id FROM users WHERE username = 'lejla.kovac'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p9 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p9, id, 260, 211, 40, 40, 49 FROM products WHERE name = 'Sok od narandže 1L';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p9, id, 240, 190, 40, 38, 50 FROM products WHERE name = 'Napolitanke 250g';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p9, id, 40.00 FROM promoters WHERE full_name = 'Ivana Marić';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p9, id, 40.00 FROM promoters WHERE full_name = 'Matej Perić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p9, (SELECT id FROM cities WHERE name = 'Mostar'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -4 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Šator 3x3';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p9, (SELECT id FROM cities WHERE name = 'Mostar'), 'VRACENO', 1, DATE_ADD(CURDATE(), INTERVAL -1 DAY), NULL, (SELECT id FROM users WHERE username = 'lejla.kovac') FROM equipment WHERE name = 'Šator 3x3';

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Konzum – Zenica', (SELECT id FROM clients WHERE name = 'Konzum'), (SELECT id FROM cities WHERE name = 'Zenica'), 'Konzum Zenica, Bulevar Kulina Bana', DATE_ADD(CURDATE(), INTERVAL 0 DAY), 'U_TOKU', (SELECT id FROM users WHERE username = 'emir.hadzic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p10 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p10, id, 240, 60, 40, 12, 0 FROM products WHERE name = 'Kafa Aroma 200g';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p10, id, 300, 85, 60, 20, 0 FROM products WHERE name = 'Čokolada Mliječna 100g';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p10, id, 40.00 FROM promoters WHERE full_name = 'Amila Salihović';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p10, id, 40.00 FROM promoters WHERE full_name = 'Haris Zukić';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p10, (SELECT id FROM cities WHERE name = 'Zenica'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -2 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Promotivni pult';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p10, (SELECT id FROM cities WHERE name = 'Zenica'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -2 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Roll-up banner';

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Amko – Sarajevo', (SELECT id FROM clients WHERE name = 'Amko'), (SELECT id FROM cities WHERE name = 'Sarajevo'), 'Amko Sarajevo, Ilidža', DATE_ADD(CURDATE(), INTERVAL 1 DAY), 'PLANIRANA', (SELECT id FROM users WHERE username = 'tarik.mehic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p11 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p11, id, 180, 0, 30, 0, 0 FROM products WHERE name = 'Deterdžent Plus 2kg';
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p11, id, 200, 0, 30, 0, 0 FROM products WHERE name = 'Omekšivač Lavanda 1L';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p11, id, 40.00 FROM promoters WHERE full_name = 'Nejra Hodžić';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p11, id, 40.00 FROM promoters WHERE full_name = 'Kenan Ibrahimović';
INSERT INTO equipment_movements (equipment_id, promotion_id, city_id, movement_type, qty, moved_on, note, user_id) SELECT id, @p11, (SELECT id FROM cities WHERE name = 'Sarajevo'), 'POSLANO', 1, DATE_ADD(CURDATE(), INTERVAL -1 DAY), NULL, (SELECT id FROM users WHERE username = 'menadzer') FROM equipment WHERE name = 'Promotivni pult';

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('DM – Tuzla', (SELECT id FROM clients WHERE name = 'DM'), (SELECT id FROM cities WHERE name = 'Tuzla'), 'DM Tuzla, Tuzla City Center', DATE_ADD(CURDATE(), INTERVAL 6 DAY), 'PLANIRANA', (SELECT id FROM users WHERE username = 'selma.begic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p12 = LAST_INSERT_ID();
INSERT INTO promotion_products (promotion_id, product_id, sent_qty, sold_qty, free_sent, free_given, remaining_qty) SELECT @p12, id, 200, 0, 30, 0, 0 FROM products WHERE name = 'Šampon Fresh 250ml';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p12, id, 40.00 FROM promoters WHERE full_name = 'Adna Čaušević';
INSERT INTO promotion_promoters (promotion_id, promoter_id, allowance) SELECT @p12, id, 40.00 FROM promoters WHERE full_name = 'Benjamin Hrustić';

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Konzum – Mostar', (SELECT id FROM clients WHERE name = 'Konzum'), (SELECT id FROM cities WHERE name = 'Mostar'), 'Konzum Mostar, Zalik', DATE_ADD(CURDATE(), INTERVAL 12 DAY), 'PLANIRANA', (SELECT id FROM users WHERE username = 'lejla.kovac'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p13 = LAST_INSERT_ID();

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('Bingo – Banja Luka', (SELECT id FROM clients WHERE name = 'Bingo'), (SELECT id FROM cities WHERE name = 'Banja Luka'), 'Bingo Banja Luka, Borik', DATE_ADD(CURDATE(), INTERVAL 20 DAY), 'PLANIRANA', (SELECT id FROM users WHERE username = 'dino.savic'), NULL, (SELECT id FROM users WHERE username = 'menadzer'));
SET @p14 = LAST_INSERT_ID();

INSERT INTO promotions (title, client_id, city_id, location, promo_date, status, coordinator_id, notes, created_by) VALUES ('DM – Zenica', (SELECT id FROM clients WHERE name = 'DM'), (SELECT id FROM cities WHERE name = 'Zenica'), 'DM Zenica, Centar', DATE_ADD(CURDATE(), INTERVAL -7 DAY), 'OTKAZANA', (SELECT id FROM users WHERE username = 'emir.hadzic'), 'Otkazano zbog nedostupnosti lokacije.', (SELECT id FROM users WHERE username = 'menadzer'));
SET @p15 = LAST_INSERT_ID();

-- Menadzer odredjuje dnevnicu i broj potrebnih promotera po promociji
UPDATE promotions p SET p.allowance = 40.00,
    p.required_promoters = GREATEST(2, (SELECT COUNT(*) FROM promotion_promoters pp WHERE pp.promotion_id = p.id));
UPDATE promotion_promoters SET allowance = 40.00;
UPDATE promotions SET notes = 'Uniforma: crna majica s Evento logom i crne hlače. Dolazak 30 minuta ranije radi postavljanja pulta.'
    WHERE notes IS NULL;


-- Zavrsena promocija mora imati odobren izvjestaj; ako izvjestaj jos nije odobren, promocija je "u toku"
INSERT INTO reports (promotion_id, author_id, summary, status, submitted_at, reviewed_at, reviewer_id)
    SELECT p.id, p.coordinator_id, 'Promocija je realizovana prema planu, odziv kupaca je bio dobar.', 'ODOBREN',
           NOW(), NOW(), (SELECT id FROM users WHERE username = 'menadzer')
    FROM promotions p LEFT JOIN reports r ON r.promotion_id = p.id
    WHERE p.status = 'ZAVRSENA' AND r.id IS NULL;
UPDATE promotions p JOIN reports r ON r.promotion_id = p.id SET p.status = 'U_TOKU'
    WHERE p.status = 'ZAVRSENA' AND r.status <> 'ODOBREN';
