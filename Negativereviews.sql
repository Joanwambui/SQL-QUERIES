Find the top two hotels with the most negative reviews.
Output the hotel name along with the corresponding number of negative reviews.
Negative reviews are all the reviews with text under negative review different than "No Negative". 
Sort records based on the number of negative reviews in descending order.

SELECT TOP 2 hotel_name, COUNT(negative_review) AS negativereviews
FROM hotel_reviews
WHERE negative_review NOT IN ('No Negative')
GROUP BY hotel_name
ORDER BY negativereviews DESC