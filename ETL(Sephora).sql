USE sephoraETL;
GO


CREATE TABLE product_info_staging(
product_id NVARCHAR(100),
product_name NVARCHAR(150),
brand_id NVARCHAR(20),
brand_name NVARCHAR(150),
size NVARCHAR(200),
variation_type NVARCHAR(200),
variation_value NVARCHAR(200),
variation_desc NVARCHAR(200),
ingredients NVARCHAR(MAX),
price_usd DECIMAL(18,2) NOT NULL,
value_price_usd DECIMAL(18,2),
sale_price_usd DECIMAL(18,2),
limited_edition bit NOT NULL,
new bit NOT NULL,
online_only bit NOT NULL,
out_of_stock bit NOT NULL,
sephora_exclusive bit NOT NULL,
highlights NVARCHAR(200),
primary_category NVARCHAR(100) NOT NULL,
secondary_category NVARCHAR(100),
tertiary_category NVARCHAR(100),
variation_count INT NOT NULL,
var_max_price DECIMAL(18,2),
var_min_price DECIMAL(18,2)
);

CREATE TABLE review_staging (
author_id NVARCHAR(20) NOT NULL,
product_id NVARCHAR(100) NOT NULL,
rating INT NOT NULL,
is_recommended INT,
tot_pos_feedback INT NOT NULL,
tot_neg_feedback INT NOT NULL,
tot_feedback INT NOT NULL,
helpfullness DECIMAL(4,2),
submission_time DATE,
skin_tone NVARCHAR(50),
eye_color NVARCHAR(50),
skin_type NVARCHAR(50),
hair_color NVARCHAR(50),
review_title NVARCHAR(4000),
review_text NVARCHAR(4000)
);

CREATE TABLE product (
product_id NVARCHAR(100) PRIMARY KEY NOT NULL,
product_name NVARCHAR(150),
brand_id NVARCHAR(20),
CONSTRAINT fk_brandID FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);


CREATE TABLE product_pricing (
product_id NVARCHAR(100) PRIMARY KEY NOT NULL,
price_usd DECIMAL(18,2) NOT NULL,
value_price_usd DECIMAL(18,2),
sale_price_usd DECIMAL(18,2),
CONSTRAINT fk_productid FOREIGN KEY (product_id) REFERENCES product(product_id)
);


CREATE TABLE product_status(
product_id NVARCHAR(100) PRIMARY KEY NOT NULL,
limited_edition bit NOT NULL,
new bit NOT NULL,
online_only bit NOT NULL,
out_of_stock bit NOT NULL,
sephora_exclusive bit NOT NULL,
FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE product_variation (
product_id NVARCHAR(100) PRIMARY KEY NOT NULL,
size NVARCHAR(200),
variation_type NVARCHAR(200),
variation_value NVARCHAR(200),
variation_desc NVARCHAR(200),
ingredients NVARCHAR(MAX),
highlights NVARCHAR(200),
primary_category NVARCHAR(100) NOT NULL,
secondary_category NVARCHAR(100),
tertiary_category NVARCHAR(100),
variation_count INT,
var_max_price DECIMAL(18,2),
var_min_price DECIMAL(18,2),
FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE brands (
brand_id NVARCHAR(20) PRIMARY KEY NOT NULL,
brand_name NVARCHAR(150)
);

CREATE TABLE author(
author_id NVARCHAR(20) PRIMARY KEY NOT NULL,
skin_tone NVARCHAR(50),
eye_color NVARCHAR(50),
skin_type NVARCHAR(50),
hair_color NVARCHAR(50)
);

CREATE TABLE author_rating(
author_id NVARCHAR(20) NOT NULL,
product_id NVARCHAR(100) NOT NULL,
rating INT NOT NULL,
is_recommended INT,
tot_pos_feedback INT NOT NULL,
tot_neg_feedback INT NOT NULL,
tot_feedback INT NOT NULL,
helpfullness DECIMAL(4,2),
submission_time DATE,
FOREIGN KEY (author_id) REFERENCES author(author_id),
FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE author_reviewtext(
author_id NVARCHAR(20) NOT NULL,
product_id NVARCHAR(100) NOT NULL,
review_title NVARCHAR(MAX),
review_text NVARCHAR(MAX),
submission_time DATE,
FOREIGN KEY (author_id) REFERENCES author(author_id),
FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE product_error(
product_id NVARCHAR(100),
product_name NVARCHAR(150),
brand_id NVARCHAR(20),
brand_name NVARCHAR(150),
size NVARCHAR(200),
variation_type NVARCHAR(200),
variation_value NVARCHAR(200),
variation_desc NVARCHAR(200),
ingredients NVARCHAR(MAX),
price_usd DECIMAL(18,2) NOT NULL,
value_price_usd DECIMAL(18,2),
sale_price_usd DECIMAL(18,2),
limited_edition bit NOT NULL,
new bit NOT NULL,
online_only bit NOT NULL,
out_of_stock bit NOT NULL,
sephora_exclusive bit NOT NULL,
highlights NVARCHAR(200),
primary_category NVARCHAR(100) NOT NULL,
secondary_category NVARCHAR(100),
tertiary_category NVARCHAR(100),
variation_count INT NOT NULL,
var_max_price DECIMAL(18,2),
var_min_price DECIMAL(18,2)
);

CREATE TABLE review_error (
author_id NVARCHAR(20) NOT NULL,
product_id NVARCHAR(100) NOT NULL,
rating INT NOT NULL,
is_recommended INT,
tot_pos_feedback INT NOT NULL,
tot_neg_feedback INT NOT NULL,
tot_feedback INT NOT NULL,
helpfullness DECIMAL(4,2),
submission_time DATE,
skin_tone NVARCHAR(50),
eye_color NVARCHAR(50),
skin_type NVARCHAR(50),
hair_color NVARCHAR(50),
review_title NVARCHAR(4000),
review_text NVARCHAR(4000)
);

CREATE INDEX product_stagingidx ON product_staging(product_id);
CREATE INDEX review_stagingidx ON review_staging(author_id);
CREATE INDEX authorR_idx ON author_rating(author_id);
CREATE INDEX authorRT_idx ON author_reviewtext(author_id);




