# Sets
set Products;
set Machines;
set Months;

# Parameters
param HoursPerShift;
param ShiftsPerDay;
param DaysPerMonth;
param TimeConstraint = HoursPerShift * ShiftsPerDay * DaysPerMonth;

param PricePerSingleItem;
param ItemPriceExpectedValue{Products};

param ProductionProcesses{Products, Machines}; 
param MachinesCapacity{Machines}; 
param SalesConstraints{Months, Products}; 

# Variables
var Production{Products, Months} >= 0;  


# Objective
maximize TotalProfit: 
	sum{prod in Products, mont in Months} 
		(Production[prod, mont] * ItemPriceExpectedValue[prod]);

# Constraints
subject to 
	TimeConstraintLimit {prod in Products, mach in Machines, mont in Months}: 
		ProductionProcesses[prod, mach] * Production[prod, mont] * MachinesCapacity[mach] <= TimeConstraint;

subject to 
	SalesContraintLimit {prod in Products, mont in Months}:
		Production[prod, mont] <= SalesConstraints[mont, prod]; 

subject to 
	P4ObligatoryIfP1OrP2Limit {mont in Months}:
		Production['P4', mont] >= Production['P1', mont] + Production['P2', mont];
		  
		