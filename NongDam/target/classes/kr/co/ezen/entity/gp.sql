<<<<<<< HEAD
=======


----------------------------------------------------------------------------

>>>>>>> branch 'main' of https://github.com/YJY1129/Nongdam.git
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
select * from gp;

insert into Gp (gp_title, gp_date_start, gp_date_last, user_idx) 
values('테스트용 제목입니다','2023-12-06','2023-12-07',1);

create table gpUser (
gp_idx int,
user_idx int,
gp_addr varchar(50),
gp_name	varchar(20),
gp_email varchar(20),
gp_total varchar(20),
gp_num varchar(20)
)

drop table gpUser;
select * from gpUser;

