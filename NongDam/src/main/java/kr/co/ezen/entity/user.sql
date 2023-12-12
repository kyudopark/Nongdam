CREATE TABLE User (
<<<<<<< HEAD
    user_idx INT AUTO_INCREMENT PRIMARY KEY,
=======
    user_idx BIGINT AUTO_INCREMENT PRIMARY KEY,
>>>>>>> branch 'main' of https://github.com/YJY1129/Nongdam.git
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
<<<<<<< HEAD
delete from User where user_idx=8;
=======
>>>>>>> branch 'main' of https://github.com/YJY1129/Nongdam.git

<<<<<<< HEAD
=======
delete from User where user_idx=5;
delete from User where user_idx=6;



>>>>>>> branch 'main' of https://github.com/YJY1129/Nongdam.git
INSERT INTO User (user_id, user_pw, user_admin, user_nickname, user_name, user_email) VALUES ('admin', '1234', true, 'admin', 'admin', 'kdpark1002@naver.com');
