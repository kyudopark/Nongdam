create table free (

free_idx int auto_increment,
free_title varchar(90) not null,
free_content text not null,
free_date TIMESTAMP not null, 
user_idx INT,
free_tag varchar(15),
free_count int,

 primary key(free_idx),
 FOREIGN KEY (user_idx) REFERENCES User (user_idx)
 )


drop table free;

select * from free;

 select * from free where free_tag="질문"  order by free_idx desc;
 select * from free where free_tag="자유"  order by free_idx desc;
select count(*) from free;
insert into free(free_idx, free_title, free_content, free_date) 
values  (1,'테스트','응아아앙','2023-10-51');
insert into free(free_idx, free_title, free_content, free_date) 
values  (2,'테스트','ㅎ','2023-10-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (3,'테스트','ㅇㅁㄴㄹ','2023-10-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (4,'테스트','ㄲㄲ','2023-10-19');
insert into free(free_idx, free_title, free_content, free_date) 
values  (5,'테스트','ㅇㅅㅇ','2023-10-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (6,'테스트','ㅇㅁㅇ','2023-10-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (7,'테스트','ㅇㅂㅇ','2023-10-15');
insert into free(free_idx, free_title, free_content, free_date) 
values  (8,'테스트','안녕하세용','2023-12-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (9,'테스트','싫어용','2023-10-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (10,'테스트','저리가세용','2023-10-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (11,'테스트','ㄲ꺄아아ㅏㄱ','2023-12-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (12,'테스트','ㄲ꺄아아ㅏㄱ','2023-12-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (13,'테스트','ㄲ꺄아아ㅏㄱ','2023-12-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (14,'테스트','ㄲ꺄아아ㅏㄱ','2023-12-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (15,'테스트','ㄲ꺄아아ㅏㄱ','2023-12-11');
insert into free(free_idx, free_title, free_content, free_date) 
values  (16,'테스트','ㄲ꺄아아ㅏㄱ','2023-12-11');



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

primary key(free_comment_idx)
)

drop table freeComment;

insert into freeComment (free_idx, free_comment_time, free_comment_content)
values  (1,'2023-12-11','테스트');


