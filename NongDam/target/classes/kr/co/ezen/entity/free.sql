create table free (

free_idx int auto_increment,
free_title varchar(90) not null,
free_content text not null,
free_date datetime not null, 
user_idx INT,
free_tag varchar(15),
free_count int,

 primary key(free_idx),
 FOREIGN KEY (user_idx) REFERENCES User (user_idx)
 )

 insert into free (free_idx, free_title, free_content, free_date, free_tag)
values  (18,'테스트','테스트','2023-12-21 12:17:24.0','자유');
 
 
drop table free;
DELETE FROM free;

select * from free;

desc free;

commit;

--------------------------

create table freeComment ( 

free_idx int,
free_parent_idx int,
free_comment_idx int auto_increment,
user_idx INT,
free_comment_time timestamp,
free_comment_content varchar(255),
free_comment_useable int,
free_imgpath varchar(255),

primary key(free_comment_idx) )


drop table freeComment;

insert into freeComment (free_idx, free_comment_time, free_comment_content)
values  (1,'2023-12-11','테스트');



select * from freeComment;
