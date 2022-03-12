SELECT request_at AS Day,
       ROUND(SUM(CASE WHEN status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE 0 END)::NUMERIC/COUNT(id),2) AS "Cancellation rate" 
FROM trips 
WHERE 
    client_id NOT IN (SELECT users_id FROM users WHERE banned = 'Yes') 
    AND 
    driver_id NOT IN (SELECT users_id FROM users WHERE banned = 'Yes')
GROUP BY request_at
order by request_at;