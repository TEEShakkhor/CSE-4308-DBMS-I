create table Citizen(
    NID int,
    name varchar2(100),
    birthdate date,
    occupation varchar2(20),
    blood_group varchar2(3),
    division varchar2(20),
    district varchar2(20),
    license_id int null,

    primary key (NID),
    foreign key(division) references Division(name),
    foreign key(district) references District(name),
    foreign key(license_id) references Driving_License(license_id)
);

create table Driving_License(
    license_id int,
    type varchar2(20),
    issue_date date,
    expire_date date,

    primary key (license_id)
);


create table Division(
    name varchar2(20),
    size int,
    description varchar2(3000),

    primary key (name)
);

create table District(
    name varchar2(20),
    size int,
    description varchar2(3000),
    division_name varchar2(20),

    primary key(name),
    foreign key (division_name) references Division(name)
);

create table Central_System(
    accident_id int,
    accident_date_time datetime,
    location varchar2(100),
    death int null,
    license_id int
    
    primary key (accident_id),
    foreign key(license_id) references Driving_License(license_id)

);

CREATE TABLE Admission(
    admission_id int,
    admission_date date,
    release_date date,
    description varchar2(3000),
    NID int,
    hospital_id int,

    primary key(admission_id),
    foreign key (NID) references Citizen(NID),
    FOREIGN KEY (hospital_id) references Hospital(reg_id)
);

create or replace TYPE vcontact AS VARRAY(10) OF varchar2(11);


create table Hospital(
    reg_id int,
    name varchar2(100),
    contact_number vcontact,

    primary key (reg_id)    

);