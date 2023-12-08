create table User(
user_idx int auto_increment,
user_id varchar(30),
user_pw varchar(30),
user_zipcode varchar(30),
user_addr varchar(200),
user_gender char(1),
user_nickname varchar(50),
user_name varchar(30),
user_email varchar(50),
primary key(user_idx)

);

insert into User (user_id,user_pw,user_nickname,user_name) 
values("admin","admin","nickname","name");

select * from user;

----------------------------------------------------------------------------

create table gp (
gp_idx int auto_increment,
gp_title varchar(90),
gp_product varchar(15),
gp_content text,
user_idx int,
gp_price varchar(10),
gp_date TIMESTAMP,
gp_date_start datetime,
gp_date_last datetime,
gp_thumb varchar(5050),
primary key(gp_idx)
)

drop table gp;

insert into Gp (gp_title, gp_date_start, gp_date_last) 
values('테스트용 제목입니다','2023-12-06','2023-12-07');

select * from gpUser;

create table gpUser (
gp_idx int,
user_idx int,
gp_addr varchar(50),
gp_name	varchar(20),
gp_email varchar(20),
gp_num varchar(20),
FOREIGN KEY (user_idx) REFERENCES User (user_idx)
)


