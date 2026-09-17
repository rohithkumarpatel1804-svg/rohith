select product_name,wholesale_cost
from product_inventory
order by wholesale_cost desc
limit 3;

select product_name,wholesale_cost
from product_inventory
order by wholesale_cost desc
limit 2 offset 3;