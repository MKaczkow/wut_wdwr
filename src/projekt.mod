# Sets
set Products;
set Machines;

# Parameters
param TimeConstraint;  # Time constraint in hours
param WorkDaysPerMonth;  # Number of workdays in a month
param WorkHoursPerDay;  # Number of work hours per day

param ProductionProcesses{Products, Machines};  # Production process requirements for each product and machine
param MachineCapacity{Machines};  # Available capacity for each machine

# Variables
var Production{Products} >= 0;  # Amount of produced products

# Objective
maximize TotalProduction: sum{p in Products} Production[p];

# Constraints
subject to TimeConstraintLimit: sum{p in Products, m in Machines} ProductionProcesses[p, m] * Production[p] <= TimeConstraint;
subject to WorkDaysLimit: sum{p in Products, m in Machines} ProductionProcesses[p, m] * Production[p] <= WorkDaysPerMonth * WorkHoursPerDay;
subject to MachineCapacityLimit{m in Machines}: sum{p in Products} ProductionProcesses[p, m] * Production[p] <= MachineCapacity[m];
