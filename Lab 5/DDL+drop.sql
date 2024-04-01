
drop table prereq cascade constraints;
drop table time_slot cascade constraints;
drop table advisor cascade constraints;
drop table takes cascade constraints;
drop table student cascade constraints;
drop table teaches cascade constraints;
drop table section cascade constraints;
drop table instructor cascade constraints;
drop table course cascade constraints;
drop table department cascade constraints;
drop table classroom cascade constraints;



create table classroom
	(building		varchar(15),
	 room_number		varchar(7),
	 capacity		numeric(4,0),
	 primary key (building, room_number)
	);

create table department
	(dept_name		varchar(20), 
	 building		varchar(15), 
	 budget		        numeric(12,2) check (budget > 0),
	 primary key (dept_name)
	);

create table course
	(course_id		varchar(8), 
	 title			varchar(50), 
	 dept_name		varchar(20),
	 credits		numeric(2,0) check (credits > 0),
	 primary key (course_id),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table instructor
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 salary			numeric(8,2) check (salary > 29000),
	 primary key (ID),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table section
	(course_id		varchar(8), 
         sec_id			varchar(8),
	 semester		varchar(6)
		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
	 year			numeric(4,0) check (year > 1701 and year < 2100), 
	 building		varchar(15),
	 room_number		varchar(7),
	 time_slot_id		varchar(4),
	 primary key (course_id, sec_id, semester, year),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (building, room_number) references classroom (building, room_number)
		on delete set null
	);

create table teaches
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (ID) references instructor (ID)
		on delete cascade
	);

create table student
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 tot_cred		numeric(3,0) check (tot_cred >= 0),
	 primary key (ID),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table takes
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		        varchar(2),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (ID) references student (ID)
		on delete cascade
	);

create table advisor
	(s_ID			varchar(5),
	 i_ID			varchar(5),
	 primary key (s_ID),
	 foreign key (i_ID) references instructor (ID)
		on delete set null,
	 foreign key (s_ID) references student (ID)
		on delete cascade
	);

create table time_slot
	(time_slot_id		varchar(4),
	 day			varchar(1),
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60),
	 primary key (time_slot_id, day, start_hr, start_min)
	);

create table prereq
	(course_id		varchar(8), 
	 prereq_id		varchar(8),
	 primary key (course_id, prereq_id),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (prereq_id) references course (course_id)
	);


	alter table instructor rename column ID to i_ID;

	task1--

	create or replace view Advisor_Selection as 
	select i_ID, name, dept_name
	from instructor;

	select * from Advisor_Selection;

	task2--

	create or replace view Student_Count as
	select name, count(s_ID) as student_count 
	from Advisor_Selection natural join advisor
	group by name;

	select * from Student_Count;

	task 3--
	a--
	create role students;
	grant select on s200042147.advisor to students;
	grant select on s200042147.course to students;

	b--
	create role course_teacher;
	grant select on s200042147.student to course_teacher;
	grant select on s200042147.course to course_teacher;

	c--
	create role dept_head;
	grant course_teacher to dept_head;
	grant select on s200042147.instructor to dept_head;
	grant insert on s200042147.instructor to dept_head;

	d--
	create role administrator;
	grant select on s200042147.department to administrator;
	grant select on s200042147.instructor to administrator;
	grant update (budget) on s200042147.department to administrator;


	4--

	create user dayan identified by s5;
	grant students to dayan;
	grant create session to dayan;

	create user sian identified by s51;
	grant course_teacher to sian;
	grant create session to sian;

	create user armk identified by s1;
	grant dept_head to armk;
	grant create session to armk;

	create user tees identified by s47;
	grant administrator to tees;
	grant create session to tees;


	disc;

	conn dayan/s5;
	select * from s200042147.course;  works
	select * from s200042147.advisor;  works
	select * from s200042147.student; not works

	disc;

	conn sian/s51;
	select * from s200042147.student; works
	select * from s200042147.course;  works
	select * from s200042147.department;  not works

	disc;

	conn armk/s1;
	select * from s200042147.student; works
	select * from s200042147.course; works
	select * from s200042147.department; not works

	insert into s200042147.instructor values
	('45311','Talha','Comp. Sci.','50001');

	select * from s200042147.instructor;

	disc;

	conn tees/s47;

	select * from s200042147.department; works
	select * from s200042147.instructor; works
	select * from s200042147.student; not works

	update s200042147.department
	set budget=700
	where dept_name='History';

	select * from s200042147.department;  works


	update s200042147.department
	set dept_name='Histo'
	where dept_name='History';






	








