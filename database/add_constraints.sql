ALTER TABLE "geo_locations" ADD CONSTRAINT "fk_geo_locations_product_id" FOREIGN KEY("product_id")
REFERENCES "products" ("product_id");

ALTER TABLE "geo_locations" ADD CONSTRAINT "fk_geo_locations_seller_id" FOREIGN KEY("seller_id")
REFERENCES "sellers" ("seller_id");

ALTER TABLE "order_items" ADD CONSTRAINT "fk_order_items_order_id" FOREIGN KEY("order_id")
REFERENCES "orders" ("order_id");

ALTER TABLE "order_items" ADD CONSTRAINT "fk_order_items_product_id" FOREIGN KEY("product_id")
REFERENCES "products" ("product_id");

ALTER TABLE "order_items" ADD CONSTRAINT "fk_order_items_seller_id" FOREIGN KEY("seller_id")
REFERENCES "sellers" ("seller_id");

ALTER TABLE "order_payments" ADD CONSTRAINT "fk_order_payments_order_id" FOREIGN KEY("order_id")
REFERENCES "orders" ("order_id");

ALTER TABLE "order_reviews" ADD CONSTRAINT "fk_order_reviews_order_id" FOREIGN KEY("order_id")
REFERENCES "orders" ("order_id");

ALTER TABLE "orders" ADD CONSTRAINT "fk_orders_customer_id" FOREIGN KEY("customer_id")
REFERENCES "customers" ("customer_id");