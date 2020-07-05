--1
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

--2
select pt.ProblemTypeID,
	pr.PrblemDescription,
	count(pr.ReportID),
	sum(case when pr.isinjured = 1 then 1 else 0 end)
from pp2ProblemReport pr
inner join pp2ProblemReport pt on pr.ProblemTypeID = pt.ProblemTypeID
group by pt.ProblemTypeID, pt.Description

--9
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

--10
select m.ModelNumber,
	m.Name,
	m.Description,
	m.StandardPrice
from pp2Model m
inner join pp2Model pp2Product on m.ModelNumber = pp2Product.ModelNumber
where pp2ProblemType.ProblemTypeID is null



