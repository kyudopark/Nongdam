create table free (

free_idx int auto_increment,
free_title varchar(90) not null,
free_content text not null,
free_date TIMESTAMP not null, 
user_idx int,
free_tag varchar(15),
free_count int,

 primary key(free_idx),
 FOREIGN KEY (user_idx) REFERENCES User (user_idx)
 )


drop table free;

select * from free;

insert into free(free_idx, free_title, free_content, free_date) 
values  (1,'테스트','응아아앙','2023-10-11');


desc free;

commit;

--------------------------

create table freeComment ( 

free_idx int,
free_parent_idx int,
free_comment_idx int auto_increment,
user_idx int,
free_comment_time timestamp,
free_comment_content varchar(255),
free_comment_useable int,

primary key(free_comment_idx)
)

drop table freeComment;

insert into freeComment (free_idx, free_comment_time, free_comment_content)
values  (1,'2023-12-11','테스트');


