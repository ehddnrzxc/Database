# 고객(Customer), 제품(Product), 구매(Purchase), 구매상세(PurchaseDetail) 테이블을 생성합니다.
# 여러 고객은 여러 제품을 구매할 수 있습니다.
# 한 번의 구매에는 여러 제품이 포함될 수 있습니다.
# 고객명, 고객연락처, 제품명, 제품가격, 재고, 구매일, 구매한제품갯수 정보를 저장하세요.

# db_model 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS db_model;

# db_model 데이터베이스 사용
USE db_model;

# 고객 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_customer (
  customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  phone CHAR(11) NULL
) ENGINE=InnoDB;

# 제품 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_product (
  product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  remain VARCHAR(255) NULL
) ENGINE=InnoDB;

# 구매 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_purchase (
  purchase_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
) ENGINE=InnoDB;

# 구매상세 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_purchaseDetail (
  purchde_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  purchde_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  purchde_n VARCHAR(255) NULL,
  cus_id INT NOT NULL,
  prod_id INT NOT NULL,
  pur_id INT NOT NULL,
  FOREIGN KEY(cus_id) REFERENCES tbl_customer(customer_id) ON DELETE CASCADE,
  FOREIGN KEY(prod_id) REFERENCES tbl_product(product_id) ON DELETE CASCADE,
  FOREIGN KEY(pur_id) REFERENCES tbl_purchase(purchase_id) ON DELETE CASCADE,
  UNIQUE KEY(cus_id, prod_id, pur_id)
) ENGINE=InnoDB;

# 구매상세 테이블 삭제
DROP TABLE IF EXISTS tbl_purchaseDetail;

# 구매 테이블 삭제
DROP TABLE IF EXISTS tbl_purchase;

# 제품 테이블 삭제
DROP TABLE IF EXISTS tbl_product;

# 고객 테이블 삭제
DROP TABLE IF EXISTS tbl_customer;

# db_model 데이터베이스 삭제
DROP DATABASE IF EXISTS db_model;