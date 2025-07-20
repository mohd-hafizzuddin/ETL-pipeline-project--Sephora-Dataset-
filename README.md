# ETL-pipeline-project--Sephora-Dataset-

## Data Preparation
### Data Source: [Kaggle Dataset](https://www.kaggle.com/datasets/nadyinky/sephora-products-and-skincare-reviews)


**File Format:** CSV

**Column info**

### Data Cleaning Process (Using Microsoft Excel Power Query)
1.	Replace the author_id data type from whole number data type into text data type.
2.	Use the replace feature to replace #NAME? from the review_text column into blank.
3.	Use the replace feature to replace #NAME? from the review_title column into blank.
4.	Remove product_name,brand_name and price_usd column.
5.	Using custom new column featured, removed unnecessary character from review_title, truncate the character to only 4000 character and named the column as title. 
6.	Using custom new column featured, removed unnecessary character from review_text, truncate the character to only 4000 character and named the column as text. 
7.	Remove the original column for review_tile and review_text.
8.	Perform all the above step for other 4 csv file.

Product_info table information.

## Original table structure

### product_info
| Column Name           | Data Type      | Description |
|-----------------------|----------------|-------------|
| product_id            | nvarchar(100)  | The unique identifier for the product from the site |
| product_name          | nvarchar(150)  | The full name of the product |
| brand_id              | nvarchar(20)   | The unique identifier for the product brand from the site |
| brand_name            | nvarchar(150)  | The full name of the product brand |
| size                  | nvarchar(200)  | The size of the product, which may be in oz, ml, g, packs, or other units depending on the product type |
| variation_type        | nvarchar(200)  | The type of variation parameter for the product (e.g. Size, Color) |
| variation_value       | nvarchar(200)  | The specific value of the variation parameter for the product (e.g. 100 mL, Golden Sand) |
| variation_desc        | nvarchar(200)  | A description of the variation parameter for the product (e.g. tone for fairest skin) |
| ingredients           | nvarchar(MAX)  | A list of ingredients included in the product, for example: [‘Product variation 1:’, ‘Water, Glycerin’, ‘Product variation 2:’, ‘Talc, Mica’] or if no variations [‘Water, Glycerin’] |
| price_usd             | decimal(18, 2) | The price of the product in US dollars |
| value_price_usd       | decimal(18, 2) | The potential cost savings of the product, presented on the site next to the regular price |
| sale_price_usd        | decimal(18, 2) | The sale price of the product in US dollars |
| limited_edition       | Bit            | Indicates whether the product is a limited edition or not (1-true, 0-false) |
| new                   | Bit            | Indicates whether the product is new or not (1-true, 0-false) |
| online_only           | Bit            | Indicates whether the product is only sold online or not (1-true, 0-false) |
| out_of_stock          | Bit            | Indicates whether the product is currently out of stock or not (1 if true, 0 if false) |
| sephora_exclusive     | Bit            | Indicates whether the product is exclusive to Sephora or not (1 if true, 0 if false) |
| highlights            | nvarchar(200)  | A list of tags or features that highlight the product's attributes (e.g. [‘Vegan’, ‘Matte Finish’]) |
| primary_category      | nvarchar(100)  | First category in the breadcrumb section |
| secondary_category    | nvarchar(100)  | Second category in the breadcrumb section |
| tertiary_category     | nvarchar(100)  | Third category in the breadcrumb section |
| child_count           | Int            | The number of variations of the product available |
| child_max_price       | decimal(18, 2) | The highest price among the variations of the product |
| child_min_price       | decimal(18, 2) | The lowest price among the variations of the product |

## Review table information.

### reviews1
| Column Name               | Data Type       | Description |
|---------------------------|-----------------|-------------|
| author_id                 | nvarchar(20)    | The unique identifier for the author of the review on the website |
| rating                    | int             | The rating given by the author for the product on a scale of 1 to 5 |
| is_recommended            | int             | Indicates if the author recommends the product or not (1-true, 0-false) |
| helpfulness               | decimal(4, 2)   | The ratio of all ratings to positive ratings for the review: helpfulness = total_pos_feedback_count / total_feedback_count |
| total_feedback_count      | Int             | Total number of feedback (positive and negative ratings) left by users for the review |
| total_neg_feedback_count  | Int             | The number of users who gave a negative rating for the review |
| total_pos_feedback_count  | Int             | The number of users who gave a positive rating for the review |
| submission_time           | date            | Date the review was posted on the website in the 'yyyy-mm-dd' format |
| review_text               | nvarchar(4000)  | The main text of the review written by the author |
| review_title              | nvarchar(4000)  | The title of the review written by the author |
| skin_tone                 | nvarchar(50)    | Author's skin tone (e.g. fair, tan, etc.) |
| eye_color                 | nvarchar(50)    | Author's eye color (e.g. brown, green, etc.) |
| skin_type                 | nvarchar(50)    | Author's skin type (e.g. combination, oily, etc.) |
| hair_color                | nvarchar(50)    | Author's hair color (e.g. brown, auburn, etc.) |
| product_id                | nvarchar(100)   | The unique identifier for the product on the website |




## Data Normalization
1.	Avoid data redundancy.
2.	Maintaining data integrity.


**Normalize Table**

### product
| Column Name | Data Type      | Description                              |
|-------------|----------------|------------------------------------------|
| product_id  | nvarchar(100)  | Primary key, unique identifier for each product |
| product_name| nvarchar(150)  | Name of the product                      |
| brand_id    | nvarchar(20)   | Foreign key referencing brands(brand_id) |

### brands
| Column Name | Data Type      | Description                              |
|-------------|----------------|------------------------------------------|
| brand_id    | nvarchar(20)   | Primary key, unique identifier for each brand |
| brand_name  | nvarchar(150)  | Name of the brand                        |

### product_variation
| Column Name         | Data Type       | Description                              |
|---------------------|-----------------|------------------------------------------|
| product_id          | nvarchar(100)   | Composite PK/FK referencing product(product_id) |
| size                | nvarchar(200)   | Size of the product variation            |
| variation_type      | nvarchar(200)   | Type of variation (e.g., color, size)    |
| variation_value     | nvarchar(200)   | Specific value (e.g., 100mL, Golden Sand)|
| variation_desc      | nvarchar(200)   | Description of the variation             |
| ingredients         | nvarchar(MAX)   | List of ingredients used                 |
| highlights          | nvarchar(200)   | Tags/features highlighting attributes    |
| primary_category    | nvarchar(100)   | Main category of the product             |
| secondary_category  | nvarchar(100)   | Secondary category of the product        |
| tertiary_category   | nvarchar(100)   | Tertiary category of the product         |
| variation_count     | int             | Number of variations available           |
| var_max_price       | decimal(18,2)   | Maximum price among variations           |
| var_min_price       | decimal(18,2)   | Minimum price among variations           |

### product_status
| Column Name        | Data Type      | Description                              |
|--------------------|---------------|------------------------------------------|
| product_id         | nvarchar(100) | PK/FK referencing product(product_id)    |
| limited_edition    | bit           | 1=true (limited edition), 0=false        |
| new                | bit           | 1=true (new product), 0=false            |
| online_only        | bit           | 1=true (online only), 0=false            |
| out_of_stock       | bit           | 1=true (out of stock), 0=false           |
| sephora_exclusive  | bit           | 1=true (Sephora exclusive), 0=false      |

### product_pricing
| Column Name      | Data Type      | Description                              |
|------------------|---------------|------------------------------------------|
| product_id       | nvarchar(100) | PK/FK referencing product(product_id)    |
| price_usd        | decimal(18,2) | Price in US dollars                      |
| value_price_usd  | decimal(18,2) | Potential cost savings                   |
| sale_price_usd   | decimal(18,2) | Sale price in US dollars                 |

### author
| Column Name | Data Type     | Description                              |
|-------------|---------------|------------------------------------------|
| author_id   | nvarchar(20)  | Primary key, unique author identifier    |
| skin_tone   | nvarchar(50)  | Author's skin tone                       |
| eye_color   | nvarchar(50)  | Author's eye color                       |
| skin_type   | nvarchar(50)  | Author's skin type                       |
| hair_color  | nvarchar(50)  | Author's hair color                      |

### author_reviewtext
| Column Name      | Data Type       | Description                              |
|------------------|-----------------|------------------------------------------|
| author_id        | nvarchar(20)    | FK referencing author(author_id)         |
| product_id       | nvarchar(100)   | FK referencing product(product_id)       |
| review_title     | nvarchar(MAX)   | Title of the review                      |
| review_text      | nvarchar(MAX)   | Text content of the review               |
| submission_time  | date            | Date when review was submitted           |

### author_rating
| Column Name               | Data Type      | Description                              |
|---------------------------|----------------|------------------------------------------|
| author_id                 | nvarchar(20)   | FK referencing author(author_id)         |
| product_id                | nvarchar(100)  | FK referencing product(product_id)       |
| rating                    | int            | Rating (1-5 scale)                       |
| is_recommended            | int            | 1=true (recommended), 0=false            |
| total_pos_feedback_count  | int            | Count of positive feedback               |
| total_neg_feedback_count  | int            | Count of negative feedback               |
| total_feedback_count      | int            | Total feedback count                     |
| helpfulness               | decimal(4,2)   | Helpfulness ratio (pos/total feedback)   |
| submission_time           | date           | Date when rating was submitted           |


## ETL Process

### Staging Tables Created:
1. `brands_staging`
2. `product_staging`
3. `product_pricing_staging`
4. `product_status_staging`
5. `product_variation_staging`
6. `product_info_staging`
7. `review_staging`





Create connection.
Flat file connection
OLE DB connection









## ETL Pipeline Implementation

### Project Overview
Created an SSIS project in Microsoft Visual Studio and SSMS to automate the normalization of 2 main tables into several optimized tables. This normalization:
- Maintains data integrity
- Prevents potential data loss
- Includes primary key assignments for normalized tables
 
### ETL Pipeline

![etl pipeline](https://github.com/user-attachments/assets/860131ed-3b90-440b-9864-0110eef82135)



### ETL Process Steps

1. **Execute SQL Task (Clear Staging Tables)**
   - Truncates all 6 staging tables before data loading
   - Ensures clean slate for each ETL run

![clear staging](https://github.com/user-attachments/assets/bba7cc89-1693-43d3-8c72-322fb0c15679)

SQL Command

``` sql
TRUNCATE TABLE review_staging;
TRUNCATE TABLE product_staging;
TRUNCATE TABLE brand_staging;
TRUNCATE TABLE product_pricing_staging;
TRUNCATE TABLE product_variation_staging;
TRUNCATE TABLE product_status_staging;

```
2. **Data Flow Task: product_staging**
•	Flat File Source > Data Conversion (ingredient column from dt_text to dt_ntext) > ole db destination (into product_staging table in SSMS)
•	Any data error from Flat file source > Flat File Destination (product_error)
 
![product_staging](https://github.com/user-attachments/assets/d24327a3-2fc8-4d05-8435-65d6cd21195c)

3. **Data Flow Task: DFT_mainproduct1**
•	OLE DB Source > lookup(lookupBrand) > no match output > sort(no_matchB) > ole destination (Brands table)
•	As for the match output > sort(matchB) > ole destination (brands_staging table)
•	Sort is use to remove duplicate.

![DFT_mainproduct1](https://github.com/user-attachments/assets/5a8b92ca-039a-4ade-a125-115810755fa6)

4. **Data Flow Task: DFT_mainproduct2**
•	OLE DB Source > lookup(lookupProduct) > no match output > sort(no_matchP) > ole destination (product table)
•	As for the match output > sort(matchP) > ole destination (product_staging table)
•	Sort is use to remove duplicate.

![DFT_mainproduct2](https://github.com/user-attachments/assets/1c0ade07-6cae-4297-b248-f5f88ee84a13)

5. **Data Flow Task: DFT_product_subtable**
   
•	OLE DB Source > multicast > lookup(lookupPP) > no match output > sort(no_matchPP) > ole destination (product_pricing table)
•	As for the match output > sort(matchPP) > ole destination (product_pricing_staging table)
•	Sort is use to remove duplicate

•	Multicast > lookup(lookupPS) > no match output > sort(no_matchPS) > ole destination (product_status table)
•	As for the match output > sort(matchPS) > ole destination (product_status_staging table)
•	Sort is use to remove duplicate

•	Multicast > lookup(lookupPV) > no match output > sort(no_matchPV) > ole destination (product_variation table)
•	As for the match output > sort(matchPV) > ole destination (product_variation_staging table)
•	Sort is use to remove duplicate

  ![DFT product_subtable](https://github.com/user-attachments/assets/8b107c47-3b8e-488a-8645-3ae1b5e6cd23)
  
6. **Execute SQL Task (Update Main Tables)**
- Updates target tables from staging tables
- Strategy: Uses staging data to update main tables when product_id matches but data has changed

![UPDATE TABLE](https://github.com/user-attachments/assets/17c05380-624d-457d-ae3a-e88f9e84c41f)

SQL Command

``` sql
UPDATE p
SET p.product_name = ps.product_name
FROM product AS p
INNER JOIN product_staging AS ps
ON p.product_id = ps.product_id;

UPDATE b
SET b.brand_name = bs.brand_name
FROM brands AS b
INNER JOIN brand_staging AS bs
ON b.brand_id = bs.brand_id;

UPDATE pp
SET pp.price_usd = pps.price_usd,
    pp.value_price_usd = pps.value_price_usd,
    pp.sale_price_usd = pps.sale_price_usd
FROM product_pricing AS pp
INNER JOIN product_pricing_staging AS pps
ON pp.product_id = pps.product_id;

UPDATE pSta
SET pSta.limited_edition = pStaS.limited_edition,
    pSta.new = pStaS.new,
    pSta.online_only = pStaS.online_only,
    pSta.out_of_stock = pStaS.out_of_stock,
    pSta.sephora_exclusive = pStaS.sephora_exclusive
FROM product_status AS pSta
INNER JOIN product_status_staging AS pStaS
ON pSta.product_id = pStaS.product_id;


UPDATE pv
SET pv.size = pvs.size,
    pv.variation_type = pvs.variation_type,
    pv.variation_value = pvs.variation_value,
    pv.variation_desc = pvs.variation_desc,
    pv.ingredients = pvs.ingredients,
    pv.highlights = pvs.highlights,
    pv.primary_category = pvs.primary_category,
    pv.secondary_category = pvs.secondary_category,
    pv.tertiary_category = pvs.tertiary_category,
    pv.variation_count = pvs.variation_count,
    pv.var_max_price = pvs.var_max_price,
    pv.var_min_price = pvs.var_min_price
FROM product_variation AS pv
INNER JOIN product_variation_staging AS pvs
ON pv.product_id = pvs.product_id;

```

7. **Data Flow Task: review_staging**
•	Flat file source > Ole DB Destination (review_staging table)
 
![review staging](https://github.com/user-attachments/assets/e47e5232-9747-427b-9d69-d09ab54f8f25)

8. **Execute SQL Task: Author Processing**
- Uses `MERGE INTO` statement to:
  - Handle inserts and updates
  - Perform data normalization
  - Eliminate duplicates

 ![DFT_author](https://github.com/user-attachments/assets/0e8dd0e5-b399-4f69-b431-7bd1b0cec331)

 SQL Command

``` sql
WITH dup AS (
	SELECT author_id,skin_tone,skin_type, hair_color, eye_color,submission_time,
                              ROW_NUMBER() OVER (PARTITION BY author_id ORDER BY submission_time DESC) AS rn
                FROM review_staging)

MERGE INTO author AS a
USING ( SELECT author_id,skin_tone,skin_type,hair_color,eye_color FROM dup WHERE rn = 1) AS adup
ON a.author_id = adup.author_id

WHEN MATCHED THEN
UPDATE 
	SET a.skin_tone = adup.skin_tone,
                        a.skin_type = adup.skin_type,
                        a.hair_color = adup.hair_color,
                        a.eye_color = adup.eye_color

WHEN NOT MATCHED BY TARGET THEN
INSERT (author_id,skin_tone,skin_type, hair_color, eye_color)
VALUES(adup.author_id,adup.skin_tone,adup.skin_type,adup.hair_color,adup.eye_color);
```

9. **Execute SQL Task: Author Rating Processing**
- Uses Common Table Expression (CTE) to:
  - Filter duplicates
  - Insert clean data into author_rating table
 
![DFT_author_rating](https://github.com/user-attachments/assets/b6c389aa-aaa8-439b-91f7-d2608b0e9dfd)

 SQL Command

``` sql
WITH dup AS (
	SELECT author_id,product_id,rating,is_recommended,tot_pos_feedback,tot_neg_feedback,tot_feedback,helpfullness,submission_time,
                              ROW_NUMBER() OVER (PARTITION BY author_id,product_id,rating,is_recommended,tot_pos_feedback,tot_neg_feedback,tot_feedback,helpfullness,submission_time ORDER BY (SELECT NULL)) AS rn
                FROM review_staging)

INSERT INTO author_rating
SELECT author_id,product_id,rating,is_recommended,tot_pos_feedback,tot_neg_feedback,tot_feedback,helpfullness,submission_time
FROM dup WHERE rn = 1 AND NOT EXISTS (SELECT 1 FROM author_rating AS ar
    					WHERE ar.author_id = dup.author_id
      					AND ar.product_id = dup.product_id
      					AND ar.rating = dup.rating
      					AND ar.is_recommended = dup.is_recommended
      					AND ar.tot_pos_feedback = dup.tot_pos_feedback
      					AND ar.tot_neg_feedback = dup.tot_neg_feedback
      					AND ar.tot_feedback = dup.tot_feedback
      					AND ar.helpfullness = dup.helpfullness
      					AND ar.submission_time = dup.submission_time);
```

10. **Execute SQL Task: Author Review Text Processing**
 - Uses direct SQL commands instead of SSIS components because:
   - Better performance with large datasets
   - More efficient duplicate handling
 
![author_reviewtext](https://github.com/user-attachments/assets/bc7ecad3-fc27-40db-9214-1870381bd435)

 SQL Command

``` sql
WITH dup AS
(
SELECT author_id,product_id,review_title,review_text,submission_time,
        ROW_NUMBER() OVER (PARTITION BY author_id,product_id,review_title,review_text,submission_time ORDER BY (SELECT NULL)) AS rn
 FROM review_staging)

INSERT INTO author_reviewtext
SELECT author_id,product_id,review_title,review_text,submission_time 
FROM dup WHERE rn = 1 AND NOT EXISTS (SELECT 1 FROM author_reviewtext AS art
    					WHERE art.author_id = dup.author_id
      					AND art.product_id = dup.product_id
      					AND art.review_title = dup.review_title
      					AND art.review_text = dup.review_text
      					AND art.submission_time = dup.submission_time
      					);
```

### Key Design Decisions
- **Staging Tables**: Used for interim storage and data validation
- **Lookup Patterns**: Identify new vs. existing records
- **Sort Components**: Ensure duplicate elimination
- **SQL vs SSIS**: Used SQL for complex operations on large datasets
- **Error Handling**: Separate paths for error records


What next??
Analyze the data using power bi. Stay tune for the update.

