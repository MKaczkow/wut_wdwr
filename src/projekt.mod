# Sets
set Products;
set Machines;
set Months;

# Parameters
param production_time{Products, Machines};
param market_constraints:
           P1  P2  P3  P4 :=
"Styczen"  200 0   100 200
"Luty"     300 100 200 200
"Marzec"   0   300 100 200
;

# param market_constraints{Months, Products};

# Variables
var production{Products} >= 0;  # Production of each product
var sales{Months, Products} >= 0;  # Sales of each product in each month

# Constraints (if needed)
# Add any additional constraints as required
# 24 dni robocze * 8 godzin * 2 zmiany = 384
subject to total_production_time:
    sum {p in Products, m in Machines} production[p] * production_time[p,m] = 384;

subject to market_limit{m in Months, p in Products}:
    sales[m,p] <= market_constraints[m,p];
    
# Objective
maximize total_production: sum{p in Products} production[p];
