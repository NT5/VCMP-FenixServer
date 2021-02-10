CREATE TABLE IF NOT EXISTS data (
	name VARCHAR(32) NOT NULL, 
	param VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS web_coments (
	id 			MEDIUMINT NOT NULL AUTO_INCREMENT,
	nick 		VARCHAR(32) NOT NULL,
	text 		VARCHAR(500) NOT NULL,
	sec 		VARCHAR(50) NOT NULL,
	date 		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS users (
	id 			MEDIUMINT NOT NULL AUTO_INCREMENT,
	name 		VARCHAR(32) NOT NULL,
	ip 			VARCHAR(32) NOT NULL,
	level 		INT(35) NOT NULL DEFAULT '1',
	password 	VARCHAR(32) NOT NULL,
	datereg 	VARCHAR(32) NOT NULL,
	lastactive 	INT(35) NOT NULL,
	cash 		INT(35) NOT NULL DEFAULT '2000',
	bank 		INT(35) NOT NULL DEFAULT '0',
	kills 		INT(35) NOT NULL DEFAULT '0',
	deaths 		INT(35)	NOT NULL DEFAULT '0',
	joins 		INT(35) NOT NULL DEFAULT '1',
	spree 		INT(35) NOT NULL DEFAULT '0',
	pickups 	INT(35) NOT NULL DEFAULT '0',
	weps 		VARCHAR(35)	NOT NULL DEFAULT '0',
	locspw 		VARCHAR(50) NOT NULL DEFAULT '0',
	skin 		INT(32) NOT NULL DEFAULT '0',
	ccars 		INT(32)	NOT NULL DEFAULT '0',
	cprops 		INT(32) NOT NULL DEFAULT '0',
	nogoto 		VARCHAR(32) NOT NULL DEFAULT 'false',
	clan 		VARCHAR(32)	NOT NULL DEFAULT '0',
	isonline	VARCHAR(32) NOT NULL DEFAULT 'true',
	cgotolocs	INT(35) NOT NULL DEFAULT '0',
	playedtime	INT(35) NOT NULL DEFAULT '0',
	cookies		INT(35) NOT NULL DEFAULT '0',
	wstats		VARCHAR(135) NOT NULL DEFAULT '0,0,0,0,0',
	bstats		VARCHAR(135) NOT NULL DEFAULT '0,0,0,0,0,0,0',
	westats		VARCHAR(135) NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0',
	rustats		VARCHAR(135) NOT NULL DEFAULT '0,0,0,0,0,0',
	avatar		VARCHAR(135) NOT NULL DEFAULT 'skin;0',
	PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS bans (
	id 			MEDIUMINT NOT NULL AUTO_INCREMENT,
	banned		VARCHAR(32) NOT NULL,
	admin		VARCHAR(32) NOT NULL,
	reason		VARCHAR(32) NOT NULL,
	time		VARCHAR(32) NOT NULL,
	ip			VARCHAR(32) NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS gotoloc (
	id 			MEDIUMINT NOT NULL AUTO_INCREMENT,
	name		VARCHAR(32) NOT NULL,
	pos			VARCHAR(50) NOT NULL, 
	creator		VARCHAR(32) NOT NULL,
	createat	VARCHAR(32) NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS properties (
	id 		MEDIUMINT NOT NULL AUTO_INCREMENT,
	name	varchar(50)	NOT NULL,
	cost	int(32)	NOT NULL, 
	owner	varchar(32)	NOT NULL, 
	shared	varchar(32)	NOT NULL, 
	pos		varchar(50) NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS cars (
	id 		MEDIUMINT NOT NULL AUTO_INCREMENT,
	owner	VARCHAR(32) NOT NULL DEFAULT 'Vice City',
	shared	VARCHAR(32) NOT NULL DEFAULT 'None',
	autofix VARCHAR(32) NOT NULL DEFAULT 'false',
	model	INT(32) NOT NULL,
	pos		VARCHAR(50) NOT NULL,
	angle	VARCHAR(32) NOT NULL,
	col1	INT(32) NOT NULL,
	col2	INT(32) NOT NULL,
	locked	VARCHAR(32) NOT NULL DEFAULT 'false',
	cost 	INT(32) NOT NULL,
	PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS area ( 
	coordinates		VARCHAR(250) NOT NULL, 
	name			VARCHAR(250) NOT NULL
);
CREATE TABLE IF NOT EXISTS who_online (
	id		MEDIUMINT NOT NULL AUTO_INCREMENT,
	nick	VARCHAR(32) NOT NULL,
	ip		VARCHAR(40) NOT NULL,
	sec		VARCHAR(32)	NOT NULL,
	date	INT NOT NULL, 
	PRIMARY KEY (id)
);

INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('ShadyHospital', 850000, 'Vice City', 'None', '437.89 726.32 11.57');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('Mansion', 50000000, 'Vice City', 'None', '-367.54 -537.43 17.28');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('Docks', 658000, 'Vice City', 'None', '-687.33 -1487.71 12.4039');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('Airport', 750000, 'Vice City', 'None',	'-1439.75 -838.068 14.6037');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('Army', 900000, 'Vice City', 'None', '-1720.87 -299.198 14.4262');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('LittleHaitiHouse', 500000, 'Vice City', 'None', '-1203.61 -476.31 10.6992');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('LittleHaitiHouse#2', 500000, 'Vice City', 'None', '-1211 -415.117 10.673');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('Laundromat', 300000, 'Vice City', 'None', '-1199.05 -331.447 10.6679');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('PrintWorks', 200000, 'Vice City', 'None', '-1056.6 -279.092 11.0455');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('ViceCityBank', 20000000, 'Vice City', 'None', '-882.092 -341.74 10.8308');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('CherryPoppers', 550000, 'Vice City', 'None', '-863.306 -570.216 10.8348');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('CoffeeBaggelsDonuts', 750000, 'Vice City',	'None',	'-842.25 -639.4 10.8618');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('RytonAide', 200000, 'Vice City', 'None', '-852.114 -90.8045 10.8306');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('CafeUnderTheTree', 200000,	'Vice City', 'None', '-906.852 49.9396 9.88558');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('KaufmanCabs', 200000, 'Vice City',	'None',	'-1014.06 198.631 10.9891');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('TheWellStackedPizzaCo', 200000, 'Vice City', 'None', '-1062.14 82.3203 11.0216');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('TheGreasyChopper', 200000, 'Vice City', 'None', '-598.239 653.344 10.8106');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('VRock', 20000000, 'Vice City',	'None',	'-872.336 1158.34 10.8173');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('InterGlobalFilms', 200000,	'Vice City', 'None', '15.0102 963.581 10.4791');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('Supermarket', 200000, 'Vice City',	'None',	'444.536 789.701 12.4744');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('Malibu', 951000, 'Vice City', 'None',	'494.93 -82.7187 9.55442');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('ViceCityPoliceDepartment',	600000, 'Vice City', 'None', '402.14 -465.659 9.62736');
INSERT INTO properties (name, cost, owner, shared, pos) VALUES ('CarWash', 710000, 'Vice City', 'None',	'28.1095 -1045.27 10.4633');

INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (155, '-1661.2036 -225.9701 14.8505', '83.3180', 40, 44, 339316);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (155, '-873.5609 -514.8762 29.7712', '282.5007', 40, 44, 167342);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (155, '-1038.2277 1130.9781 11.3451', '274.1339', 40, 44, 196419);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (155, '-468.3839 1123.7159 65.3079', '88.4982', 40, 44, 98102);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (155, '321.2903 1201.2332 28.1161', '178.5563', 40, 44, 370361);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (155, '716.7575 -519.8978 11.5240', '165.8538', 40, 44, 375689);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (205, '-355.7897 -535.9080 12.5092', '4.3397', 3, 3, 217021);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (209, '-410.6376 -527.0338 12.5525', '275.1737', 6, 6, 526197);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (145, '-359.8691 -535.8032 12.5408', '356.0357', 5, 5, 296892);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (141, '-363.7001 -532.1904 12.4538', '347.5227', 2, 2, 260919);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (141, '-366.2142 -526.6016 12.4540', '359.6990', 7, 7, 141946);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-394.6138 -537.1057 12.2974', '359.3064', 5, 5, 103543);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-401.5360 -537.3189 12.3168', '359.9142', 2, 2, 283198);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (169, '-410.7701 -523.3267 12.6385', '270.6102', 16, 16, 260393);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '101.3112 -1472.5734 9.9520', '275.9431', 7, 7, 381137);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '100.1138 -1474.9864 9.9555', '243.1996', 15, 15, 445438);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (211, '141.4337 -1385.5070 10.1252', '343.3310', 9, 9, 121958);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (132, '147.1053 -1366.2797 10.1822', '343.5802', 6, 6, 193552);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (156, '352.9121 -509.6267 12.0988', '320.7182', 46, 1, 133898);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (156, '369.4714 -523.6237 12.0988', '319.9708', 46, 1, 403103);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (211, '532.6176 -96.9542 10.2353', '79.6783', 45, 2, 274373);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (226, '484.2974 -42.0803 9.8580', '333.0487', 52, 1, 166247);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (225, '481.7185 -25.1947 11.0715', '85.0637', 6, 7, 476404);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (205, '455.0549 -18.8138 10.4581', '267.9675', 35, 1, 215025);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (169, '454.7568 -12.8570 10.7062', '268.8576', 16, 16, 109343);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (141, '471.8977 12.4021 10.6871', '186.7825', 1, 1, 491654);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (141, '453.7359 10.7540 10.7088', '266.2419', 28, 27, 207285);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (157, '520.7169 504.3721 11.1159', '177.8511', 46, 1, 235199);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (156, '494.0657 503.6048 11.2553', '182.5556', 46, 1, 313364);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (156, '490.3721 521.4343 11.3486', '89.2152', 46, 1, 308738);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (132, '453.4685 633.3956 11.0608', '90.7212', 8, 8, 198759);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (146, '469.8637 704.9487 11.6146', '84.4378', 1, 3, 415569);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (146, '-132.0260 -981.7083 10.6752', '194.7364', 1, 3, 522489);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (146, '-772.1157 1155.0567 12.6203', '180.4138', 1, 3, 172499);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (146, '-770.7556 1116.4124 18.8367', '2.7757', 1, 3, 513504);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (190, '604.7857 -1706.5129 7.4566', '333.0661', 1, 60, 138566);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (190, '603.4500 -1774.8110 7.5805', '207.8898', 1, 14, 149422);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (156, '-665.3922 805.4310 11.0371', '179.7041', 46, 1, 381839);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (156, '-665.3419 783.4215 11.0371', '180.0830', 46, 1, 119603);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (156, '-650.4547 754.2271 11.2032', '266.7828', 46, 1, 214055);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (157, '-639.0488 753.5859 11.4639', '266.9841', 46, 1, 429804);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (156, '-600.3596 807.4459 11.2136', '264.7030', 46, 1, 269806);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-525.9127 768.2957 97.0324', '8.1124', 35, 35, 107767);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-527.6995 768.1677 97.0343', '359.7128', 0, 0, 128438);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-529.3516 768.2750 97.0345', '358.1087', 7, 7, 136342);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (166, '-611.0230 652.2448 10.5647', '8.8367', 11, 74, 96869);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (193, '-602.9445 653.2581 10.5621', '358.5604', 10, 71, 193056);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (166, '-591.7445 654.4235 10.5643', '8.0539', 25, 76, 397008);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (183, '329.7308 569.4691 5.9063', '4.4707', 5, 1, 522234);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (193, '-582.4561 657.0186 10.5647', '6.6960', 90, 90, 453883);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (173, '-668.7982 613.6912 11.6771', '350.3454', 3, 3, 112307);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-735.5886 340.5064 10.6218', '261.8460', 5, 5, 328635);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-735.5800 336.5397 10.6247', '263.3219', 3, 3, 188675);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-735.5842 338.5846 10.6218', '264.0640', 9, 9, 359993);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-735.5800 334.5397 10.6247', '263.3129', 1, 1, 243429);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (236, '-845.2182 -675.1942 10.9439', '97.3510', 6, 6, 203125);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (236, '-844.9033 -679.4935 10.9416', '98.8291', 52, 52, 124467);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (236, '-851.5042 -665.6492 10.9737', '185.1867', 76, 76, 222775);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (236, '-855.6010 -666.0065 10.9932', '183.6206', 7, 7, 126225);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (236, '-863.2755 -666.1619 11.0305', '186.5727', 3, 3, 103606);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (207, '-720.7308 -1553.2028 12.3923', '335.9179', 81, 81, 479956);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (207, '-708.7141 -1559.5433 12.4070', '346.3945', 81, 81, 340626);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (211, '-1013.3012 -865.1555 12.7761', '202.8330', 25, 25, 129491);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (211, '-999.5239 -896.5560 12.5799', '42.8032', 2, 2, 211652);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (141, '-1005.3701 -902.1212 12.5783', '38.6929', 5, 5, 310605);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (141, '-1017.0836 -861.9735 12.7768', '192.2738', 35, 7, 480195);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (145, '-1021.4221 -861.7324 12.8591', '151.5552', 1, 45, 168332);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (207, '-1025.9677 -859.9962 12.9394', '188.9649', 5, 5, 376126);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (200, '-1747.2423 -269.6883 15.1117', '267.0928', 43, 0, 232843);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (200, '-1711.8261 -289.4060 15.1119', '359.4779', 43, 0, 275708);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (200, '-1746.7600 -225.4839 15.1117', '267.6390', 43, 0, 368593);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (163, '-1704.9771 -215.9602 15.2650', '179.8796', 43, 0, 516141);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (163, '-1732.5675 -212.3486 15.2649', '183.0709', 43, 0, 451495);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '95.8123 -1476.1784 9.9575', '182.5865', 6, 6, 418862);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (217, '-70.3527 -1606.8555 12.1977', '0.0006', 10, 42, 358550);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-398.7438 -537.4730 12.3180', '355.9050', 20, 20, 378439);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (137, '-724.2396 858.9771 11.2810', '88.1088', 0, 3, 148352);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (137, '-723.9340 864.5758 11.2812', '90.4200', 0, 3, 388337);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (137, '-724.3687 870.5695 11.2806', '90.1351', 0, 3, 390376);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (137, '-724.7133 876.9135 11.2806', '90.3188', 6, 3, 355120);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (137, '-696.1973 901.8284 11.2424', '271.7752', 1, 3, 254873);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (137, '-695.5095 883.6483 11.1960', '270.2597', 1, 3, 156934);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (190, '-142.0807 1022.3297 7.5945', '9.5160', 1, 90, 436669);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (190, '583.7017 -1760.7885 7.6247', '312.6211', 1, 46, 224645);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (201, '-864.6494 1180.5012 11.0699', '180.4134', 7, 6, 229402);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-834.2752 1305.0163 11.1026', '181.6611', 2, 2, 476231);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (233, '-1028.1954 1332.3027 8.6057', '268.5036', 6, 53, 204457);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (192, '-693.5750 -1278.1439 10.6300', '108.5812', 9, 9, 401765);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (132, '-692.1820 -1289.1201 10.8214', '115.1771', 9, 9, 336988);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (132, '-689.2186 -1294.0223 10.8218', '123.6343', 9, 9, 98754);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (132, '-684.8660 -1301.3138 10.8203', '119.2524', 9, 9, 289975);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (176, '-573.5117 -1517.4057 5.7979', '252.4084', 5, 1, 85764);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (176, '-568.9426 -1507.8851 5.9991', '250.6528', 1, 5, 425073);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (159, '-237.0839 -1369.1921 7.8933', '289.7887', 3, 0, 421845);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (159, '-241.7758 -1350.5988 7.8934', '283.6990', 3, 0, 421027);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (139, '-382.3973 -513.8513 12.6770', '269.4877', 5, 5, 357486);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (139, '196.4936 -503.6637 11.2642', '267.3140', 0, 10, 202201);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (198, '140.7794 -376.3760 8.6282', '182.8132', 6, 6, 416318);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (198, '127.4903 -374.1673 9.3113', '178.8975', 5, 5, 83785);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (198, '124.1762 -372.6104 8.8606', '184.5148', 4, 4, 140830);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (198, '121.1902 -372.9187 8.4997', '185.9452', 3, 3, 473562);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (141, '222.8358 -350.8084 10.5370', '68.2189', 3, 3, 154211);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (141, '226.0070 -341.1736 10.9293', '85.9962', 3, 3, 304520);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (141, '227.9676 -333.8356 11.3579', '89.7273', 3, 3, 220069);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (198, '339.5845 -245.0503 29.2816', '91.9811', 1, 1, 297360);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (198, '339.9533 -254.5388 29.2814', '89.8723', 0, 0, 413916);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (198, '320.0248 -275.4447 35.5154', '268.3663', 10, 5, 484309);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (198, '319.7229 -278.2597 35.5154', '270.9614', 8, 7, 255866);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (236, '-64.8097 939.6323 10.7133', '272.9630', 8, 2, 271306);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (236, '-65.5755 943.8115 10.7133', '272.3669', 5, 4, 218340);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (236, '-59.2750 952.2020 10.7135', '268.9960', 0, 3, 415578);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (236, '-59.1240 956.8286 10.7131', '270.4151', 3, 9, 271131);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-788.5673 668.9824 10.6330', '270.2683', 1, 1, 379720);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (135, '-787.3134 671.8594 10.9138', '270.2481', 7, 7, 344333);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (224, '-835.3812 -901.8552 10.9476', '268.4930', 2, 3, 388041);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (176, '-373.5463 -660.3701 5.6582', '92.1358', 7, 0, 236498);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-698.8250 -1522.1745 12.1442', '67.1066', 38, 38, 275762);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (226, '-720.2053 -1523.1435 11.8685', '339.0321', 8, 1, 216007);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (174, '-737.1292 -1512.4899 11.8760', '246.7561', 40, 0, 142267);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (217, '-689.9738 -1562.2893 12.5111', '79.3132', 1, 42, 188864);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (132, '-733.9312 -1413.6185 10.9914', '252.8345', 33, 33, 169461);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (233, '-830.0571 -1092.0980 10.9736', '285.8478', 11, 22, 295658);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (232, '-820.7769 -1126.9465 10.9743', '284.1463', 5, 5, 202055);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (233, '-808.7830 -1161.8214 10.9722', '286.5209', 11, 22, 186493);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (232, '-796.3519 -1197.7965 10.9718', '289.6972', 11, 22, 313538);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (153, '-869.4132 -572.0134 11.1188', '274.6412', 1, 17, 512423);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-869.7263 -355.4869 10.4502', '357.5444', 5, 5, 405943);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (132, '-870.3109 -118.2221 10.8453', '243.5061', 8, 8, 463884);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (150, '-1009.4348 186.8303 11.1477', '351.5166', 6, 76, 501828);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (150, '-999.2227 191.0012 11.1682', '86.2164', 6, 76, 459394);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (150, '-998.6101 195.8627 11.1687', '82.1977', 6, 76, 103877);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (150, '-1005.9636 206.6894 11.0886', '173.5014', 6, 76, 314705);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (150, '-1001.3021 206.2028 11.1724', '160.5307', 6, 76, 228638);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (204, '-1174.4157 -581.6384 11.3232', '276.6130', 34, 9, 366790);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (164, '-1174.3928 -591.7186 11.3140', '276.5535', 35, 8, 183666);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (204, '-1173.8809 -601.5029 11.2750', '274.8974', 34, 9, 409964);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (164, '-1143.5413 -579.3961 11.4055', '184.8674', 34, 9, 146902);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (177, '-1432.2261 -808.7697 14.7537', '0.0008', 10, 42, 473206);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (220, '-1402.6175 -808.8862 14.9532', '358.7000', 6, 6, 363754);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (220, '-1468.7352 -807.2924 14.9527', '3.4951', 6, 6, 205055);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (177, '-853.3167 1354.7005 69.4320', '87.3268', 10, 42, 284387);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (177, '-614.0504 803.9625 29.5664', '2.0460', 10, 42, 350583);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (177, '-390.9079 -573.4663 39.9291', '269.4356', 10, 42, 194294);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (224, '-1225.5598 -1360.2966 14.7217', '335.6773', 2, 3, 439158);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (224, '-1218.6571 -1345.0224 14.6857', '335.6896', 2, 3, 503662);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (224, '-1228.8665 -1356.4835 14.7965', '334.3664', 2, 3, 371261);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (224, '-1224.3933 -1347.2371 14.7697', '333.0187', 2, 3, 233216);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (191, '-1190.5024 -1320.0052 14.4590', '65.5823', 0, 0, 466031);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (132, '80.7389 236.9228 21.1159', '131.3321', 6, 6, 119754);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (132, '112.2679 253.7335 21.5035', '198.3733', 6, 6, 107631);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (151, '87.2809 243.6531 21.5990', '289.7665', 30, 30, 412437);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (187, '101.6128 281.5596 21.3880', '80.3433', 44, 46, 492758);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (187, '77.4432 272.5776 21.3896', '332.0119', 6, 36, 479589);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (217, '295.7561 269.0374 17.6926', '2.6803', 10, 42, 250552);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (173, '-1142.8420 -1086.3798 15.4631', '108.9548', 3, 3, 117582);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (173, '-751.7457 75.6764 11.6802', '162.8578', 3, 3, 281737);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (152, '-839.7089 581.8538 10.6226', '180.7312', 5, 24, 283711);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (148, '-823.8499 515.9970 10.6226', '269.0492', 25, 9, 269866);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (202, '-325.9836 -1208.3505 5.6577', '89.4824', 9, 1, 98753);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (202, '-314.5307 -1311.1455 5.5426', '356.9901', 20, 8, 181943);
INSERT INTO cars (model, pos, angle, col1, col2, cost) VALUES (184, '239.0265 297.5987 5.9597', '330.6802', 5, 1, 373265);

INSERT INTO area (coordinates, name) VALUES ('-1587,1584,-1177,1584,-1177,1398,-1587,1398', 'Dirtring Stadium (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-1587,1348,-1177,1348,-1177,1145,-1587,1145', 'Hotring Stadium (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-1587,1099,-1177,1099,-1177,896,-1587,896', 'Bloodring Stadium (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-451.9017,828.5801,-490.4828,836.0632,-494.1978,881.5111,-425.5647,884.1086', 'Area Around Setinel Spawn (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-397.5122,1012.1849,-392.6848,1026.5269,-397.3311,1026.9082,-402.3017,1013.3649', 'Stairs Leading Onto Bridge Downtown - Prawn Island (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-594.8563,755.4268,-660.2327,787.1428,-664.3621,825.1868,-682.8751,825.0438,-684.5789,738.3572,-634.4702,736.7827,-590.1072,734.1246', 'Police Station (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-583.1456,836.6726,-648.6494,836.5315,-643.8153,815.649,-604.8379,815.6845,-604.134,775.9641,-593.186,757.5994,-583.1632,755.115,-583.1448,816.5273,-583.1465,837.8912', 'Area Around Police Station (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-850.0627,1199.5026,-874.1791,1197.2261,-875.5536,1107.032,-840.8956,1108.552,-851.0334,1208.9365', 'Area Around Lovefirst Car Spawn (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-654.412,1733.74,-219.153,1733.74,-219.153,1423.74,-654.412,1423.74', 'Dirt Bike Track (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-768.9937,1319.9788,-773.7689,1349.7979,-753.8771,1349.3051,-749.3801,1324.007', 'Taco Palypse (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-499.787,1331.3284,-499.3678,1250.0505,-402.3596,1250.3101,-401.3596,1339.2889', 'Black PCJ600 Spawn Area (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-791.9514,636.0704,-899.2946,635.7162,-900.0846,429.4857,-793.708,455.1772', 'Firetruck Spawn (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-1025.443,1229.1068,-1179.0916,1179.2615,-1423.4911,1132.1471,-1585.9543,1228.7365,-1591.3459,1408.911,-1540.1633,1452.153,-1399.3955,1529.4945,-1163.8846,1469.7238,-1029.5463,1430.8568', 'Stadium Area (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-632.5798,611.9456,-579.9591,612.2848,-577.107,655.6052,-633.6339,651.1842', 'Buying Area Biker Place (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-600.6072,672.4551,-590.6816,673.7256,-594.9833,678.279,-597.8158,677.9315', 'PCJ600 Spawn Biker Place (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-619.727844238281,792.264221191406,-625.92919921875,799.981201171875,-626.292053222656,808.837158203125,-620.726501464844,816.140197753906,-607.914123535156,816.393310546875,-602.563903808594,808.521362304687,-602.567687988281,800.580017089844,-607.647705078125,791.9755859375', 'Vice City Police Helipad (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-684.978576660156,1199.09521484375,-682.68798828125,1208.13391113281,-668.985717773437,1218.83569335938,-666.631652832031,1218.83483886719,-666.625305175781,1211.01000976562,-665.230712890625,1198.65625', 'Ammu Nation (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-790.82763671875,1154.49572753906,-792.163818359375,1100.69213867188,-842.736328125,1099.08801269531,-845.349426269531,1154.90319824219', 'Schuman Health Ctr. (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-650.6788,603.8848,-572.5992,604.1015,-575.0276,676.1782,-635.3757,667.0159,-649.5674,660.7907,-660.8367,651.5134,-651.4379,607.0971', 'Bikers Area (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-683.449,758.6857,-685.7684,982.0587,-807.5543,981.5125,-807.4581,832.0513,-746.6954,832.4568,-746.0534,763.4308,-686.5058,760.6365', 'Fire House (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-1083.2665,1499.7433,-1082.9712,1526.1041,-1105.2097,1526.6234,-1105.613,1500.2144', 'Helipad 1 Beside Stadium (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('-1115.6545,1526.4613,-1138.3622,1526.5447,-1138.6349,1500.2153,-1116.4065,1499.8867', 'Helipad 2 Beside Stadium (Downtown)');
INSERT INTO area (coordinates, name) VALUES ('359.9046,-796.891,387.8913,-807.188,357.2237,-871.662,330.4838,-864.6754', 'Area Around Dark Blue Infernus Spawn Beside Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('440.92,-685.6968,454.7321,-657.6618,402.0839,-636.2802,387.9514,-666.8397', 'Colon Hotel Beside Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('454.864,-656.1273,467.1085,-626.6511,416.2755,-605.463,402.1508,-633.1613', 'Moonlite Hotel Beside Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('459.2472,-463.909,455.829,-491.2232,511.9111,-497.136,512.5911,-468.0039', 'Deacon Hotel Beside Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('337.1537,-322.1985,320.7444,-345.2869,439.1076,-373.1101,445.982,-348.7138', 'Small Road Bridge Near Construction Site Two (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('450.6214,14.9851,452.115,-28.2136,486.5843,-28.2132,479.2517,14.4312', 'Parking Area For Malibu Club (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('522.3197,-28.834,520.6642,-107.405,494.4325,-114.328,439.0612,-108.7348,440.0126,-29.189', 'Malibu Club (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('124.8811,-777.9898,107.9592,-770.2627,122.3064,-738.5744,87.8733,-729.796,44.8521,-815.2505,108.6316,-802.1682', 'Hotel Building 1102 (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('186.3331,-554.3089,167.375,-555.7802,156.892,-678.4073,178.3462,-678.095', 'Small Bridge (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('231.1647,-461.4586,227.1779,-496.9728,247.8739,-500.0712,267.2246,-466.7707', 'Bunch Of Tools Extra Parking / Jump Across River (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('216.1607,-439.0706,188.2373,-438.9193,197.9619,-387.5008,234.1915,-394.6558', 'Coin Laundry Beside Construction Site One (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('342.4971,-455.8434,327.2005,-474.0278,233.2449,-460.0637,234.9951,-438.5763', 'Small Bridge Across River Beside Bunch Of Tools (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('293.5155,-508.8923,275.7126,-497.1224,286.1656,-482.0756,302.8008,-491.9198', 'Small Cement Jump Beside Police Station (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('405.1753,-579.4435,386.6554,-570.1102,375.4631,-593.2328,393.9161,-599.1105', 'Wok & Roll Shop Beside Police Station (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('374.4264,-595.496,390.7118,-605.4999,383.5956,-621.5269,366.6351,-612.1746', 'Beach Scooter Rentals Beside Police Station (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('332.1812,-941.6586,347.0714,-910.1701,285.2633,-882.7087,269.8809,-916.1434', 'Moonlite Hotel Across From Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('307.3891,-1035.3474,304.5523,-1069.7461,245.8999,-1061.7581,248.4237,-1028.2306', 'Dakota Building Across From Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('305.8718,-1089.0521,300.2988,-1120.693,234.5531,-1107.6984,237.7839,-1077.2319', 'Deacon Hotel Across From Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('289.5403,-1145.2993,294.6626,-1118.8759,230.3255,-1108.6062,226.0992,-1132.7743', 'Laurence Building Across From Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('278.541,-1197.8746,214.5926,-1186.4961,207.7772,-1216.8247,277.6531,-1227.804', 'Moonlite Hotel Across From Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('270.8568,-1254.6023,214.6895,-1244.2329,216.477,-1219.1847,274.8727,-1228.7742', 'Front Page Cafe Across From Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('258.1923,-1326.056,249.622,-1356.1771,199.6784,-1317.0898,194.0247,-1344.9242', 'Deacon Hotel Across From Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('249.1055,-1356.8163,244.9592,-1382.5818,188.2475,-1370.1694,191.8727,-1346.5636', 'Laurence Building Across From Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('228.8261,-1451.8542,214.6478,-1482.2943,186.5006,-1468.9979,178.3144,-1486.8159,147.1624,-1470.4838,149.7437,-1463.4889,145.7219,-1461.6484,161.2101,-1426.5837', 'Colon Hotel Across From Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('202.2804,-1501.4705,194.2227,-1519.9349,149.526,-1494.6858,156.548,-1476.5247', 'Parsons Building Across From Lighthouse (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('174.3816,-1508.2826,159.2719,-1533.7837,130.1716,-1517.4065,141.889,-1490.6583', 'Beach Patrol Headquarters / Vice City Crusader Spawn (Washington-Beach(');
INSERT INTO area (coordinates, name) VALUES ('177.0458,-1544.2054,169.2014,-1558.5046,123.5641,-1538.78,131.6444,-1520.1671', 'Alberta Building Across From Lighthouse (Washington-Beach)(');
INSERT INTO area (coordinates, name) VALUES ('79.0918,-1599.8431,155.4785,-1585.7863,167.3594,-1563.9048,89.0082,-1530.4329', 'Maison Wenifall Restaurant Across From Lighthouse (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('58.2864,-1646.572,57.1055,-1651.4247,-34.4768,-1651.2164,-34.0404,-1646.5505', 'Small Walking Bridge Near Lighthouse (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-67.3371,-1581.6489,-44.4604,-1620.0864,-72.1401,-1636.7446,-84.5201,-1607.8546,-88.1568,-1586.656', 'Army Helipad Near Lighthouse (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-91.3984,-1536.7655,-63.3639,-1557.9543,-59.17,-1548.0419,-57.2615,-1529.1332', 'Beautiful Fountain Near Lighthouse (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('241.8935,-751.1327,253.0049,-727.4399,280.9873,-747.6501,276.1528,-765.499', 'Basket Ball Courts Near Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('309.1864,-744.7816,322.8283,-720.3366,340.249,-728.5148,344.237,-721.2604,369.5536,-731.9979,344.466,-788.7578', 'DBP Security Store Near Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('334.3694,-694.7302,379.2365,-713.3443,387.7377,-691.4412,343.0604,-674.5614', 'Teatro De Bell Store Near Beach (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('505.4424,57.2337,510.4714,-70.3175,641.5161,-63.0406,636.3179,57.1916', 'WK Chariot Hotel Beside Malibou Club (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('333.1382,-506.1041,374.7673,-541.4982,418.5285,-489.9932,376.5854,-454.7597', 'Police Station (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('337.1877,-545.8691,355.1423,-557.9974,316.5136,-631.4604,289.2757,-613.1223', 'BasketBall Courts (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('122.7919,-817.5504,146.9704,-836.6741,102.257,-908.5887,77.7069,-884.6098', 'Hotel Harrison (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('188.6133,-528.4547,189.7641,-460.4542,209.8476,-460.0078,207.5972,-511.8277,203.841,-520.9372,199.3447,-525.7498', 'Bunch Of Tools (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('64.2974,-1024.2076,95.3971,-909.1016,-84.5305,-901.097,-60.8125,-1020.0235', 'Washington Mall (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('171.892,-427.0416,204.2182,-303.4878,64.9095,-296.3711,64.9778,-428.7802', 'Construction-Yard One (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('63.5071,-458.4257,176.2338,-461.372,167.4972,-614.7164,-14.4977,-628.2733,-14.4825,-572.8994,10.3282,-570.283,10.7308,-523.2341', 'Star View Heights Hotel Area (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('64.2974,-1024.2076,95.3971,-909.1016,-84.5305,-901.097,-60.8125,-1020.0235', 'Washington Mall (Washington-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-53.6625,-1389.3136,-67.8741,-1389.2874,-67.8736,-1408.6001,-53.6682,-1408.6099', 'Small Pink Garage Near Secret Servive (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('22.2606,-1250.5731,-16.1170,-1243.0209,-26.4359,-1193.0960,22.2697,-1194.6285', 'Secret Service Spawn (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-257.0006,-1193.415,-235.5602,-1195.1667,-182.7953,-1468.5763,-207.7172,-1476.2261', 'Cortez Yacht Car Parking Aera (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-194.5427,-1379.4824,-174.9319,-1339.6792,-145.8954,-1330.488,-112.6435,-1435.8871,-156.5706,-1449.7915,-180.6083,-1424.5187,-190.3507,-1394.465', 'Cortez Yacht Underground Parking Area (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-89.1657,-1537.7655,-61.5837,-1557.7108,-57.7801,-1530.5176', 'Beauty Fountain (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-41.2233,-1334.67,178.777,-1334.67,178.777,-1476.02,-41.2233,-1476.02', 'Pole Position Club (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('455.4411,-1702.5109,450.6863,-1745.031,493.4899,-1738.8651,514.7018,-1743.0677,596.3672,-1774.8088,598.5198,-1770.7152,577.5778,-1764.7793,602.5035,-1704.3433,600.4519,-1702.2031,574.5256,-1763.1362,516.8008,-1739.6581,524.7379,-1715.3358,486.0654,-1710.2665', 'Light House (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('232.8029,-1309.5922,246.3772,-1251.8593,205.9994,-1243.1354,193.7939,-1302.0081', 'Ocean View Hotel (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-214.4229,-1483.7434,-242.6267,-1384.1404,-260.6515,-1207.4133,-400.4097,-1229.0303,-393.4708,-1485.8624', 'Cortez Boat Yard (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-211.8664,-1385.1534,-145.9399,-1330.5247,-112.6259,-1435.9342,-156.54,-1449.7837', 'Cortez Yacht Parking (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('80.3361,-1264.5144,164.6879,-1274.0306,177.8907,-1134.6465,88.7803,-1130.1882,82.7522,-1225.0828', 'Stacked Car Parking - Rafals Shop (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-116.4259,-913.3162,-205.4549,-944.1403,-191.3129,-1014.9779,-96.9999,-1002.1799', 'Hospital (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-16.4657,-1244.5519,-13.4028,-1261.578,-13.6834,-1279.0837,17.3076,-1278.4814,17.2601,-1251.5568,9.9797,-1244.3607', 'Pay N Spray (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-60.2894,-1471.0267,-60.9949,-1479.4674,-61.6591,-1487.3621,-67.2522,-1487.1404,-66.7247,-1470.4744', 'Ammu Nation (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('71.586,-1091.5327,67.0517,-1044.017,21.0852,-1042.3206,21.0418,-1091.8297', 'Gass Station/Flamethrower Spawn (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('-376.2044,-1293.6364,-374.1573,-1294.6268,-379.7368,-1340.739,-371.0141,-1340.7609', 'Cortez Yacht (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('156.1658,-1306.1178,79.3192,-1294.7825,76.1016,-1319.2537,144.9296,-1360.3883', 'Underground Shopping Mall (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('213.7047,-1040.6218,220.669,-1003.7727,201.2388,-1000.5707,172.1419,-1037.4166', 'Pizza Boy Car Spawn (Ocean-Beach)');
INSERT INTO area (coordinates, name) VALUES ('450.6214,14.9851,452.115,-28.2136,486.5843,-28.2132,479.2517,14.4312', 'Parking Area For Malibu Club (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('522.3197,-28.834,520.6642,-107.405,494.4325,-114.328,439.0612,-108.7348,440.0126,-29.189', 'Malibu Club (Vice-point)');
INSERT INTO area (coordinates, name) VALUES ('513.0738,261.6372,598.7347,257.8233,590.6527,145.991,517.7328,136.8029,516.6989,192.8352', 'Blue Huge Hotel With Driveway Near Malibu Club (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('513.0738,261.6372,598.7347,257.8233,590.6527,145.991,517.7328,136.8029,516.6989,192.8352', 'Blue Huge Hotel With Driveway Near Malibu Club (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('412.3763,56.6718,348.0938,8.3808,356.3558,-11.2885,436.5563,49.7432', 'Small Road Bridge Beside Pizza Store (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('323.1109,-5.2952,246.7584,64.0305,229.5725,1.5033,310.3412,-16.4974', '180 Degree Turn Road (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('218.623,-264.4899,193.1373,-251.2516,263.4119,-111.5594,289.6043,-124.1891', 'Housing District Beside Construction Site Two (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('330.5463,419.4052,343.4759,450.663,300.7213,463.9426,292.3504,431.3354,310.8426,425.1751', 'Pay N Spray (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('559.3926,912.9513,536.017,905.0338,539.241,793.7173,570.6879,802.0178,578.9595,847.3611,574.3212,880.8946', 'Area Around Red Banshee Spawn (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('522.7069,492.7892,524.0906,535.2592,481.7054,535.2623,477.3874,491.1699', 'Police Station (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('516.1329,121.0798,509.8855,70.1216,0,0,539.1446,68.5635,541.6635,115.1753', 'Red Cheetah Spawn (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('495.289,-153.4902,535.7683,-155.9827,550.6797,-199.6786,493.7585,-202.3785', 'Standing Vice Point Hotel (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('471.7570,1017.0751,458.2155,1003.5368,370.1470,1002.6589,356.3382,1016.3775,371.2130,1246.3410,374.2413,1250.0294,457.9543,1249.4902,471.4790,1235.9415', 'North Point Mall (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('434.2993,677.235,523.7397,671.2512,531.9296,745.3498,435.7225,748.4537', 'Sady Palms Hospital (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('214.4642,-328.6735,281.1449,-186.1564,334.8362,-202.4614,368.1498,-236.4027,359.0295,-291.6718,315.8583,-332.503,287.8112,-349.814,263.5205,-369.0602', 'Construction Site Two (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('423.5929,62.0526,400.8638,89.0531,428.7664,104.7536,444.7311,80.7069,425.7751,62.7214', 'Pizza Place (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('405.5945,92.1781,401.7268,102.5163,411.473,109.4158,418.4683,99.9599', 'Health Pickup (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('390.3769,200.2565,391.3776,214.0185,378.2139,202.771,379.3221,213.1466', 'Ruger Pickup (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('299.7928,1154.0883,362.2287,1152.9879,341.3615,1258.0833,303.0916,1258.0934', 'Car Parking Area (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('344.4002,245.675,427.0659,241.4789,419.9709,358.1649,457.1349,478.8882,359.3364,479.1918,336.2394,390.8638,339.814,319.0356', 'Yellow Heli Spawn (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('333.688,246.8804,328.6036,324.1894,265.1896,322.5232,246.7516,255.3121', 'VCC Spawn (Vice-Point)');
INSERT INTO area (coordinates, name) VALUES ('-647.6288,-1504.8722,-631.5891,-1466.8511,-565.4047,-1502.5222,-573.5011,-1524.5475', 'Boat Release Station (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-644.0002,-1494.0481,-637.4573,-1477.3562,-670.5477,-1464.3423,-677.1063,-1481.0734', 'Small Boat Shed Beside Sailer Spawn Boat (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-832.734,-1059.6438,-854.6108,-1064.8462,-831.257,-1152.2152,-803.568,-1227.7271,-775.9134,-1235.2601,-810.884,-1138.783', 'Housing District Main Road Docks (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-1008.9643,-917.2385,-966.5752,-873.5986,-960.9246,-835.8257,-961.1011,-821.8583,-1029.4701,-822.4916,-1066.3895,-854.1155,-1097.1145,-808.3926,-1112.0549,-756.8048,-1118.2751,-734.1804,-959.7504,-700.5398,-955.0647,-724.0969,-913.2933,-724.938,-906.1473,-957.2255,-916.5533,-976.9691,-953.7868,-971.9531,-981.4425,-946.1937', 'Grassy Area Around Sunshine Autos (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-1004.5689,-1107.6908,-946.9093,-1144.1576,-954.0686,-1201.0712,-971.3568,-1198.3191,-1005.1143,-1191.1534,-1022.7979,-1161.8447,-1024.2433,-1106.3809', 'Hookers Inn Express (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-825.135,-917.2343,-824.5293,-895.7325,-864.5542,-895.8608,-862.8407,-916.8691', 'Black Cheetah Spawn (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-920.3341,-1266.8041,-881.7815,-1282.3055,-868.7863,-1246.3971,-905.2404,-1228.0675', 'Pay N Spray Docks (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-678.3725,-1225.5154,-698.2852,-1234.9144,-700.277,-1230.3483,-684.118,-1222.5894', 'Sailer Spawning Point (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-677.7271,-1242.9503,-687.6968,-1247.5239,-682.3592,-1257.4573,-674.1226,-1253.2505', 'Sailer Spawning Point (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-617.9482,-1401.9229,-620.8803,-1396.3447,-606.2032,-1388.5695,-605.244,-1395.1261', 'Sailer Spawning Point (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-1036.6324,-1053.3798,-1109.3129,-1049.1597,-1099.0468,-980.1897,-1035.3795,-973.9448', 'M4 Pickup (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-686.2939,-1209.2788,-708.7833,-1219.9446,-683.2922,-1284.1927,-641.1564,-1372.9376,-621.0158,-1404.4058,-605.791,-1411.5576,-600.9346,-1397.8861,-604.2241,-1380.1818,-639.6022,-1299.8643,-673.7968,-1228.9258,-683.9929,-1212.8311', 'Sailer Spawn Ship (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-936.9757,-1262.4503,-948.423,-1285.311,-960.2105,-1278.7228,-992.1687,-1261.1316,-984.8417,-1243.3428,-937.8336,-1263.045', 'Yellow Cabbie Spawn Docks (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-724.2263,-1309.0135,-748.5587,-1317.9487,-771.0283,-1376.731,-734.7452,-1392.5747,-764.4313,-1480.2317,-709.8036,-1474.8271,-710.0189,-1452.1436,-697.3012,-1406.0763,-700.8736,-1366.4902,-709.4474,-1340.9006', 'Cargo Loading Area for Sailer Ship (Vice-Port)');
INSERT INTO area (coordinates, name) VALUES ('-991.4707,333.1019,-999.0686,293.3873,-1055.8782,315.8025,-1055.6002,323.0032', 'Area Outside Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1054.83,314.2538,-1041.7476,314.248,-1043.9777,258.1243,-1053.8828,256.2113,-1063.886,225.2654,-1066.0839,182.099,-1048.9425,182.0895,-1048.4059,167.8579,-1059.9669,159.1646,-1076.6554,143.0625,-1082.9962,157.4325,-1083.0541,186.618,-1118.7931,206.2183,-1119.0162,277.5042,-1055.986,277.2324', 'Aera Outside Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-938.9802,305.0141,-935.2508,304.6534,-935.3102,258.6583,-975.9441,259.4335,-975.1604,281.0945,-1002.696,281.5405,-1000.2476,285.5887,-976.6155,285.5205,-976.29,312.4757,-971.3557,311.9922,-971.3481,283.7337,-939.518,283.3864,-938.9789,293.9504', 'Area Around Ruger Spawn Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-967.7964,337.9391,-972.7015,337.4834,-972.632,369.3446,-998.5391,369.6781,-1123.4623,391.9472,-1125.9083,388.0729,-1139.4497,271.6426,-1160.7653,261.8107,-1160.2422,429.4145,-1019.5082,430.6732,-868.964,412.6998,-793.149,411.0058,-792.741,351.2239,-967.8176,365.4393,-967.797,336.1592', 'Area Around Phils Place by Firetruck Spawn (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-839.9809,215.8471,-818.9916,273.945,-903.3455,276.4254,-903.4894,258.0352,-917.0936,257.9554,-916.4925,225.2865,-912.0892,182.3365,-886.0245,204.3724,-859.8209,213.8924', 'Shooping Center by Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-931.4026,159.0306,-1019.6963,169.5781,-1020.4141,66.4542,-937.9188,70.9685', 'Housing District (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-907.1825,65.7139,-908.4963,38.9463,-928.9723,37.8217,-927.0081,72.6143', 'Cafe Under Tree (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1111.6312,125.9862,-1128.2257,125.3589,-1130.6211,76.0022,-1160.6526,109.2536,-1198.9821,106.8263,-1179.8398,64.6455,-1144.5007,60.2746,-1141.6866,49.2825,-1113.0782,48.8725', 'Health Pickup Area (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1137.24,-160.199,-1041.76,-160.199,-1041.76,-315.199,-1137.24,-315.199', 'PrintWorks (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1015.36,221.755,-994.035,221.755,-994.035,178.913,-1015.36,178.913', 'KaufmanCabs (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1064.8909,94.2495,-1063.8125,68.7717,-1028.5621,67.8754,-1024.6682,93.549,-1052.2114,93.9598', 'Pizza Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1079.7188,-1.49,-1081.0978,15.8398,-1235.2623,19.999,-1236.8638,-0.2195', 'Road Leading to Junk Yard (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1046.6707,-110.8811,-1049.5413,-149.3609,-1084.9857,-149.7504,-1087.7126,-112.0076', 'Cuban Hermes Spawn (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-925.9913,-262.1354,-924.496,13.8386,-945.7303,19.4718,-944.673,-256.473', 'Below Ground Sewage Way (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1101.8967,335.7943,-1102.3623,356.8334,-1108.3605,355.9335,-1108.1698,336.9001', 'Trailer Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1066.621,337.6861,-1057.0677,345.7705,-1068.6418,358.8579,-1077.9401,351.638', 'Caravan Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1096.9249,283.0223,-1096.9252,304.4266,-1114.0507,304.4269,-1114.0673,283.0226', 'Dome Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-993.383,219.317,-979.853,219.317,-979.853,176.475,-993.383,176.475', 'KaufmanCabs (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1077.59375,295.816009521484,-1057.41333007812,297.662292480469,-1057.0498046875,279.188659667969,-1076.19323730469,279.211975097656', 'Hill Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-723.57666015625,299.92822265625,-810.72509765625,314.618316650391,-1009.78833007813,335.291046142578,-1016.81787109375,304.672241210937,-1032.96923828125,183.878829956055,-1016.95324707031,181.365692138672,-999.470764160156,296.262268066406,-979.977294921875,315.892028808594,-922.811950683594,311.232055664063,-725.538024902344,283.878601074219', 'Road Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-841.8082,-73.8994,-847.7575,-70.4319,-851.903,-83.499,-871.741,-84.4731,-869.1878,-77.7782,-855.5796,-76.9528', 'Ryton Aide Drugstore (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1186.1238,-326.9627,-1185.568,-339.0182,-1200.2823,-340.9182,-1201.7178,-327.8275,-1200.7808,-325.4633,-1191.641,-325.0282,-1192.2845,-316.487,-1200.4867,-317.0095', 'Laundromat (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1200.8214,-325.6491,-1194.7758,-325.2229,-1194.9116,-323.1852,-1199.0327,-323.5153,-1199.215,-321.3241,-1194.1259,-320.9656,-1193.2155,-325.0409,-1191.6069,-324.7371,-1192.3031,-316.328,-1200.132,-317.4077,-1199.9427,-320.6284,-1201.2208,-320.7606,-1200.8311,-325.6694', 'Laundromat (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1057.0689,364.3032,-1111.9138,364.2789,-1117.3443,339.7314,-1119.0133,278.7386,-1057.0828,278.7540', 'Phils Place (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-729.5686,283.9952,-746.2684,287.1281,-757.7845,226.1475,-741.9272,222.9795', 'Side Restaurant (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1236.8723,-0.2193,-1270.4204,214.0202,-1347.6625,215.0356,-1348.2399,-22.9072,-1252.5621,-23.372,-1252.6128,-34.6882,-1235.9824,-36.9537', 'Junk Yard (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1200.9312,-342.8575,-1183.4697,-341.7539,-1192.3423,-315.865,-1200.5367,-316.4722', 'Yellow Taxi Spawn/Laundromat Area (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-771.9005,151.1758,-779.2637,114.8242,-748.4176,104.892,-738.1591,143.81', 'Area Around Red Deluxo Spawn (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-974.0101,276.0978,-974.8904,258.7387,-993.1724,261.3909,-993.1728,271.6129', 'Ruger Spawn Two (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1133.6903,-436.6544,-1137.7396,-372.7125,-1172.7383,-380.1118,-1166.3379,-438.6505', 'BasketBall Courts (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1053.199,-507.2093,-1081.8041,-509.2462,-1090.8088,-446.4148,-1059.5815,-442.3879,-1041.7357,-446.9765,-1039.3623,-467.3176,-1036.4189,-492.5969', 'Yellow Cheetah Spawn (Little-Haiti)');
INSERT INTO area (coordinates, name) VALUES ('-1008.9643,-917.2385,-966.5752,-873.5986,-960.9246,-835.8257,-961.1011,-821.8583,-1029.4701,-822.4916,-1066.3895,-854.1155,-1097.1145,-808.3926,-1112.0549,-756.8048,-1118.2751,-734.1804,-959.7504,-700.5398,-955.0647,-724.0969,-913.2933,-724.938,-906.1473,-957.2255,-916.5533,-976.9691,-953.7868,-971.9531,-981.4425,-946.1937', 'Grassy Area Around Sunshine Autos (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-1060.54,-807.183,-959.702,-807.183,-959.702,-910.663,-1060.54,-910.663', 'Sunshine Autos (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-897.1614,-506.356,-898.0833,-497.9585,-864.4841,-496.3242,-863.2308,-501.8993', 'Garbage Pickup Section Beside CherryPoppers (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-862.6701,-616.2474,-847.1415,-614.3268,-850.0104,-590.5741,-866.5541,-591.6268', 'CherryPoppers (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-874.1055,-548.2546,-876.9171,-529.4781,-859.0605,-527.9099,-855.9775,-546.7849', 'CherryPoppers (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-862.7377,-502.3448,-823.0785,-495.9717,-806.9888,-634.1754,-844.7306,-635.8149', 'Area Around CherryPoppers (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-850.5679,-719.9435,-850.2272,-721.3881,-911.2723,-734.2519,-910.5636,-724.7701,-905.9016,-721.1253,-913.4297,-668.1896,-908.6583,-668.3925,-901.8369,-683.7497,-899.3538,-707.4439,-897.4043,-724.0385,-876.591,-720.7498,-860.0612,-720.2832', 'Area Around Police Station (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-898.2357,-326.6091,-898.2196,-355.5072,-936.2309,-355.5205,-939.2854,-352.5587,-952.3001,-342.9138,-957.1079,-341.7898,-966.5380,-337.4671,-966.5401,-328.1766', 'National Bank (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-910.914,-569.893,-850.889,-569.893,-850.889,-596.38,-910.914,-596.38', 'CherryPoppers (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-910.914,-542.906,-850.89,-542.906,-850.89,-569.893,-910.914,-569.893', 'CherryPoppers (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-967.3869,-689.1602,-977.9895,-691.0415,-978.1649,-694.1641,-978.7061,-694.6658,-978.1403,-699.0204,-970.2646,-698.8192,-970.4897,-696.3087,-966.4525,-695.7281,-967.0875,-691.1678', 'Screw This (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-962.4418,-688.561,-961.5729,-695.0952,-964.0651,-695.4263,-964.9273,-688.8788', 'Screw This (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-842.664,-660.6801,-909.0327,-667.666,-900.1709,-723.9713,-836.184,-718.9229', 'Police Station (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-847.5513,-628.7977,-867.4392,-632.4258,-866.5768,-641.1979,-847.3098,-637.5702', 'Donut/Pizza Shop (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-813.1002,-384.9881,-810.0901,-296.8218,-894.6188,-313.8004,-896.8167,-366.537', 'Area Outside National Bank (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-975.1024,-519.7615,-940.3168,-643.9217,-888.1301,-633.4927,-899.4804,-497.9624,-923.422,-497.088,-922.5029,-506.9992,-974.83,-511.7128', 'Area Behind Cherry Poppers (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-1068.8071,-591.3305,-1182.0812,-606.811,-1172.0538,-682.2828,-983.9171,-660.556,-1000.4601,-581.1575', 'Robinas Shop (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-959.8174,-483.5575,-913.6276,-479.0725,-913.9624,-446.5628,-963.7931,-450.7936', 'BasketBall Courts (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-862.827,-502.0304,-870.7293,-449.7295,-888.3062,-449.7178,-889.3196,-505.3277', 'Health Pickup (Little-Havana)');
INSERT INTO area (coordinates, name) VALUES ('-1342.5576,-1207.2682,-1402.2252,-1252.75,-1377.3473,-1290.5756,-1337.1329,-1264.0018,-1338.4445,-1238.5005', 'Airport Helipad (Escobar-International)');
INSERT INTO area (coordinates, name) VALUES ('-1798.05,-41.9074,-1555.85,-41.9074,-1555.85,-315.199,-1798.05,-315.199', 'Military Base (Escobar-International)');
INSERT INTO area (coordinates, name) VALUES ('-1188.1552,-912.0436,-1129.476,-912.0403,-1129.4817,-1060.5421,-1184.2206,-1060.5045', 'Car Parking Area Beside Airport (Escobar-International)');
INSERT INTO area (coordinates, name) VALUES ('-1752.4955,-701.8268,-1751.308,-1750.4696,-1619.0697,-1551.9966,-1297.6647,-1362.8918,-1144.2311,-1089.6715,-1208.4805,-1067.1582,-1221.1451,-793.1848', 'Airport (Escobar-International)');
INSERT INTO area (coordinates, name) VALUES ('-1755.1526,-702.5351,-1843.8418,-703.6538,-1831.9585,-1551.6007,-1756.7728,-1550.0182', 'Hangars (Escobar-International)');
INSERT INTO area (coordinates, name) VALUES ('-1278.8226,-676.3752,-1278.826,-579.5288,-1365.5378,-580.944,-1370.525,-352.6061,-1816.2512,-352.6044,-1810.1021,-542.6508,-1534.6627,-547.2875,-1451.377,-676.9526', 'Airport (Escobar-International)');
INSERT INTO area (coordinates, name) VALUES ('-136.403,1045.75,15.6971,1045.75,15.6971,852.042,-136.403,852.042', 'Film Studio (Prawn-Island)');
INSERT INTO area (coordinates, name) VALUES ('95.583,996.9854,46.4554,1014.8056,13.6007,880.0429,84.7067,869.3102,100.5836,927.7742', 'Elbee Chemists Shop (Prawn-Island)');
INSERT INTO area (coordinates, name) VALUES ('-10.2912,875.1967,9.5785,932.2734,22.8987,1014.5231,-17.7484,1030.4106,-59.1213,1042.3671,-95.7268,1052.8481,-89.2321,1077.4084,-33.8783,1066.2427,-22.4946,1089.3077,-4.4168,1117.7073,21.5645,1120.1747,38.4031,1097.4032,42.9255,1064.1887,58.7043,1035.1705,97.9003,1022.4076,99.5832,994.5299,51.3076,1011.4117,34.3377,934.4883,17.2948,883.496', 'Main Road (Prawn-Island)');
INSERT INTO area (coordinates, name) VALUES ('7.425,1102.8629,-2.6329,1079.3815,17.8895,1075.5985,14.951,1098.1815', 'Lucky Foutain (Prawn-Island)');
INSERT INTO area (coordinates, name) VALUES ('-520.8297,-502.6416,-514.5343,-616.7653,-504.2596,-648.9782,-255.7255,-648.3829,-182.1489,-488.8681,-258.7625,-495.7844,-372.3146,-499.1833', 'Main Mansion (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-715.9235,-504.4514,-717.0683,-475.0973,-173.525,-485.6058,-180.5974,-457.652', 'Main Road (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-599.555,-505.0725,-591.8286,-594.4888,-522.1288,-597.2878,-523.53,-503.9149', 'Villa Nr.2 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-236.1725,-462.2901,-181.2307,-456.2326,-172.96,-400.5808,-196.8472,-336.6278,-256.1438,-376.0869', 'Villa Nr.3 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-251.434,-367.9546,-292.2292,-349.5457,-281.3354,-319.2784,-291.536,-312.411,-276.6152,-257.4873,-213.9532,-303.5756,-198.8506,-333.4511,-243.8141,-353.8636,-249.206,-367.2612', 'Villa Nr.4 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-328.8383,-338.7974,-305.398,-248.1836,-431.7703,-249.1344,-427.8567,-337.2119', 'Villa Nr.6 (Startfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-429.0992,-337.2502,-433.2701,-249.2589,-562.5168,-249.2316,-594.155,-252.6655,-566.2184,-347.9865,-546.4951,-342.5559', 'Villa Nr.7 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-567.616,-348.3629,-593.6408,-259.2834,-628.3345,-272.6596,-682.2181,-315.7907,-691.7678,-333.0035,-632.6378,-380.291,-596.7398,-358.9901', 'Villa Nr.8 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-659.1144,-472.4716,-715.7906,-474.4318,-718.439,-421.8889,-709.67,-366.9448,-693.3792,-334.4478,-632.7377,-383.1093,-655.5533,-424.5984', 'Villa Nr.9 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-624.9507,-471.7346,-622.0407,-426.5081,-613.073,-410.3452,-601.7545,-399.2296,-533.8243,-377.1876,-533.7856,-377.6539,-531.2195,-451.3683,-541.928,-451.3438,-541.536,-471.0047', 'Villa Nr.10 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-537.323,-468.6138,-538.8214,-453.9536,-528.5348,-453.5128,-531.2595,-377.8126,-462.057,-374.3198,-462.9836,-468.4144', 'Villa Nr.11 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-431.7807,-469.3011,-265.201,-464.2153,-267.8791,-431.7049,-269.8784,-423.4913,-282.7184,-401.4884,-300.0973,-387.1407,-336.8856,-372.0714,-430.4277,-371.9915', 'Villa Nr.12 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-602.0842,-503.6769,-685.4796,-504.804,-685.0454,-527.9478,-681.7609,-545.1856,-672.6256,-561.5737,-660.7617,-572.9917,-594.4346,-595.7178,-591.9667,-520.9426,-601.9363,-520.9158', 'Villa Nr.1 (Starfish-Island)');
INSERT INTO area (coordinates, name) VALUES ('-213.73,1243.47,163.656,1243.47,163.656,797.605,-213.73,797.605', 'Prawn-Island');
INSERT INTO area (coordinates, name) VALUES ('-1396.76,230.39,-1208.21,230.39,-1208.21,-42.9113,-1396.76,-42.9113', 'Junk-Yard');
INSERT INTO area (coordinates, name) VALUES ('-213.73,797.605,163.656,797.605,163.656,-241.429,-213.73,-241.429', 'Leaf Links');
INSERT INTO area (coordinates, name) VALUES ('-748.206,-241.467,-104.505,-241.467,-104.505,-818.266,-748.206,-818.266', 'Starfish-Island');
INSERT INTO area (coordinates, name) VALUES ('-1613.03,1677.32,-213.73,1677.32,-213.73,413.128,-1613.03,413.128', 'Downtown ');
INSERT INTO area (coordinates, name) VALUES ('163.656,1398.85,1246.03,1398.85,1246.03,-351.153,163.656,-351.153', 'Vice-Point');
INSERT INTO area (coordinates, name) VALUES ('-103.97,-351.153,1246.03,-351.153,1246.03,-930.526,-103.97,-930.526', 'Washington-Beach');
INSERT INTO area (coordinates, name) VALUES ('-253.206,-930.526,1254.9,-930.526,1254.9,-1805.37,-253.206,-1805.37', 'Ocean-Beach');
INSERT INTO area (coordinates, name) VALUES ('-1208.21,-898.738,-253.206,-898.738,-253.206,-1779.61,-1208.21,-1779.61', 'Vice-Port');
INSERT INTO area (coordinates, name) VALUES ('-1208.21,-241.467,-748.206,-241.467,-748.206,-898.738,-1208.21,-898.738', 'Little-Havana');
INSERT INTO area (coordinates, name) VALUES ('-1208.21,412.66,-578.289,412.66,-578.289,-241.467,-1208.21,-241.467', 'Little-Haiti');
INSERT INTO area (coordinates, name) VALUES ('-1888.21,230.39,-1208.21,230.39,-1208.21,-1779.61,-1888.21,-1779.61', 'Escobar-International');