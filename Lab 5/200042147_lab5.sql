

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
	where dept_name='';

	select * from s200042147.department;  works

