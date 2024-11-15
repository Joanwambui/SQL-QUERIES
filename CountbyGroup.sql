SELECT 
    trackname,
    COUNT(trackname) AS track_count

FROM 
    spotify_worldwide_daily_song_ranking
WHERE 
    position = 1
GROUP BY 
    trackname
ORDER BY track_count DESC