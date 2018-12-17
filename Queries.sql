=============Database=====================

DROP DATABASE IF EXISTS payroll;
CREATE DATABASE payroll;
USE payroll;

CREATE TABLE category(
	catid int(10) auto_increment,
	description varchar(20),
	avg_basic DECIMAL(10,2),
	no_pay_amount DECIMAL(10,2),
	OT_average DECIMAL(10,2),
	late_per_hour DECIMAL(10,2),
	annual_leaves INT(10),
	casual_leaves INT(10),
	constraint primary key(catid)
);

CREATE TABLE employee(
	empid int (10) auto_increment,
	catid int(10), 
	name varchar (20),
	tel int(10),
	address varchar(100),
	basic_salary decimal(10,2),
	dob date,
	nic VARCHAR(20),
	gender VARCHAR(10),
	constraint primary key(empid),
	constraint foreign key(catid) references category(catid)
	on update cascade on delete cascade
);

CREATE TABLE leave_types(
	ltid INT(10) AUTO_INCREMENT,
	type VARCHAR(10),
	CONSTRAINT PRIMARY KEY(ltid)
);

CREATE TABLE allowances(
	alowid int(10) auto_increment,
	description varchar(20),
	constraint primary key(alowid)
);

CREATE TABLE cat_alowance(
	cat_alow_id int(10) auto_increment,
	alowid int(10),
	catid int(10),
	amount decimal(10,2),
	constraint primary key(cat_alow_id),
	constraint foreign key(alowid) references allowances(alowid)
	on update cascade on delete cascade,
	constraint foreign key(catid) references category(catid)
	on update cascade on delete cascade
);

CREATE TABLE attendance(
	aid int(10) auto_increment,
	empid int(10),
	date date,
	in_time time,
	out_time time,
	ot_amount decimal(10,2),
	late_amount decimal(10,2),
	constraint primary key(aid),
	constraint foreign key(empid) references employee(empid)
	on update cascade on delete cascade
);

CREATE TABLE leaves(
	lid int(10) auto_increment,
	empid int(10),
	ltid INT(10),
	date date,
	constraint primary key(lid),
	constraint foreign key(empid) references employee(empid)
	on update cascade on delete cascade,
	constraint foreign key(ltid) references leave_types(ltid)
	on update cascade on delete cascade
);

CREATE TABLE rates(
	rate_id int(10) auto_increment,
	description varchar(20),
	precentage int(10),
	constraint primary key(rate_id)
);

CREATE TABLE gov_tax(
	tax_id int(10) auto_increment,
	sRange DECIMAL (10,2),
	eRange DECIMAL (10,2),
	amount decimal(10,2),
	constraint primary key(tax_id)
);

CREATE TABLE payslip(
	psid int(10) auto_increment,
	empid int(10),
	tax_id INT(10),
	date date,
	basic decimal(10,2),
	allowance decimal(10,2),
	ot decimal(10,2),
	gross_pay decimal(10,2),
	tax DECIMAL(10,2),
	etf decimal(10,2),
	epf decimal(10,2),
	lates decimal (10,2),
	no_pay decimal(10,2),
	net_pay decimal(10,2),
	constraint primary key(psid),
	constraint foreign key(empid) references employee(empid)
	on update cascade on delete cascade,
	constraint foreign key(tax_id) references gov_tax(tax_id)
	on update cascade on delete cascade
);



CREATE TABLE before_employee_update(
	empid int (10) auto_increment,
	catid int(10), 
	name varchar (20),
	tel int(10),
	address varchar(100),
	basic_salary decimal(10,2),
	dob date,
	nic VARCHAR(20),
	gender VARCHAR(10),
	constraint primary key(empid),
	constraint foreign key(catid) references category(catid)
	on update cascade on delete cascade
);

CREATE TABLE epf_sum(
	esid INT(10) auto_increment,
	empid INT(10),
	tot_epf DECIMAL(10,2),
	CONSTRAINT PRIMARY KEY(esid),
	CONSTRAINT FOREIGN KEY(empid) REFERENCES employee(empid)
	ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO category (description,avg_basic,no_pay_amount,OT_average,late_per_hour,annual_leaves, casual_leaves) VALUES ('Manager','95000','5000','4000','2000','50','10');
INSERT INTO category (description,avg_basic,no_pay_amount,OT_average,late_per_hour,annual_leaves,casual_leaves) VALUES ('Supervisor','45000','2000','2000','1000','30','5');
INSERT INTO category (description,avg_basic,no_pay_amount,OT_average,late_per_hour,annual_leaves, casual_leaves) VALUES ('Engineer','75000','3000','4000','1500','40','10');
INSERT INTO category (description,avg_basic,no_pay_amount,OT_average,late_per_hour,annual_leaves,casual_leaves) VALUES ('Accountant','65000','2500','4000','1000','35','10');

INSERT INTO employee (name,catid,tel,address,basic_salary,dob, nic,gender) values ('Tharindu','03','0774935895','Bentota','95000','1997/05/17','971383127v','Male');
INSERT INTO employee (name,catid,tel,address,basic_salary,dob, nic,gender) values ('Ridma','01','0714955594','Horana','55000','1997/10/17','971382137v','Male');
INSERT INTO employee (name,catid,tel,address,basic_salary,dob, nic,gender) values ('Ashan','02','071935851','Alutgama','45000','1997/01/27','971384166v','Male');
INSERT INTO employee (name,catid,tel,address,basic_salary,dob, nic,gender) values ('Hashan','04','0774945895','Horana','95000','1997/02/17','981333147v','Male');

INSERT INTO allowances (description) VALUES('Food');
INSERT INTO allowances (description) VALUES('Transport');
INSERT INTO allowances (description) VALUES('Accomodation');

INSERT INTO cat_alowance(alowid,catid,amount) VALUES('01','01','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('01','02','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('01','03','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('01','04','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('02','01','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('02','02','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('02','03','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('02','04','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('03','01','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('03','02','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('03','03','2000');
INSERT INTO cat_alowance(alowid,catid,amount) VALUES('03','04','2000');

INSERT INTO leave_types (type) VALUES('Annual');
INSERT INTO leave_types (type) VALUES('Casual');
INSERT INTO leave_types (type) VALUES('NoPay');

INSERT INTO rates (description,precentage) VALUES('EPF','14');
INSERT INTO rates (description,precentage) VALUES('ETF','3');

INSERT INTO gov_tax (sRange, eRange ,amount) VALUES('0','10000','0');
INSERT INTO gov_tax (sRange, eRange ,amount) VALUES('100000','200000','5');
INSERT INTO gov_tax (sRange, eRange ,amount) VALUES('200000','300000','10');
INSERT INTO gov_tax (sRange, eRange ,amount) VALUES('300000','400000','15');
INSERT INTO gov_tax (sRange, eRange ,amount) VALUES('400000','500000','20');
INSERT INTO gov_tax (sRange, eRange ,amount) VALUES('500000','9000000','30');


INSERT INTO attendance (empid,date,in_time,out_time,ot_amount,late_amount) VALUES
('01',CURRENT_DATE(),08.00,17.00,'0.00','0.00');

INSERT INTO leaves (empid,date,ltid) VALUES('03',CURRENT_DATE(),'01');

INSERT INTO payslip(empid,basic,allowance,ot,gross_pay,etf,lates,no_pay,net_pay) VALUES('01','95000','2000','1000','98000','2000','2000','4000','90000');





==========================No Use=========================
/////////////////////////////////////////////
SELECT TIMESTAMPDIFF(HOUR,'2018-09-08 08:30:00',in_time) AS late FROM attendance WHERE aid='04';
=======================End of No Use=====================






=========================================BUSINESS LOGICS===========================================
============================================



================Sub Functions====================


DROP FUNCTION IF EXISTS return_catId;
DELIMITER $$
CREATE FUNCTION return_catId(category VARCHAR(20))RETURNS INT
BEGIN
	DECLARE cid INT(10);
	SELECT catid FROM category WHERE description=category INTO cid;
	RETURN cid;
END$$
DELIMITER ;


DROP FUNCTION IF EXISTS return_attendanceId;
DELIMITER $$
CREATE FUNCTION return_attendanceId(eid INT(10),d DATE)RETURNS INT
BEGIN
	DECLARE a INT(10);
	SELECT aid FROM attendance WHERE empid=eid AND date=d INTO a;
	RETURN a;
END$$
DELIMITER ;

SELECT return_attendanceId('01',CURRENT_DATE());

===============================================

DROP PROCEDURE IF EXISTS get_leave_id;
DELIMITER &&;
CREATE PROCEDURE get_leave_id(
	IN emid INT(10),
	OUT l INT(10)
)
BEGIN
	SELECT lid FROM leaves WHERE empid=emid AND date=CURRENT_DATE() INTO l;
	SELECT l;
END&&;
DELIMITER ;





====================CRUD Operations Using FUNCTIONS========================

DROP FUNCTION IF EXISTS add_category;
DELIMITER $$ 
CREATE FUNCTION add_category(
	name VARCHAR (10),
	basic decimal(10,2),
	nopay decimal(10,2),
	ot decimal(10,2),
	late decimal(10,2),
	a_leaves INT(10),
	c_leaves INT(10)
) RETURNS INT 
BEGIN 
	 DECLARE r int (10);
	 INSERT INTO category (description,avg_basic,no_pay_amount,OT_average,late_per_hour,annual_leaves, casual_leaves) VALUES (name,basic,nopay,ot,late,a_leaves,c_leaves);
	 SET r= ROW_COUNT();
	 return r;
END$$ 
DELIMITER ;

SELECT add_category('Assistant','40000','1000','1000','1000','30','10');

=============================================

DROP FUNCTION IF EXISTS add_cat_allow;
DELIMITER $$
CREATE FUNCTION add_cat_allow(
allowance VARCHAR(20),
category VARCHAR(10),
amnt decimal(10,2)
)RETURNS INT
BEGIN
	DECLARE alwid int(10);
	DECLARE cid int(10);
	DECLARE r int(10);
	SELECT alowid FROM allowances WHERE description=allowance INTO alwid;
	SET cid=return_catId(category);
	INSERT INTO cat_alowance(alowid,catid,amount) VALUES(alwid, cid, amnt);
	SET r=ROW_COUNT();
	RETURN r;
END$$
DELIMITER ;

SELECT add_cat_allow('Food','Assistant','1500');

============================================

DROP FUNCTION IF EXISTS add_employee;
DELIMITER $$
CREATE FUNCTION add_employee(
	name VARCHAR(20),
	category VARCHAR(20),
	tel INT(10),
	address VARCHAR(20),
	basic DECIMAL(10,2),
	bd DATE,
	idc VARCHAR(20),
	mf VARCHAR(10)
)RETURNS int
BEGIN
	DECLARE cid int(10);
	DECLARE r int(10);
	SET cid=return_catId(category);
	INSERT INTO employee (name,catid,tel,address,basic_salary,dob,nic,gender) values (name,cid,tel,address,basic,bd,idc,mf);
	SET r=ROW_COUNT();
	RETURN r;                             
END$$
DELIMITER ;

SELECT add_employee('Pasindu','Supervisor','0711922486','Bentota','55000','1996/02/10','9762345098v','Male');

============================================

DROP FUNCTION IF EXISTS add_attendance_in;
DELIMITER $$
CREATE FUNCTION add_attendance_in(
	emid VARCHAR(20)
)RETURNS INT
BEGIN
	DECLARE r INT(10);
	DECLARE a int(10);
	DECLARE l INT(10);
	SET a=return_attendanceId(emid,CURRENT_DATE());
	SELECT lid FROM leaves WHERE empid=emid AND date=CURRENT_DATE() INTO a;
	IF(a>0 OR l>0 OR CURRENT_TIME()>'12:00:00') THEN
		RETURN 0;
	ELSE
		INSERT INTO attendance (empid,date,in_time) VALUES
		(emid,CURRENT_DATE(),CURRENT_TIME());
		SET r=ROW_COUNT();
		RETURN r;
	END IF;
END$$
DELIMITER ;

SELECT add_attendance_in('5');

=============================================

DROP FUNCTION IF EXISTS add_attendance_out;
DELIMITER $$
CREATE FUNCTION add_attendance_out(
	emid VARCHAR(20)
)RETURNS INT
BEGIN
	DECLARE r INT(10);
	DECLARE ot_am DECIMAL(10,2);
	DECLARE late_am DECIMAL(10,2);
	DECLARE cid INT (10);
	DECLARE late_hours INT(10);
	DECLARE ot_hours INT(10);
	DECLARE inTime TIME;
	DECLARE tot_late DECIMAL(10,2);
	DECLARE tot_ot DECIMAL(10,2);
	
	SELECT catid FROM employee WHERE empid=emid INTO cid;
	SELECT OT_average FROM category WHERE catid=cid INTO ot_am;
	SELECT late_per_hour FROM category WHERE catid=cid INTO late_am;
	
	IF(DAYNAME(CURRENT_DATE())='Saturday' OR DAYNAME(CURRENT_DATE())='Sunday') THEN
		SELECT HOUR(TIMEDIFF(in_time,CURRENT_TIME())) FROM attendance WHERE empid=emid AND date=CURRENT_DATE() INTO ot_hours;
		SET tot_late=0;
		SET tot_ot=0;
	ELSE
		IF(CURRENT_TIME()<'08:00:00') THEN
			SELECT HOUR(TIMEDIFF('09:00:00',in_time)) FROM attendance WHERE empid=emid AND date=CURRENT_DATE() INTO late_hours;
		ELSE
			SET late_hours=0;
		END IF;
		IF(CURRENT_TIME()>'17:00:00') THEN
			SELECT HOUR(TIMEDIFF('17:00:00',CURRENT_TIME())) FROM attendance WHERE empid=emid AND date=CURRENT_DATE() INTO ot_hours;
		ELSE
			SET ot_hours=0;
		END IF;
		SELECT in_time FROM attendance WHERE empid=emid AND date=CURRENT_DATE() INTO inTime;
		SET tot_late=0;
		SET tot_ot=0;
		IF(inTime>'08:30:00') THEN
			SET tot_late=late_am;
		END IF;
	END IF;
	
	IF(ot_hours>0) THEN
		SET tot_ot=ot_hours*ot_am;
	END IF;
	IF(late_hours>0) THEN
		SET tot_late=tot_late+(late_am*late_hours);
	END IF;
	UPDATE attendance SET out_time=CURRENT_TIME(),ot_amount=tot_ot,late_amount=tot_late WHERE empid=emid AND date=CURRENT_DATE();
	SET r=ROW_COUNT();
	RETURN r;
END$$
DELIMITER ;

SELECT add_attendance_out('5');

==============================================

DROP FUNCTION IF EXISTS add_leaves;
DELIMITER $$
CREATE FUNCTION add_leaves(
	emid INT(10),
	lt VARCHAR(10),
	d DATE
)RETURNS INT
BEGIN
	DECLARE ld INT(10);
	DECLARE r INT(10);
	DECLARE a INT(10);
	DECLARE l INT (10);
	SELECT lid FROM leaves WHERE empid=emid AND date=CURRENT_DATE() INTO l;
	SET a=return_attendanceId(emid,CURRENT_DATE());
	IF(l>0 OR a>0) THEN 
		RETURN 0;
	ELSE
		SELECT ltid FROM leave_types WHERE type=lt INTO ld;
		INSERT INTO leaves (empid,ltid,date) VALUES(emid,ld,d);
		SET r=ROW_COUNT();
		RETURN r;
	END IF;
END$$
DELIMITER ;

SELECT add_leaves('1','Casual','2018-09-14');
==============================================

SELECT COUNT(lid) FROM leaves WHERE empid='3' AND ltid='2' AND DATE BETWEEN '2018-09-01' AND '2018-09-30';

==============================================

DROP FUNCTION IF EXISTS is_payslip_exist;
DELIMITER $$
CREATE FUNCTION is_payslip_exist(
	eid INT(10)
)RETURNS INT
BEGIN
	DECLARE r INT(10);
	SELECT psid FROM payslip WHERE empid=eid AND YEAR(date)=YEAR(CURRENT_DATE()) AND MONTHNAME(date)=MONTHNAME(CURRENT_DATE()) INTO r;
	IF(r>0) THEN
		RETURN 0;
	ELSE
		RETURN 1;
	END IF;
END$$
DELIMITER ;

=================================================

DROP PROCEDURE IF EXISTS add_pay_slip;
DELIMITER &&
CREATE PROCEDURE add_pay_slip(
	eid int(10)
)
BEGIN
	DECLARE bs DECIMAL(10,2);
	DECLARE cid INT(10);
	DECLARE tot_alow DECIMAL(10,2);
	DECLARE tot_ot DECIMAL(10,2);
	DECLARE tot_late DECIMAL(10,2);
	DECLARE nopa DECIMAL(10,2);
	DECLARE nopc INT(10);
	DECLARE tot_nop DECIMAL(10,2);
	DECLARE tot_etf DECIMAL(10,2);
	DECLARE tot_epf DECIMAL(10,2);
	DECLARE gross DECIMAL(10,2);
	DECLARE tax DECIMAL(10,2);
	DECLARE tid DECIMAL(10,2);
	DECLARE net DECIMAL(10,2);
	DECLARE isExist INT(10);
	
	SELECT basic_salary FROM employee WHERE empid=eid INTO bs;
	SELECT catid FROM employee WHERE empid=eid INTO cid;
	SELECT sum(amount) FROM cat_alowance WHERE catid=cid INTO tot_alow;
	SELECT no_pay_amount FROM category WHERE catid=cid INTO nopa;
	SELECT COUNT(*) FROM leaves WHERE empid=eid AND ltid='03' AND (date BETWEEN DATE_FORMAT(NOW(),'%Y-%m-01')AND NOW()) INTO nopc;
	SET tot_nop=nopc*nopa;
	SELECT SUM(ot_amount)FROM attendance WHERE empid=eid AND (date BETWEEN DATE_FORMAT(NOW(),'%Y-%m-01')AND NOW()) INTO tot_ot;
	SELECT SUM(late_amount) FROM attendance WHERE empid=eid AND (date BETWEEN DATE_FORMAT(NOW(),'%Y-%m-01')AND NOW()) INTO tot_late;
	SET gross=bs+tot_alow+tot_ot;
	SELECT precentage*gross/100 FROM rates WHERE description='ETF' INTO tot_etf;
	SELECT precentage*gross/100 FROM rates WHERE description='EPF' INTO tot_epf;
	SELECT amount,tax_id FROM gov_tax WHERE gross BETWEEN sRange AND eRange INTO tax,tid;
	SET net=gross-(tot_nop+tot_late+tot_etf+(tax*gross/100));
	
	SELECT is_payslip_exist(eid) INTO isExist;
	IF(isExist>0) THEN
		INSERT INTO payslip(empid,tax_id,date,basic,allowance,ot,gross_pay,etf,epf,tax,lates,no_pay,net_pay) VALUES(eid,tid,CURRENT_DATE(),bs,tot_alow,tot_ot,gross,tot_etf,tot_epf,tax*gross/100,tot_late,tot_nop,net);
	END IF;
END&&
DELIMITER ;

CALL add_pay_slip('1');
================================================

DROP PROCEDURE IF EXISTS delete_employee;
DELIMITER &&;
CREATE PROCEDURE delete_employee(IN eid INT(10))
BEGIN
	DELETE FROM employee WHERE empid=eid;
END&&;
DELIMITER ;

CALL delete_employee();

================================================

DROP PROCEDURE IF EXISTS update_employee;
DELIMITER &&;
CREATE PROCEDURE update_employee(
	IN eid INT(10),
	IN cat VARCHAR(20),
	IN ename VARCHAR(10),
	IN tp INT(10),
	IN adrs VARCHAR(10),
	IN basic DECIMAL(10,2),
	IN bd DATE,
	IN idc VARCHAR(20),
	IN mf VARCHAR(10)
)
BEGIN
	DECLARE cid INT(10);
	SET cid=return_catId(cat);
	UPDATE employee SET catid=cid, name=ename, tel=tp, address=adrs, basic_salary=basic, dob=bd, nic=idc, gender=mf WHERE 
	empid=eid;
END&&;
DELIMITER ;

CALL update_employee('3','Supervisor','Ashan','0712345990','Alutgama','40000','1996/10/01','9609802113v','Male');

================================================

DROP FUNCTION IF EXISTS update_category;
DELIMITER $$ 
CREATE FUNCTION update_category(
	name VARCHAR (10),
	basic decimal(10,2),
	nopay decimal(10,2),
	ot decimal(10,2),
	late decimal(10,2),
	a_leaves INT(10),
	c_leaves INT(10)
) RETURNS INT 
BEGIN 
	 DECLARE r int (10);
	 UPDATE category SET avg_basic=basic,no_pay_amount=nopay,OT_average=ot,late_per_hour=late,annual_leaves=a_leaves, casual_leaves=c_leaves WHERE description=name;
	 SET r= ROW_COUNT();
	 return r;
END$$ 
DELIMITER ;

SELECT update_category('Assistant','40000','700','800','1500','30','15');

================================================






================OutPuts Using Procedures=================
DROP PROCEDURE IF EXISTS load_categories;
DELIMITER &&;
CREATE PROCEDURE load_categories()
BEGIN
	SELECT * FROM category;
END&&;
DELIMITER ;

CALL load_categories();
=================================================

DROP PROCEDURE IF EXISTS load_employees;
DELIMITER &&;
CREATE PROCEDURE load_employees()
BEGIN
	SELECT c.description, e.* FROM employee e, category c WHERE c.catid=e.catid;
END&&;
DELIMITER ;

CALL load_employees();
=================================================

DROP PROCEDURE IF EXISTS load_attendance;
DELIMITER &&;
CREATE PROCEDURE load_attendance()
BEGIN
	SELECT e.name, a.* FROM attendance a, employee e where a.empid=e.empid;
END&&;
DELIMITER ;

CALL load_attendance();

==================================================

DROP PROCEDURE IF EXISTS load_leaves;
DELIMITER &&;
CREATE PROCEDURE load_leaves()
BEGIN
	SELECT l.lid, e.name, l.date, lt.type FROM employee e, leaves l, leave_types lt WHERE e.empid=l.empid AND l.ltid=lt.ltid;
END&&;
DELIMITER ;

CALL load_leaves();
==================================================

DROP PROCEDURE IF EXISTS load_payslips;
DELIMITER &&;
CREATE PROCEDURE load_payslips()
BEGIN
	SELECT e.name, p.* FROM employee e, payslip p WHERE e.empid=p.empid;
END&&;
DELIMITER ;

CALL load_payslips();

==================================================

DROP PROCEDURE IF EXISTS remain_leaves;
DELIMITER &&;
CREATE PROCEDURE remain_leaves(
IN eid INT(10),
OUT rmn_alv INT(10),
OUT rmn_clv INT(10)
)
BEGIN
	DECLARE cid INT(10);
	DECLARE tot_a_lvs INT (10);
	DECLARE tot_c_lvs INT(10);
	DECLARE used_a_lvs INT(10);
	DECLARE used_c_lvs INT(10);
	
	SELECT catid FROM employee WHERE empid=eid INTO cid;
	SELECT annual_leaves FROM category WHERE catid=cid INTO tot_a_lvs;
	SELECT casual_leaves FROM category WHERE catid=cid INTO tot_c_lvs;
	
	SELECT COUNT(*) FROM leaves WHERE empid=eid AND ltid='01' INTO used_a_lvs;
	SELECT COUNT(*) FROM leaves WHERE empid=eid AND ltid='02' INTO used_c_lvs;
	
	SET rmn_alv=tot_a_lvs-used_a_lvs;
	SET rmn_clv=tot_c_lvs-used_c_lvs;

END&&;
DELIMITER ;

CALL remain_leaves('03',@rmn_alv,@rmn_clv);
SELECT @rmn_alv,@rmn_clv;

============================================

DROP PROCEDURE IF EXISTS view_cat_alow;
DELIMITER &&;
CREATE PROCEDURE view_cat_alow(cid INT(10))
BEGIN
	select ca.cat_alow_id, a.description, ca.amount from cat_alowance ca, allowances a, category c where a.alowid=ca.alowid and c.catid=ca.catid and c.catid=cid;
END&&;
DELIMITER ;

CALL view_cat_alow('01');

=============================================

DROP PROCEDURE IF EXISTS leave_types;
DELIMITER &&;
CREATE PROCEDURE leave_types()
BEGIN
	SELECT * FROM leave_types;
END&&;
DELIMITER ;

CALL leave_types();
=====================================

DROP PROCEDURE IF EXISTS today_attendance;
DELIMITER &&;
CREATE PROCEDURE today_attendance()
BEGIN
	SELECT a.empid, e.name ,a.date,a.in_time, IFNULL(a.out_time,'Pending')AS out_time, IFNULL(a.ot_amount,'Pending')AS ot_amount, IFNULL(a.late_amount,'Pending')AS late_amount FROM attendance a, employee e WHERE a.empid=e.empid AND a.date=CURRENT_DATE();
END&&;
DELIMITER ;

CALL today_attendance();

======================================

DROP PROCEDURE IF EXISTS update_cat_allowance;
DELIMITER &&;
CREATE PROCEDURE update_cat_allowance(IN caid INT(10),IN amnt DECIMAL(10,2))
BEGIN
	UPDATE cat_alowance SET amount=amnt WHERE cat_alow_id=caid;
END &&;
DELIMITER ;

CALL update_cat_allowance('02','1250');

=======================================

DROP PROCEDURE IF EXISTS search_employees;
DELIMITER &&;
CREATE PROCEDURE search_employees(n VARCHAR(20))
BEGIN
	SELECT c.description, e.* FROM employee e, category c WHERE c.catid=e.catid AND e.name LIKE CONCAT('%',n,'%');
END&&;
DELIMITER ;

CALL search_employees('Th');

========================================

DROP PROCEDURE IF EXISTS search_attendance;
DELIMITER &&;
CREATE PROCEDURE search_attendance(emp VARCHAR(20), adate DATE)
BEGIN
	DECLARE eid INT(10);
	SELECT empid FROM employee WHERE name LIKE CONCAT('%',emp,'%') LIMIT 1 INTO eid;
	IF(adate > CURRENT_DATE() AND (emp IS NULL OR emp='')) THEN
		SELECT e.name, a.* FROM attendance a, employee e where a.empid=e.empid;
	END IF;
	IF(emp IS NULL AND adate <=CURRENT_DATE()) THEN
		SELECT e.name, a.* FROM attendance a, employee e where a.empid=e.empid AND a.date=adate;
	END IF;
	IF(adate > CURRENT_DATE() AND emp IS NOT NULL) THEN 
		SELECT e.name, a.* FROM attendance a, employee e where a.empid=e.empid AND a.empid=eid;
	END IF;
	IF(adate <= CURRENT_DATE() AND emp IS NOT NULL) THEN 
		SELECT e.name, a.* FROM attendance a, employee e where a.empid=e.empid AND a.empid=eid AND a.date=adate;
	END IF;
END &&;
DELIMITER ;

CALL search_attendance('R','');

==============================================


DROP PROCEDURE IF EXISTS search_leave;
DELIMITER &&;
CREATE PROCEDURE search_leave(emp VARCHAR(20), ldate DATE)
BEGIN
	DECLARE eid INT(10);
	SELECT empid FROM employee WHERE name LIKE CONCAT('%',emp,'%') LIMIT 1 INTO eid;
	IF(ldate > CURRENT_DATE() AND (emp IS NULL OR emp='')) THEN
		SELECT e.name, a.* FROM leaves l, employee e where l.empid=e.empid;
	END IF;
	IF(emp IS NULL AND ldate <=CURRENT_DATE()) THEN
		SELECT e.name, l.* FROM leaves l, employee e where l.empid=e.empid AND l.date=ldate;
	END IF;
	IF(adate > CURRENT_DATE() AND emp IS NOT NULL) THEN 
		SELECT e.name, l.* FROM leaves l, employee e where l.empid=e.empid AND l.empid=eid;
	END IF;
	IF(adate <= CURRENT_DATE() AND emp IS NOT NULL) THEN 
		SELECT e.name, l.* FROM leaves l, employee e where l.empid=e.empid AND l.empid=eid AND l.date=ldate;
	END IF;
END &&;
DELIMITER ;

CALL search_leave('R','');

========================================

DROP PROCEDURE IF EXISTS load_employees_no_ps_this_month;
DELIMITER &&;
CREATE PROCEDURE load_employees_no_ps_this_month()
BEGIN
	SELECT category.description ,employee.* from employee, category where empid not in(select empid from payslip where date BETWEEN DATE_FORMAT(NOW(),'%Y-%m-01')AND NOW()) and category.catid in(select catid from employee)GROUP BY empid;
END&&;
DELIMITER ;

CALL load_employees_no_ps_this_month();


 AND (YEAR(CURRENT_DATE())!=YEAR(p.date) AND MONTHNAME(CURRENT_DATE())!=MONTHNAME(p.date))

 
 
 
 
 
=================Triggers================

DROP TRIGGER IF EXISTS edit_employee;
DELIMITER $$
CREATE TRIGGER edit_employee 
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
	INSERT INTO before_employee_update VALUES(CURRENT_DATE(),OLD.empid,OLD.catid,OLD.name,OLD.tel,OLD.address,OLD.basic_salary,OLD.dob,OLD.nic,OLD.gender);
END$$
DELIMITER ;

=========================================

DROP TRIGGER IF EXISTS sum_of_epf;
DELIMITER $$
CREATE TRIGGER sum_of_epf
AFTER INSERT ON payslip
FOR EACH ROW
BEGIN
	INSERT INTO epf_sum (empid,tot_epf) VALUES(NEW.empid,NEW.epf);
END$$
DELIMITER ;

==========================================






SELECT DISTIN category.description ,employee.* from employee, category where empid not in(select empid from payslip where date between '2018-09-01' and CURRENT_DATE()) and category.catid in(select catid from employee);












