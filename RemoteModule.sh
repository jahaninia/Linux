#!/bin/bash

DB_HOST="localhost"
DB_USER="root"
DB_PASS=""
DB_NAME="tgui"

# یک تابع برای درج رکورد و استفاده از last_insert_id
insert_routine_pair1() {

  # اجرای INSERT و گرفتن ID
  last_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -s -N -e "
    INSERT INTO `routines` VALUES (null,'دریافت شماره دورکاری','',101);
    SELECT LAST_INSERT_ID();
  ")

  echo "درج شد: $routine_name → ID: $last_id"

  # اجرای دستور دوم با استفاده از ID
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    INSERT INTO routine_details 
    VALUES 
	(null,'support.getQueueNum',$last_id,'XML-RPC','agentBridge',1,1000,1000,'http://localhost/work/queus.php','support.getQueueNum','queueNumber','','','TEXT',1,'','',NULL,'MySQL','','',NULL,'',1000,'PERSISTENT','',101);
  "
}

insert_routine_pair2() {

  # اجرای INSERT و گرفتن ID
  last_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -s -N -e "
    INSERT INTO `routines` VALUES (null,'افزایش تعداد پاسخگویی دورکاری','',101);
    SELECT LAST_INSERT_ID();
  ")

  echo "درج شد: $routine_name → ID: $last_id"

  # اجرای دستور دوم با استفاده از ID
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    INSERT INTO routine_details 
    VALUES 
	(null,'support.addCount',$last_id,'XML-RPC','agentBridge',1,1000,1000,'http://localhost/work/queus.php','support.addCount','xid,DIALSTATUS','','','TEXT',1,'','',NULL,'MySQL','','',NULL,'',1000,'PERSISTENT','',101);
  "
}

insert_routine_pair3() {

  # اجرای INSERT و گرفتن ID
  last_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -s -N -e "
    INSERT INTO `routines` VALUES (null,'در حال مکالمه دورکاری','',101);
    SELECT LAST_INSERT_ID();
  ")

  echo "درج شد: $routine_name → ID: $last_id"

  # اجرای دستور دوم با استفاده از ID
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    INSERT INTO routine_details 
    VALUES 
	(null,'support.inUse',$last_id,'XML-RPC','agentBridge',1,1000,1000,'http://localhost/work/queus.php','support.inUse','xid','','','TEXT',1,'','',NULL,'MySQL','','',NULL,'',1000,'PERSISTENT','',101);
  "
}


insert_routine_pair4() {

  # اجرای INSERT و گرفتن ID
  last_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -s -N -e "
    INSERT INTO `routines` VALUES (null,'کال فایل دورکاری','',101);
    SELECT LAST_INSERT_ID();
  ")

  echo "درج شد: $routine_name → ID: $last_id"

  # اجرای دستور دوم با استفاده از ID
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    INSERT INTO routine_details 
    VALUES 
	(null,'support.createCallFile',$last_id,'XML-RPC','agentBridge',1,1000,1000,'http://localhost/work/queus.php','support.createCallFile','CALLERID(num)','','','TEXT',1,'','',NULL,'MySQL','','',NULL,'',1000,'PERSISTENT','',101);
  "
}

insert_routine_pair5() {

  # اجرای INSERT و گرفتن ID
  last_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -s -N -e "
    INSERT INTO `routines` VALUES (null,'دریافت شماره مشتری دورکاری','',101);
    SELECT LAST_INSERT_ID();
  ")

  echo "درج شد: $routine_name → ID: $last_id"

  # اجرای دستور دوم با استفاده از ID
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    INSERT INTO routine_details 
    VALUES 
	(null,'support.GetNumberCustomer',$last_id,'XML-RPC','agentBridge',1,1000,1000,'http://localhost/work/queus.php','support.GetNumberCustomer','','','','TEXT',1,'','',NULL,'MySQL','','',NULL,'',1000,'PERSISTENT','',101);
  "
}

insert_routine_pair6() {

  # اجرای INSERT و گرفتن ID
  last_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -s -N -e "
    INSERT INTO `routines` VALUES (null,'دریافت شماره مشتری دورکاری','',101);
    SELECT LAST_INSERT_ID();
  ")

  echo "درج شد: $routine_name → ID: $last_id"

  # اجرای دستور دوم با استفاده از ID
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    INSERT INTO routine_details 
    VALUES 
	(null,'support.GetNumberCustomer',$last_id,'XML-RPC','agentBridge',1,1000,1000,'http://localhost/work/queus.php','support.GetNumberCustomer','','','','TEXT',1,'','',NULL,'MySQL','','',NULL,'',1000,'PERSISTENT','',101);
  "
}

insert_routine_pair7() {

  # اجرای INSERT و گرفتن ID
  last_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -s -N -e "
    INSERT INTO `routines` VALUES (null,'بروزرسانی کال فایل دورکاری','',101);
    SELECT LAST_INSERT_ID();
  ")

  echo "درج شد: $routine_name → ID: $last_id"

  # اجرای دستور دوم با استفاده از ID
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    INSERT INTO routine_details 
    VALUES 
	(null,'support.updateCallFiles',$last_id,'XML-RPC','agentBridge',1,1000,1000,'http://localhost/work/queus.php','support.updateCallFiles','number,DIALSTATUS,CALLERID(num)','','','TEXT',1,'','',NULL,'MySQL','','',NULL,'',1000,'PERSISTENT','',101);
  "
}

insert_routine_pair8() {

  # اجرای INSERT و گرفتن ID
  last_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -s -N -e "
    INSERT INTO `routines` VALUES (null,'درحال مکالمه مشتری دورکاری','',101);
    SELECT LAST_INSERT_ID();
  ")

  echo "درج شد: $routine_name → ID: $last_id"

  # اجرای دستور دوم با استفاده از ID
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    INSERT INTO routine_details 
    VALUES 
	(null,'support.flgCustomer',$last_id,'XML-RPC','agentBridge',1,1000,1000,'http://localhost/work/queus.php','support.flgCustomer','number','','','TEXT',1,'','',NULL,'MySQL','','',NULL,'',1000,'PERSISTENT','',101);
  "
}

insert_routine_pair9() {

  # اجرای INSERT و گرفتن ID
  last_id=$(mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -s -N -e "
    INSERT INTO `routines` VALUES (null,'دورکاری - صف شخصی','',101);
;
    SELECT LAST_INSERT_ID();
  ")

  echo "درج شد: $routine_name → ID: $last_id"

  # اجرای دستور دوم با استفاده از ID
  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e "
    INSERT INTO routine_details 
    VALUES 
	(null,'support.getMyQueue',$last_id,'XML-RPC','agentBridge',1,1000,1000,'http://localhost/work/queus.php','support.getMyQueue','queueNumber','','','TEXT',1,'','',NULL,'MySQL','','',NULL,'',1000,'PERSISTENT','',101);
  "
}
