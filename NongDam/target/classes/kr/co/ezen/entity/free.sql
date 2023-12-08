create table free (

free_idx int ,
free_title varchar(50) not null,
free_content text not null,
free_date  DATETIME DEFAULT CURRENT_TIMESTAMP not null, 
free_tag varchar(15),
free_count int,

 primary key(free_idx)
 )

drop table free;

select * from free;

desc free;



commit;




