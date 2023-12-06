

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
-------------------------------------------------------------------
drop table tr
create table tr(
	tr_idx int auto_increment,
	tr_title varchar(270),
	tr_content text,
	user_idx int,
	tr_time timestamp,
	tr_imgpath varchar(255),
	primary key(tr_idx)
)

insert into tr (tr_title,tr_content,user_idx)
values ('예시 제목','<p>예시 내용입니다</p><button class="btn btn-primary">버튼</button> ',1)


---------------------------------------------------------------------
drop table trComment

create table trComment(
	tr_idx int,
	tr_parent_idx int, 
	tr_comment_idx int auto_increment, 
	user_idx int,
	tr_comment_time timestamp,
	tr_comment_content varchar(255),
	tr_comment_useable int,
	primary key (tr_comment_idx)
)

--1번 게시글
-- 1번 댓글을 달았음
delete from trComment
insert into trComment (tr_idx,tr_parent_idx,user_idx,tr_comment_content)
values (1,1,1,'댓글')

--1번 게시글
-- 2번 댓글을 달았음
insert into trComment (tr_idx,tr_parent_idx,user_idx,tr_comment_content)
values (1,1,1,'댓글')

--1번 게시글
-- 1번 댓글에 대댓글을 달앗음
insert into trComment (tr_idx,tr_parent_idx,user_idx,tr_comment_content)
values (1,3,1,'댓글')

--1번 게시글
--1번 댓글에 대댓글을 달았음
insert into trComment (tr_idx,tr_parent_idx,user_idx,tr_comment_content)
values (1,1,1,'댓글')



-----------------------------


