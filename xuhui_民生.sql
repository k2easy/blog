truncate etl_tmp.table_info ;
insert into table_info(table_id,table_cn_name,table_en_name,table_describe,delete_state,record_space,record_count,last_update_datetime)
select 
uuid() as table_id ,TABLE_COMMENT as table_cn_name,table_name as table_en_name, TABLE_COMMENT as table_describe,2,
concat(truncate(data_length/1024/1024,2),' MB') as record_space,
TABLE_ROWS as record_count,
UPDATE_TIME
 from information_schema.tables 
where table_schema='dms_hw'
group by TABLE_NAME 


etl_tmp 
CREATE TABLE `table_info`  (
  `table_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编号',
  `table_cn_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '中文名',
  `table_en_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '英文名',
  `table_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表描述',
  `delete_state` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除标志',
  `create_datetime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `last_update_datetime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
  `etl_updatetime` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'etl更新时间',
  `record_space` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据占用空间（MB）',
  `record_count` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '总记录数',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '表信息' ROW_FORMAT = Dynamic;


CREATE TABLE `field_info`  (
  `id` int(32) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `table_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表主键',
  `field` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '注释',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型',
  `length` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '长度',
  `dot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小数',
  `default_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '默认值',
  `primary` int(1) NULL DEFAULT NULL COMMENT '1主键 0非主键',
  `standard` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标准id',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态id',
  `delete_state` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '删除标志',
  `create_datetime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `last_update_datetime` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `table_id`(`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1382 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字段信息' ROW_FORMAT = Dynamic;


truncate etl_tmp.field_info;
insert into etl_tmp.field_info(table_id,field,`comment`,type,length,dot,default_value,`primary`,delete_state)
select  
t2.table_id as table_id, 
 t1.COLUMN_NAME as field ,
  t1.COLUMN_COMMENT as `comment`,
upper(t1.data_type) as `type`,
substring_index ( substr(t1.COLUMN_DEFAULT,length ( substring_index(t1.COLUMN_DEFAULT,'(',1) )+2, length(t1.COLUMN_DEFAULT) ) ,')',1) as length,
t1.NUMERIC_SCALE as dot,
t1.COLUMN_DEFAULT  as default_value,
0 as `primary`,
2 as delete_state
from information_schema.columns t1 , etl_tmp.table_info t2 
where   t2.table_en_name = t1.table_name 
and t1.table_schema = 'dms_hw';



 table_info 

// table_quality_report 
 quality_report > 》table_quality_report_details 
 每配置好的质量报告  每月定时检查 生成多条质量报告记录 



徐汇_民生_xingwei2019
31.0.161.33
3306
root 

徐汇_demo_1qaz2wsx,
31.0.167.21

