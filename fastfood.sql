#Average nutritional values for all products in each restaurant

SELECT
    restaurant,
    AVG(calories) AS avg_calories,
    AVG(total_fat) AS avg_total_fat,
    AVG(protein) AS avg_protein
FROM
    fastfood.fastfood
GROUP BY
    restaurant;

#Products with the lowest caloric content from each restaurant

SELECT
    f.restaurant,
    f.item,
    f.calories
FROM
    fastfood.fastfood f
JOIN (
    SELECT
        restaurant,
        MIN(calories) AS min_calories
    FROM
        fastfood.fastfood
    GROUP BY
        restaurant
) AS min_calories_per_restaurant
ON
    f.restaurant = min_calories_per_restaurant.restaurant
    AND f.calories = min_calories_per_restaurant.min_calories;

SELECT
    restaurant,
    item,
    protein
FROM
    fastfood.fastfood
ORDER BY
    protein DESC
LIMIT 1;

#Products with the highest protein content for each restaurant

SELECT
    restaurant,
    item,
    protein
FROM
    fastfood.fastfood
WHERE
    (restaurant, protein) IN (
        SELECT
            restaurant,
            MAX(protein) AS max_protein
        FROM
            fastfood.fastfood
        GROUP BY
            restaurant
    );
    
# Products with total fat content below 10 grams in each restaurant  

WITH LowFatItems AS (
    SELECT
        restaurant,
        item,
        total_fat
    FROM
        fastfood.fastfood
    WHERE
        total_fat <= 10
)
SELECT
    restaurant,
    item,
    total_fat
FROM
    LowFatItems;
    
#Products with no add sugar

SELECT
restaurant,
item,
sugar
FROM
    fastfood.fastfood
WHERE
    sugar = 0;

#Products with calorie content below 300

WITH LowCalorieItems AS (
    SELECT
        restaurant,
        item,
        calories
    FROM
        fastfood.fastfood
    WHERE
        calories <= 300
)
SELECT
    restaurant,
    item,
    calories
FROM
    LowCalorieItems;

#Products containing more than 20 grams of protein

WITH HighProteinItems AS (
    SELECT
        restaurant,
        item,
        protein
    FROM
        fastfood.fastfood
    WHERE
        protein >= 20 
)
SELECT
    restaurant,
    item,
    protein
FROM
    HighProteinItems;

#Products with fiber content above 5 grams

WITH HighFiberItems AS (
    SELECT
        restaurant,
        item,
        fiber
    FROM
        fastfood.fastfood
    WHERE
        fiber >= 5 
)
SELECT
    restaurant,
    item,
    fiber
FROM
    HighFiberItems;
    
#Products containing vitamins and minerals

WITH HighVitaminMineralItems AS (
    SELECT
        restaurant,
        item,
        vit_a,
        vit_c,
        calcium
    FROM
        fastfood.fastfood
    WHERE
        vit_a >= 10 AND vit_c >= 10 AND calcium >= 10
)
SELECT
    restaurant,
    item,
    vit_a,
    vit_c,
    calcium
FROM
    HighVitaminMineralItems;
    
#Products with low cholesterol and sodium content
    
WITH LowCholesterolSodiumItems AS (
    SELECT
        restaurant,
        item,
        cholesterol,
        sodium
    FROM
        fastfood.fastfood
    WHERE
        cholesterol <= 20 AND sodium <= 500 
)
SELECT
    restaurant,
    item,
    cholesterol,
    sodium
FROM
    LowCholesterolSodiumItems;
