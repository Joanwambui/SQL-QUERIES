

WITH cte_teams AS (
    SELECT home_team AS teams FROM ipl_results
    UNION
    SELECT away_team AS teams FROM ipl_results
),

	cte AS (
		SELECT dates, CONCAT(home_team, ' VS ', away_team) AS match, teams, result, row_number() over (partition by teams order by teams,dates) as id 
		FROM cte_teams t
		JOIN ipl_results r ON r.home_team = t.teams OR r.away_team = t.teams
),
	cte_diff AS (
					select *, id - ROW_NUMBER() over (partition by teams order by teams, dates) as diff
					from cte
					where result=teams
),
	cte_final AS (
					SELECT *, count(1) over (partition by teams,diff order by teams, dates range between 
					unbounded preceding and unbounded following) AS Streak
					FROM cte_diff
)

select teams, max(streak) as max_winning_streak
from cte_final
group by teams
order by max_winning_streak