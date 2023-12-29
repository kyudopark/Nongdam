CREATE TABLE User (
    user_idx INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) unique NOT NULL,
    user_pw VARCHAR(15) NOT NULL,
    user_zipcode VARCHAR(255),
    user_addr VARCHAR(255),
    user_gender CHAR(1),
    user_nickname VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    user_profile VARCHAR(255),
    user_email VARCHAR(255) NOT NULL,
    user_kakaologin VARCHAR(255),
    user_admin BOOLEAN NOT NULL DEFAULT false
);         

desc User;

select*from User;
select*from tr;
sapcwewfnbim

ALTER TABLE User
MODIFY COLUMN user_pw VARCHAR(50) NOT NULL;

drop table User;
delete from User where user_idx=14;




INSERT INTO User (user_id, user_pw, user_admin, user_nickname, user_name, user_email) VALUES ('asdf', '1234', true, 'admin', 'admin', 'kdpark1002@naver.com');
INSERT INTO User (user_id, user_pw, user_admin, user_nickname, user_name, user_email) VALUES ('asdf', '1234', true, 'admin', 'admin', 'kdpark1002@naver.com');
INSERT INTO User (user_id, user_pw, user_admin, user_nickname, user_name, user_email) VALUES ('asdf', '1234', true, 'admin', 'admin', 'kdpark1002@naver.com');
INSERT INTO User (user_id, user_pw, user_admin, user_nickname, user_name, user_email) VALUES ('asdf', '1234', true, 'admin', 'admin', 'kdpark1002@naver.com');
INSERT INTO User (user_id, user_pw, user_admin, user_nickname, user_name, user_email) VALUES ('asdf', '1234', true, 'admin', 'admin', 'kdpark1002@naver.com');
INSERT INTO User (user_id, user_pw, user_admin, user_nickname, user_name, user_email) VALUES ('asdf', '1234', true, 'admin', 'admin', 'kdpark1002@naver.com');
INSERT INTO User (user_id, user_pw, user_admin, user_nickname, user_name, user_email) VALUES ('asdf', '1234', true, 'admin', 'admin', 'kdpark1002@naver.com');