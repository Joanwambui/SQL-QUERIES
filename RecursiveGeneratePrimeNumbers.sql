HackerRank Home
|
Prepare
Certify
Compete
Apply
Search


2
|
Switch to..

PrepareSQLAlternative QueriesPrint Prime Numbers
Print Prime Numbers
50 more points to get your next star!
Rank: 1217772|Points: 125/175
Sql
Problem
Submissions
Leaderboard
Discussions
Write a query to print all prime numbers less than or equal to . Print your result on a single line, and use the ampersand () character as your separator (instead of a space).

For example, the output for all prime numbers  would be:

2&3&5&7
 
WITH cte_numgen AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1
    FROM cte_numgen
    WHERE n < 1000
),
cte_primes AS (
    SELECT n
    FROM cte_numgen a
    WHERE NOT EXISTS (
        SELECT 1
        FROM cte_numgen b
        WHERE a.n > b.n AND a.n % b.n = 0
    )
)
SELECT STRING_AGG(CAST(n AS VARCHAR(MAX)), '&') AS prime_string
FROM cte_primes
OPTION (MAXRECURSION 0);

2
IF OBJECT_ID('tempdb..#temp_prime') IS NOT NULL
3
BEGIN 
4
    DROP TABLE #temp_prime
5
END 
6
DECLARE @max INT = 1000
7
;WITH cte_prime_numbers AS
8
(
9
    SELECT 2 as num
10
    UNION ALL
11
    SELECT num + 1 FROM cte_prime_numbers WHERE num < @max
12
)
13
SELECT a.num into #temp_prime 
14
FROM cte_prime_numbers a
15
WHERE NOT EXISTS (
16
    SELECT 1
17
    FROM cte_prime_numbers b
18
    WHERE b.num < a.num AND a.num % b.num = 0
19
)
20
ORDER BY a.num
21
option (maxrecursion 1000)
22
select string_agg(num,'&') from #temp_prime
Line: 22 Col: 44
Run Code Submit CodeUpload Code as File
Congratulations!

You have passed the sample test cases. Click the submit button to run your code against all the test cases.


Sample Test case 0
Your Output (stdout)
2&3&5&7&11&13&17&19&23&29&31&37&41&43&47&53&59&61&67&71&73&79&83&89&97&101&103&107&109&113&127&131&137&139&149&151&157&163&167&173&179&181&191&193&197&199&211&223&227&229&233&239&241&251&257&263&269&271&277&281&283&293&307&311&313&317&331&337&347&349&353&359&367&373&379&383&389&397&401&409&419&421&431&433&439&443&449&457&461&463&467&479&487&491&499&503&509&521&523&541&547&557&563&569&571&577&587&593&599&601&607&613&617&619&631&641&643&647&653&659&661&673&677&683&691&701&709&719&727&733&739&743&751&757&761&769&773&787&797&809&811&821&823&827&829&839&853&857&859&863&877&881&883&887&907&911&919&929&937&941&947&953&967&971&977&983&991&997
AuthorAvmnuSng
DifficultyMedium
Max Score40
Submitted By93357
NEED HELP?
View discussions
View top submissions
RATE THIS CHALLENGE

MORE DETAILS
Download problem statement
Download sample test cases
Suggest Edits
Share on FacebookShare on TwitterShare on LinkedIn
BlogScoringEnvironmentFAQAbout UsSupportCareersTerms Of ServicePrivacy Policy
