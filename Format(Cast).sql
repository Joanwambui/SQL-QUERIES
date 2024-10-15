SELECT shipment_id, sub_id, weight, 
       FORMAT(CAST(shipment_date AS DATE), 'yyyy-MM') AS formatted_shipment_date, 
       CONCAT(shipment_id, sub_id) AS unique_id
FROM amazon_shipment;
