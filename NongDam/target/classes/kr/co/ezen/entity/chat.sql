-- 231217~ laky --

create table chat(
	chatroom_idx int,
	user_idx int,
	chat_time datetime,
	chat_message text
)

create table chatRoom(
	chatroom_idx int,
	user_idx int,
	chat_disabled_time datetime
)
desc chatRoom
-- ====================================
drop table 
select * from info
delete from 
select * from 

-- 20240103 ===========================
create table info(
	info_idx int not null auto_increment,
	info_title varchar(90),
	info_content text,
	info_date datetime default now(),
	user_idx int,
	info_tag varchar(20),
	info_count int,
	primary key (info_idx)
)
create table infoLike(
	info_idx int,
	user_idx int
)
-- ====================================
create table User(
	user_idx int not null auto_increment,
	user_id varchar(50) not null unique,
	user_pw varchat(50) not null,
	user_zipcode varchar(5),
	user_addr varchar(255),
	user_gender char(1),
	user_nickname varchar(20),
	user_name varchar(10) not null,
	user_profile varchar(255),
	user_email varchar(255),
	user_kakaologin varchar(2),
	user_admin tinyint,
	primary key (user_idx)
)

-- ====================================
create table freeComment(
	free_idx int,
	free_parent_idx int, 
	free_comment_idx int auto_increment, 
	user_idx int,
	free_comment_time timestamp DEFAULT CURRENT_TIMESTAMP,
	free_comment_content varchar(255),
	free_comment_useable int,
	primary key (free_comment_idx)
)

-- ====================================