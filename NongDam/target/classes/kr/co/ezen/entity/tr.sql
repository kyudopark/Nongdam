
-------------------------------------------------------------------
drop table tr
create table tr(
	tr_idx int auto_increment,
	tr_title varchar(270),
	tr_content text,
	user_idx int,
	tr_time datetime,
	tr_imgpath varchar(255),
	primary key(tr_idx)
)


select * from User

insert into tr (tr_title,tr_content,user_idx)
values ('예시 제목','<p>예시 내용입니다</p><button>버튼</button> ',1)


insert into Tr (tr_title,tr_content,user_idx,tr_imgpath)
			    VALUES ('123','123',1,null)
			    

<<<<<<< HEAD
			    delete * table tr
=======
>>>>>>> branch 'main' of https://github.com/YJY1129/Nongdam.git
---------------------------------------------------------------------
drop table trComment
select * from trComment

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
select * from tr

--1번 게시글
-- 1번 댓글을 달았음
delete from trComment
insert into trComment (tr_idx,tr_parent_idx,user_idx,tr_comment_content,tr_comment_useable)
values (1,1,1,'댓글1',1)

--1번 게시글
-- 2번 댓글을 달았음
insert into trComment (tr_idx,tr_parent_idx,user_idx,tr_comment_content,tr_comment_useable)
values (1,2,1,'댓글2',1)

--1번 게시글
-- 1번 댓글에 대댓글을 달앗음
insert into trComment (tr_idx,tr_parent_idx,user_idx,tr_comment_content,tr_comment_useable)
values (1,1,1,'댓글3',1)

--1번 게시글
--1번 댓글에 대댓글을 달았음
insert into trComment (tr_idx,tr_parent_idx,user_idx,tr_comment_content,tr_comment_useable)
values (1,1,1,'댓글4',1)


-----------------------------



drop table User;

