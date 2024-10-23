SELECT Department, SurveyDate, 
       AVG(EngagementScore) OVER (PARTITION BY Department ORDER BY SurveyDate ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) AS MovingAvgEngagement
FROM EmployeeEngagementSurveys;
