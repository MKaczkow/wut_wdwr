# Sets
set Products;
set Machines;
set Months;

# Parameters
param TimeConstraint;  # Time constraint in hours
param WorkDaysPerMonth;  # Number of workdays in a month
param WorkHoursPerDay;  # Number of work hours per day
param PricePerSingleItem;
param ProductionProcesses{Products, Machines};  # Production process requirements for each product and machine
param MachinesAvailable{Machines};  # Available capacity for each machine
param SalesConstraints{Months, Products};  # Maximum sales quantities for each product and month

# Variables
var Production{Products, Months} >= 0;  # Amount of produced products
# var Production{Products, Months} >= 0;  # Amount of produced products
# var MachinesCapacity = MachinesAvailable * ProductionProcess[m];

# Objective
maximize TotalProfit: sum{p in Products, m in Months} (Production[p, m] * PricePerSingleItem);

# Constraints
subject to TimeConstraintLimitJan: sum{p in Products, m in Machines} ProductionProcesses[p, m] * Production[p, 1] <= TimeConstraint;
subject to TimeConstraintLimitFeb: sum{p in Products, m in Machines} ProductionProcesses[p, m] * Production[p, 2] <= TimeConstraint;
subject to TimeConstraintLimitMar: sum{p in Products, m in Machines} ProductionProcesses[p, m] * Production[p, 3] <= TimeConstraint;
subject to WorkDaysLimit: sum{p in Products, m in Months} ProductionProcesses[p, m] * Production[p, m] <= WorkDaysPerMonth * WorkHoursPerDay;
# subject to MachineCapacityLimit{m in Machines}: sum{p in Products} ProductionProcesses[p, m] * Production[p] <= MachineCapacity[m];
subject to SalesConstraintsLimit{m in Months, p in Products}: Production[p, m] <= SalesConstraints[p, m];
subject to SalesCombinationLimit {product in Products, m in Months}:
    Production[4, m] >= Production[1, m] + Production[2, m];

###########################

#param nu;  # Degrees of freedom for the t-distribution
#param x;   # Input value for the CDF or quantile function

#var cdf;
#var inv_cdf;

# Compute the CDF of the t-distribution
#s.t. compute_cdf: cdf = student_cdf(x, nu);

# Compute the inverse CDF (quantile function) of the t-distribution
#s.t. compute_inv_cdf: inv_cdf = student_inv(x, nu);

# param SalesConstraints :=
    # Styczen    200  0    100  200
    # Luty       300  100  200  200
    # Marzec     0    300  100  200;

# set Products := P1 P2 P3 P4;

# Constraint: If P1 or P2 is sold, P4 must be sold in a quantity not less than the sum of P1 and P2.
