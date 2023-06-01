# Sets
set Products;
set Machines;

# Parameters
param production_time{Products, Machines};

# Variables
var production{Products} >= 0;  # Production of each product

# Objective
maximize total_production: sum{p in Products} production[p];

# Constraints (if needed)
# Add any additional constraints as required
