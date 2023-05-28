set MONTHS;
set PRODUCTS;
set MACHINES;

param production_time{PRODUCTS, MACHINES};
param demand{MONTHS, PRODUCTS};

param storage_capacity;
param storage_cost;

param min_inventory{PRODUCTS};

var Production{MONTHS, PRODUCTS, MACHINES} >= 0;
var Storage{MONTHS, PRODUCTS} >= 0;

maximize Total_Profit:
    sum {m in MONTHS, p in PRODUCTS} storage_cost * Storage[m, p];

subject to Production_Constraint {m in MONTHS, p in PRODUCTS}:
    sum {i in MACHINES} production_time[p, i] * Production[m, p, i] >= demand[m, p];

subject to Storage_Constraint {m in MONTHS, p in PRODUCTS}:
    Storage[m, p] <= storage_capacity;

