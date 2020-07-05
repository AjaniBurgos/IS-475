IF object_id ('pp2Buyer') is not null
    drop table pp2Buyer;

IF object_id ('pp2Model') is not null
    drop table pp2Model;

IF object_id ('pp2Product') is not null
    drop table pp2Product;

IF object_id ('pp2Return') is not null
    drop table pp2Return;

IF object_id ('pp2Review') is not null
    drop table pp2Review;

IF object_id ('pp2Feature') is not null
    drop table pp2Feature;

IF object_id ('pp2Registration') is not null
    drop table pp2Registration;

IF object_id ('pp2RegistrationFeature') is not null
    drop table pp2Registration;

IF object_id ('pp2Question') is not null
    drop table pp2Question;

IF object_id ('pp2Answer') is not null
    drop table pp2Answer;

IF object_id ('pp2Survey') is not null
    drop table pp2Survey;

IF object_id ('pp2SurveyQuestionAnswer') is not null
    drop table pp2SurveyQuestionAnswer;

IF object_id ('pp2ProblemType') is not null
    drop table pp2ProblemType;
	
IF object_id ('pp2ProblemReport') is not null
    drop table pp2ProblemReport;
	
IF object_id ('pp2Test') is not null
    drop table pp2Test;

create table pp2Feature
(
	FeatureID	int not null,
	Description varchar(200) not null,
	primary key (FeatureID)
);

create table pp2Buyer
(
	BuyerID		int not null,
	LastName	varchar(15) not null,
	FirstName	varchar(15) not null,
	Address		varchar(50) null,
	City		varchar(50) null,
	State		varchar(30) null,
	Zip			varchar(5) null,
	Email		varchar(50) null,
	Phone		varchar(15) not null,
	primary key (BuyerID)
);

create table pp2Model
(
	ModelNumber		varchar(10) not null,
	Name			varchar(25) not null,
	Description		varchar(200),
	StandardPrice	money,
	primary key (ModelNumber)
);

create table pp2Product
(
	SerialNumber	varchar(15) not null,
	ModelNumber		varchar(10) not null,
	primary key (SerialNumber),
	foreign key (ModelNumber) references pp2Model(ModelNumber)
);

create table pp2Return
(
	ReturnID		int not null,
	BuyerID			int not null,
	SerialNumber	varchar(15),
	DatePurchased	varchar(25),
	DateReturned	varchar(25),
	Reason			varchar(200),
	Comment			varchar(200),
	primary key (ReturnID),
	foreign key (BuyerID) references pp2Buyer(BuyerID),
	foreign key (SerialNumber) references pp2Product(SerialNumber)
);

create table pp2Review
(
	ReviewNum		int not null,
	ModelNumber		varchar(10) not null,
	ReviewDate		varchar(25) not null,
	ReviewSource	varchar(200) not null,
	ReviewText		varchar(200),
	primary key(ReviewNum),
	foreign key(ModelNumber) references pp2Model(ModelNumber),
	PersonType		varchar(1) null
);

create table pp2Registration
(
	RegistrationID		int not null,
	UserAge				int not null,
	UserGender			char(1),
	BuyerID				int not null,
	SerialNumber		varchar(15) not null,
	Distributor			varchar(200) not null,
	Price				money not null,
	LearnedAboutFrom	varchar(200) not null,
	RelationToUser		varchar(200) not null,
	WillBuySimilarToys	varchar(10) not null,
	ReasonForPurchase	varchar(200),
	primary key (RegistrationID),
	foreign key (BuyerID) references pp2Buyer(BuyerID),
	foreign key (SerialNumber) references pp2Product(SerialNumber)
);

create table pp2RegistrationFeature
(
	RegistrationID	int not null,
	FeatureID		int not null,
	primary key (RegistrationID, FeatureID),
	foreign key (RegistrationID) references pp2Registration(RegistrationID),
	foreign key (FeatureID) references pp2Feature(FeatureID)
);

create table pp2Question
(
	QuestionID	int not null,
	Description	varchar(200),
	primary key (QuestionID)
);

create table pp2Answer
(
	AnswerID int not null,
	Description varchar(200),
	primary key (AnswerID)
);

create table pp2Survey
(
	SurveyID int not null,
	ModelNumber varchar(10) not null,
	date varchar(25) not null,
	primary key(SurveyID),
	foreign key (ModelNumber) references pp2Model(ModelNumber)
);

create table pp2SurveyQuestionAnswer
(
	SurveyID int not null,
	QuestionID int not null,
	AnswerID int not null,
	primary key (SurveyID, QuestionID, AnswerID),
	foreign key (SurveyID) references pp2Survey(SurveyID),
	foreign key (QuestionID) references pp2Question(QuestionID),
	foreign key (AnswerID) references pp2Answer(AnswerID)
);

create table pp2ProblemType
(
	ProblemTypeID int not null,
	ProblemDescription varchar(200),
	primary key (ProblemTypeID)
);

create table pp2ProblemReport
(
	ReportID int not null,
	ReturnID int not null,
	ModelNumber varchar(10) not null,
	ReportDate varchar(25) not null,
	ReportCompleteDate varchar(25) not null,
	isReturned	varchar(5) not null,
	ComplaintMethod varchar(200) not null,
	ProblemTypeID	int not null,
	isInjured		varchar(5),
	InjuryDescription	varchar(200),
	primary key (ReportID),
	foreign key (ReturnID) references pp2Return(ReturnID),
	foreign key (ModelNumber) references pp2Model(ModelNumber),
	foreign key (ProblemTypeID) references pp2ProblemType(ProblemTypeID)
);

create table pp2Test
(
	TestID int not null,
	ReportID int not null,
	ModelNumber varchar(10) not null,
	EmployeeID int not null,
	TestType varchar(30) not null,
	TestDescription varchar(200) not null,
	TestResults	varchar(200) not null,
	RecommendedResolution varchar(200) not null,
	TestComplete varchar(10) not null,
	primary key (TestID),
	foreign key (ReportID) references pp2ProblemReport,
	foreign key (ModelNumber) references pp2Model
);