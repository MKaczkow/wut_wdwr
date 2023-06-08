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
var Production{Products} >= 0;  # Amount of produced products
# var MachinesCapacity = MachinesAvailable * ProductionProcess[m];

# Objective
maximize TotalProfit: sum{p in Products} (Production[p] * PricePerSingleItem);

# Constraints
subject to TimeConstraintLimit: sum{p in Products, m in Machines} ProductionProcesses[p, m] * Production[p] <= TimeConstraint;
subject to WorkDaysLimit: sum{p in Products, m in Machines} ProductionProcesses[p, m] * Production[p] <= WorkDaysPerMonth * WorkHoursPerDay;
# subject to MachineCapacityLimit{m in Machines}: sum{p in Products} ProductionProcesses[p, m] * Production[p] <= MachineCapacity[m];
subject to SalesConstraintsLimit{m in Months, p in Products}: Production[p] <= SalesConstraints[m, p];

