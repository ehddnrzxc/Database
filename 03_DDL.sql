# 데이터베이스 생성하기
CREATE DATABASE IF NOT EXISTS db_ddl;

# 데이터베이스 사용하기
USE db_ddl;

# 테이블 생성하기 (데이터 저장을 위한 데이터베이스 객체)
# 행(Row), 열(Column)
# 기본 문법: 칼럼명 -> 데이터타입 -> 제약조건 순으로 작성
CREATE TABLE IF NOT EXISTS tbl_product (
  product_id   INT            NOT NULL AUTO_INCREMENT PRIMARY KEY,   # AUTO_INCREMENT: 자동 증가 데이터(번호표), PRIMARY KEY: 기본 키(데이터 식별자)
  product_name VARCHAR(50)   NOT NULL,      # VARCHAR: 문자열(최대 글자 수)
  price        DECIMAL(10,2) NOT NULL,      # DECIMAL: (총 수, 소수점 수), NOT NULL: 필수 입력
  discount     DECIMAL(10,2) NULL,
  created_at   DATETIME      DEFAULT NOW()
) ENGINE=InnoDB;     

# 스토리지 엔진
# InnoDB: 트랜잭션 지원(동시성 지원, 여러 사람 사용 가능), 외래키 지원(무결성 지원, 잘못된 데이터 사용 불가), 은행 또는 쇼핑
# MyISAM: 풀텍스트 인덱스 지원(읽기 위주 작업에 특화)

# AUTO_INCREMENT 시작 값을 바꾸는 방법
ALTER TABLE tbl_product AUTO_INCREMENT = 1000;  # 순번 1000부터 시작, 기본 시작값 1

# 테이블 삭제하기 (취소 불가능)
DROP TABLE IF EXISTS tbl_product;

# 데이터베이스 삭제하기 (취소 불가능)
DROP DATABASE IF EXISTS db_ddl;