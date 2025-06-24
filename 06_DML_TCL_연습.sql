/*
문제. 계좌 이체 처리하기

1. db_bank 데이터베이스와 은행, 고객, 계좌 테이블을 생성합니다.
  1) 관계 설정
    (1) 은행과 고객은 다대다 관계입니다.
    (2) 하나의 은행에는 여러 개의 계좌 정보가 존재합니다.
    (3) 하나의 고객은 여러 개의 계좌를 가질 수 있습니다.
  2) 칼럼 설정
    (1) 은행: 은행 아이디, 은행 이름
    (2) 고객: 고객 아이디, 고객 이름, 고객 연락처
    (3) 계좌: 계좌 아이디, 잔고 등
  3) 레코드 설정 (행 설정)
    (1) 각 테이블에 최소 2개의 샘플 데이터를 입력합니다.
    (2) 100,000원 이상의 잔고를 가지도록 입력합니다.
2. 계좌 이체 트랜잭션을 처리합니다.
  1) 각 테이블에 최소 2개의 샘플 데이터를 입력합니다.
  2) 1번 고객이 2번 고객으로 100,000만원을 계좌 이체하는 트랜잭션을 작성하고 실행합니다.
  3) 쿼리문 실행 중 발생하는 오류는 없다고 가정하고 ROLLBACK 처리는 하지 않습니다.
*/

# db_bank 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS db_bank;

# db_bank 데이터베이스 사용
USE db_bank;

# 은행 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_bank (
bank_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
bank_name VARCHAR(30) NOT NULL
) ENGINE=InnoDB;

# 고객 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_customer (
cus_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
cus_name VARCHAR(30) NOT NULL,
phone CHAR(11) NOT NULL
) ENGINE=InnoDB;

# 계좌 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_account (
act_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
bank_id INT NOT NULL,
cus_id INT NOT NULL,
act_bal VARCHAR(255) NOT NULL,
FOREIGN KEY(bank_id) REFERENCES tbl_bank(bank_id)
 ON UPDATE CASCADE
 ON DELETE CASCADE,
FOREIGN KEY(cus_id) REFERENCES tbl_customer(cus_id) 
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  UNIQUE KEY(bank_id, cus_id)
) ENGINE=InnoDB;

# 은행 테이블 데이터 삽입
INSERT INTO tbl_bank (bank_name)
VALUES ("국민");
INSERT INTO tbl_bank (bank_name)
VALUES ("신한");

# 고객 테이블 데이터 삽입
INSERT INTO tbl_customer (cus_name, phone)
VALUES ("호날두", 01023132424);
INSERT INTO tbl_customer (cus_name, phone)
VALUES ("아자르", 01023114423);

# 계좌 테이블 데이터 삽입
INSERT INTO tbl_account (bank_id, cus_id, act_bal)
VALUES (1, 1, 200000);
INSERT INTO tbl_account (bank_id, cus_id, act_bal)
VALUES (2, 2, 100000);

# 계좌 이체 트랜잭션 처리 (1번 계좌 -> 2번 계좌로 100,000원 이체)
START TRANSACTION;

# 1번 계좌에서 100,000원 출금
UPDATE tbl_account
set act_bal = act_bal - 100000
WHERE act_id = 1 AND act_bal >= 100000;

# 2번 계좌로 100,000 입금
UPDATE tbl_account
SET act_bal = act_bal + 100000
WHERE act_id = 2;

# 작업 저장
COMMIT;
