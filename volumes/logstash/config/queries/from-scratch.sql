SELECT * FROM ADW_edrodce.employee as Emp
inner join ADW_edrodce.employeeaddress as Addr on Emp.EmployeeID = Addr.EmployeeID;