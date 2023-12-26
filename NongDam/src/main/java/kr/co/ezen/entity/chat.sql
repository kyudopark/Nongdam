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
desc trComment
-- ====================================
drop table chat
drop table chatroom
select * from User
select * from chat 
select * from chatRoom
delete from chatroom where chatroom_idx=0
delete from chat



select	
				x.chatroom_idx, x.user_idx, y.user_idx AS user_corr_idx, x.chat_disabled_time,
				User.user_nickname AS user_corr_name,
				IFNULL(User.user_profile,null) AS user_corr_profile,
				chat.chat_time AS last_chat_time,
				chat.chat_message AS last_chat_message	
			from	
				chatRoom AS x LEFT JOIN chatRoom AS y ON x.chatroom_idx=y.chatroom_idx
				LEFT JOIN User ON y.user_idx=User.user_idx
				LEFT JOIN (select chatroom_idx, chat_message, chat_time 
									from chat 
									where (chat_time) in (
										select max(chat_time) as chat_time 
									    	from chat 
									        group by chatroom_idx
									   )) AS chat ON x.chatroom_idx=chat.chatroom_idx
			where
				x.user_idx=18
				and y.user_idx!=18
			GROUP BY	
				x.chatroom_idx,	
				x.user_idx,	
				y.user_idx,	
				x.chat_disabled_time,
				last_chat_time,
				last_chat_message	
			HAVING	
				last_chat_time > x.chat_disabled_time
			ORDER BY	
				last_chat_time DESC
