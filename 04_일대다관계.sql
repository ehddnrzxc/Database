# 제품 테이블   카테고리 테이블
# M             1  (1개의 카테고리에 M개의 제품이 연결됩니다.)
# FK            PK
# 자식(child)   부모(parent)
#               먼저 생성
# 먼저 삭제


# db_model 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS db_model;    # CREATE SCHEMA IF NOT EXISTS db_model;(이 코드와 같은 말)

# db_model 데이터베이스 사용
USE db_model;

# 카테고리 테이블(tbl_category)
CREATE TABLE IF NOT EXISTS tbl_category (
  category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL,
  category_describe TEXT,    # TEXT: 대용량 문자열
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

# 제품 테이블(tbl_product) 생성
CREATE TABLE IF NOT EXISTS tbl_product (
  product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,  # 카테고리 테이블과 관계를 맺는 칼럼
  product_name VARCHAR(50) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  discount DECIMAL(10,2) NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY(category_id) REFERENCES tbl_category(category_id)  # 외래키 설정: 현재 테이블의 category_id(외래키)는 카테고리 테이블의 category_id 칼럼이 가진 값만 가질 수 있습니다. 
    ON UPDATE CASCADE   # 부모 테이블의 PK가 수정되면 자식 테이블의 FK가 함께 수정됩니다.
    ON DELETE CASCADE   # 부모 테이블의 PK가 삭제되면 자식 테이블의 FK가 함께 삭제됩니다.
) ENGINE=InnoDB;   # FOREIGN KEY: 다른 테이블과 연결해주는 키, REFERENCES: 참조

# 제품의 이미지를 등록하고자 합니다.
# 이미지 아이디, 제품 아이디, 이미지 주소, 메인 이미지 여부, 최초 등록 일시 
# 정보를 저장할 수 있도록 tbl_product_image 테이블을 만들고,
# 필요한 관계를 맺어보세요.

#  제품 이미지 테이블(tbl_product_image) 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_product_image(
  image_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_id INT NULL,
  image_url VARCHAR(255) NOT NULL,
  is_main BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(product_id) REFERENCES tbl_product(product_id)
    ON UPDATE CASCADE   # 부모 테이블의 PK가 수정되면 자식 테이블의 FK가 함께 수정됩니다.
    ON DELETE SET NULL  # 부모 테이블의 PK가 삭제되면 자식 테이블의 FK가 NULL이 됩니다.
) ENGINE=InnoDB;


# 제품 이미지 테이블 삭제
DROP TABLE IF EXISTS tbl_product_image;

# 제품 테이블 삭제
DROP TABLE IF EXISTS tbl_product;

# 카테고리 테이블 삭제
DROP TABLE IF EXISTS tbl_category;

# db_model 데이터베이스 삭제
DROP DATABASE IF EXISTS db_model;