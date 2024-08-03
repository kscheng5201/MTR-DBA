db.order_credit_req_log.remove({"createDate":{"$lte":"2023-01-01 00:00:00"}});  // 7006138 
db.ibo_unsettle_order.remove({"createPullTime":{$lte:"2023-01-01 00:00:00"}); // 7619372 