-- db.order_bti_record.remove({"orderTime":{"$lte":1691231349000}}); // 7996755 
-- db.order_bti_record.remove({"orderTime":{"$gte":1691231349000, $lte:1701772149000}}); // 10767707 
-- db.order_bti_record.remove({"orderTime":{"$gte":1701772149000, $lte:1709634549000}}); // 8459158


-- db.order_reserve_req_log.remove({"createDate":{"$lte":"2023-03-01 01:38:27"}}); // 10369637
-- db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-03-01 01:38:27","$lte":"2023-04-01 01:38:27"}}); // 12597110 
db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-04-01 01:38:27","$lte":"2023-05-01 01:38:27"}}); // 10074908  
db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-05-01 01:38:27","$lte":"2023-06-01 01:38:27"}}); // 9183964   
db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-06-01 01:38:27","$lte":"2023-07-01 01:38:27"}}); // 7251120    
db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-07-01 01:38:27","$lte":"2023-08-01 01:38:27"}}); // 6499968     
db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-08-01 01:38:27","$lte":"2023-09-01 01:38:27"}}); // 6808719      
db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-09-01 01:38:27","$lte":"2023-10-01 01:38:27"}}); // 6695656       
db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-10-01 01:38:27","$lte":"2023-11-01 01:38:27"}}); // 7596211   
db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-11-01 01:38:27","$lte":"2023-12-01 01:38:27"}}); // 8666406    
db.order_reserve_req_log.remove({"createDate":{"$gte":"2023-12-01 01:38:27","$lte":"2024-01-01 01:38:27"}}); // 9039550   
db.order_reserve_req_log.remove({"createDate":{"$gte":"2024-01-01 01:38:27","$lte":"2024-02-01 01:38:27"}}); // 8326623 