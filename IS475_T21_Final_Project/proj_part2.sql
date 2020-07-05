/* ---1--- */
select r.ReportID, 
	r.ReportDate, 
	r.CompleteDate, 
	r.Problem,
	r.PrblemDescription,
	t.TestID,
	t.TestDate
from pp2Report r
inner join pp2Test t on t.ReportID = r.ReportID
where r.ReportDate > t.TestDate

/* ---2--- */
select pt.ProblemTypeID,
	pr.PrblemDescription,
	count(pr.ReportID),
	sum(case when pr.isinjured = 1 then 1 else 0 end)
from pp2ProblemReport pr
inner join pp2ProblemReport pt on pr.ProblemTypeID = pt.ProblemTypeID
group by pt.ProblemTypeID, pt.Description

/* ---3--- */
SELECT FORMAT(ReportDate, 'MMM dd, yyyy') AS "Report Date Output",
	   pp2ProblemReport.ReportID,
	   pp2ProblemReport.ProductSerialNumber,
	   ReportCompleteDate AS "CompleteDate"
	   FORMAT(DIFFERENCE(CURDATE(),ReportDate), 'dd') AS "Days in System"
	   pp2ProblemReport.ModelNumber,
	   pp2Product.ModelName,
	   pp2Test.EmployeeID AS "Reporter Name",
	   pp2ProblemType.ProblemDescription AS "ReporterType",
	   pp2ProblemReport.ProblemTypeID
FROM pp2ProblemReport
INNER JOIN pp2Model
	ON pp2Model.ModelNumber=pp2ProblemReport.ModelNumber
INNER JOIN pp2Product
	ON pp2Product.SerialNumer = pp2Model.SerialNumber
INNER JOIN pp2Test
	ON pp2Test.ReportID = pp2ProblemReport.ReportID
INNER JOIN pp2ProblemType
	ON pp2ProblemReport.ProblemTypeID = pp2ProblemType.ProblemTypeID
WHERE MONTH(ReportDate)='Oct' AND YEAR(ReportDate) = YEAR(CURDATE())

/* ---4--- */
SELECT FORMAT(ReportDate, 'MMM dd, yyyy') AS "Report Date Output",
	   pp2ProblemReport.ReportID,
	   pp2ProblemReport.ProductSerialNumber,
	   ReportCompleteDate AS "CompleteDate"
	   FORMAT(DIFFERENCE(CURDATE(),ReportDate), 'dd') AS "Days in System"
	   pp2ProblemReport.ModelNumber,
	   pp2Product.ModelName,
	   pp2Test.EmployeeID AS "Reporter Name",
	   pp2ProblemType.ProblemDescription AS "ReporterType",
	   pp2Test.EmployeeID AS "TesterName"
	   TestComplete
FROM pp2ProblemReport
INNER JOIN pp2Model
	ON pp2Model.ModelNumber=pp2ProblemReport.ModelNumber
INNER JOIN pp2Product
	ON pp2Product.SerialNumer = pp2Model.SerialNumber
INNER JOIN pp2Test
	ON pp2Test.ReportID = pp2ProblemReport.ReportID
INNER JOIN pp2ProblemType
	ON pp2ProblemReport.ProblemTypeID = pp2ProblemType.ProblemTypeID
WHERE MONTH(ReportDate)='Oct' AND YEAR(ReportDate) = YEAR(CURDATE())

/* ---5--- */
SELECT FORMAT(ReportDate, 'MMM dd, yyyy') AS "Report Date Output",
	   pp2ProblemReport.ReportID,
	   pp2ProblemReport.ProductSerialNumber,
	   ReportCompleteDate AS "CompleteDate"
	   FORMAT(DIFFERENCE(CURDATE(),ReportDate), 'dd') AS "Days in System"
	   pp2ProblemReport.ModelNumber,
	   pp2Product.ModelName,
	   pp2Test.EmployeeID AS "Reporter Name",
	   pp2ProblemType.ProblemDescription AS "ReporterType",
	   (SELECT COUNT(pp2Test.ReportID) AS "Count of Tests"
		FROM pp2Test)
FROM pp2ProblemReport
INNER JOIN pp2Model
	ON pp2Model.ModelNumber=pp2ProblemReport.ModelNumber
INNER JOIN pp2Product
	ON pp2Product.SerialNumer = pp2Model.SerialNumber
INNER JOIN pp2Test
	ON pp2Test.ReportID = pp2ProblemReport.ReportID
INNER JOIN pp2ProblemType
	ON pp2ProblemReport.ProblemTypeID = pp2ProblemType.ProblemTypeID

/* ---6--- */
SELECT FORMAT(ReportDate, 'MMM dd, yyyy') AS "Report Date Output",
	   pp2ProblemReport.ReportID,
	   pp2ProblemReport.ProductSerialNumber,
	   ReportCompleteDate AS "CompleteDate"
	   FORMAT(DIFFERENCE(CURDATE(),ReportDate), 'dd') AS "Days in System"
	   pp2ProblemReport.ModelNumber,
	   pp2Product.ModelName,
	   pp2Test.EmployeeID AS "Reporter Name",
	   pp2ProblemType.ProblemDescription AS "ReporterType",
	   (SELECT MAX(COUNT(pp2Test.ReportID)) AS "Count of Tests"
		FROM pp2Test
		GROUP BY pp2Test.ReportID)
FROM pp2ProblemReport
INNER JOIN pp2Model
	ON pp2Model.ModelNumber=pp2ProblemReport.ModelNumber
INNER JOIN pp2Product
	ON pp2Product.SerialNumer = pp2Model.SerialNumber
INNER JOIN pp2Test
	ON pp2Test.ReportID = pp2ProblemReport.ReportID
INNER JOIN pp2ProblemType
	ON pp2ProblemReport.ProblemTypeID = pp2ProblemType.ProblemTypeID
WHERE ReportCompleteDate IS NULL

/* ---7--- */
SELECT pp2ProblemReport.ModelNumber,
	   pp2Model.Description,
	   COUNT(ModelNumber),
	   COUNT(isInjured),
	   MAX(ReportDate),
	   MIN(ReportDate),
	   COUNT(pp2Test.ReportID),
	   MAX(TestComplete),
	   MIN(TestComplete)
FROM pp2ProblemReport
INNER JOIN pp2Model
	ON pp2Model.ModelNumber = pp2ProblemReport.ModelNumber
INNER JOIN pp2Test
	ON pp2Test.ReportID = pp2ProblemReport.ReportID

/* ---8--- */
SELECT pp2ProblemReport.ModelNumber,
	   pp2Model.Description,
	   (SELECT MAX(COUNT(ModelNumber))
	    FROM pp2ProblemReport
		GROUP BY ModelNumber),
	   (SELECT MAX(COUNT(isInjured))
		FROM pp2ProblemReport
		GROUP BY isInjured),
	   MAX(ReportDate),
	   MIN(ReportDate),
	   (SELECT MAX(COUNT(ReportID))
		FROM pp2Test
		GROUP BY ReportID),
	   MAX(TestComplete),
	   MIN(TestComplete)
FROM pp2ProblemReport
INNER JOIN pp2Model
	ON pp2Model.ModelNumber = pp2ProblemReport.ModelNumber
INNER JOIN pp2Test
	ON pp2Test.ReportID = pp2ProblemReport.ReportID

/* ---9--- */
select t.ReportID,
	t.ModelNumber,
	m.Name,
	t.TestID,
	t.TestDescription,
	pr.ReportDate,
	pt.ProblemDecription,
from pp2Test t, pp2ProblemReport pr pp2ProblemType pt pp2Model m
where pt.ProblemDescription = 'battery'
sort by t.ReportID

/* ---10--- */
select m.ModelNumber,
	m.Name,
	m.Description,
	m.StandardPrice
from pp2Model m
inner join pp2Model pp2Product on m.ModelNumber = pp2Product.ModelNumber
where pp2ProblemType.ProblemTypeID is null