CREATE TABLE "customers" (
    "customer_id" text   NOT NULL,
    "customer_unique_id" text   NOT NULL,
    "customer_zip_code_prefix" int   NOT NULL,
    "customer_city" text   NOT NULL,
    "customer_state" char(2)   NOT NULL,
    "cust_Region" text   NOT NULL,
    CONSTRAINT "pk_customers" PRIMARY KEY (
        "customer_id"
     )
);

CREATE TABLE "geo_locations" (
    "order_id" text   NOT NULL,
    "order_item_id" int   NOT NULL,
    "product_id" text   NOT NULL,
    "seller_id" text   NOT NULL,
    "shipping_limit_date" timestamp   NOT NULL,
    "price" numeric   NOT NULL,
    "freight_value" numeric   NOT NULL
);

CREATE TABLE "order_items" (
    "order_id" text   NOT NULL,
    "order_item_id" int   NOT NULL,
    "product_id" text   NOT NULL,
    "seller_id" text   NOT NULL,
    "shipping_limit" timestamp   NOT NULL,
    "price" numeric   NOT NULL,
    "freight_value" numeric   NOT NULL
);

CREATE TABLE "order_payments" (
    "order_id" text   NOT NULL,
    "payment_sequential" int   NOT NULL,
    "payment_type" text   NOT NULL,
    "payment_intallments" int   NOT NULL,
    "payment_value" numeric   NOT NULL
);

CREATE TABLE "order_reviews" (
    "review_id" text   NOT NULL,
    "order_id" text   NOT NULL,
    "review_score" int   NOT NULL,
    "review_comment_title" text,
    "review_comment_message" text,
    "review_creation_date" timestamp   NOT NULL,
    "review_answer_timestamp" timestamp   NOT NULL,
    CONSTRAINT "pk_order_reviews" PRIMARY KEY (
        "review_id"
     )
);

CREATE TABLE "orders" (
    "order_id" text   NOT NULL,
    "customer_id" text   NOT NULL,
    "order_status" text   NOT NULL,
    "order_purchase_timestamp" timestamp   NOT NULL,
    "order_approved_at" timestamp   NOT NULL,
    "order_delivered_carrier_date" timestamp   NOT NULL,
    "order_delivered_customer_date" timestamp   NOT NULL,
    "order_estimated_delivery_date" timestamp   NOT NULL,
    CONSTRAINT "pk_orders" PRIMARY KEY (
        "order_id"
     )
);

CREATE TABLE "product_categories" (
    "product_category_name" text   NOT NULL,
    "product_category_name_english" text   NOT NULL,
    "product_category" text   NOT NULL
);

CREATE TABLE "products" (
    "product_id" text   NOT NULL,
    "product_category_name" text   NOT NULL,
    "product_name_length" int   NOT NULL,
    "product_description_length" int   NOT NULL,
    "product_photos_qty" int   NOT NULL,
    "product_weight_g" int   NOT NULL,
    "product_length_cm" int   NOT NULL,
    "product_height_cm" int   NOT NULL,
    "product_width_cm" int   NOT NULL,
    CONSTRAINT "pk_products" PRIMARY KEY (
        "product_id"
     )
);

CREATE TABLE "sellers" (
    "seller_id" text   NOT NULL,
    "seller_zip_code_prefix" int   NOT NULL,
    "seller_city" text   NOT NULL,
    "seller_state" char(2)   NOT NULL,
    CONSTRAINT "pk_sellers" PRIMARY KEY (
        "seller_id"
     )
);