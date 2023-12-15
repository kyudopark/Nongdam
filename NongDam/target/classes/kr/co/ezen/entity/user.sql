CREATE TABLE User (
    user_idx BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(20) NOT NULL,
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
select*from User;

delete from User where user_idx=4;
delete from User where user_idx=6;



INSERT INTO User (user_id, user_pw, user_admin, user_nickname, user_name, user_email) VALUES ('admin', '1234', true, 'admin', 'admin', 'kdpark1002@naver.com');