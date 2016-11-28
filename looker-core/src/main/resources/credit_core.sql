prompt PL/SQL Developer import file
prompt Created on 2016年11月23日 by guoxinxin
set feedback off
set define off
prompt Creating DICTIONARY...
create table DICTIONARY
(
  dic_id        bigint(38) not null,
  dic_type      VARCHAR(100),
  dic_type_desc VARCHAR(100),
  dic_code      VARCHAR(100),
  dic_desc      VARCHAR(100),
  dic_sort      VARCHAR(100),
  create_time   datetime,
  update_time   datetime,
  create_user   bigint(38),
  update_user   bigint(38)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
;
comment on table DICTIONARY
  is '字典信息';
comment on column DICTIONARY.dic_id
  is '字典ID';
comment on column DICTIONARY.dic_type
  is '字典类型代码';
comment on column DICTIONARY.dic_type_desc
  is '字典类型描述';
comment on column DICTIONARY.dic_code
  is '业务代码';
comment on column DICTIONARY.dic_desc
  is '业务描述';
comment on column DICTIONARY.dic_sort
  is '排序字段';
comment on column DICTIONARY.create_time
  is '创建时间';
comment on column DICTIONARY.update_time
  is '修改时间';
comment on column DICTIONARY.create_user
  is '创建人';
comment on column DICTIONARY.update_user
  is '修改人';
alter table DICTIONARY
  add constraint PK_DICTIONARY primary key (DIC_ID)
  ;

prompt Creating D_API_CALL_STATISTICS...
create table D_API_CALL_STATISTICS
(
  id           bigint(20) not null,
  api_name     VARCHAR(50) not null,
  channel_code VARCHAR(100) not null,
  channel_name VARCHAR(500),
  product_code VARCHAR(200) not null,
  total_count  bigint(20),
  created_by   VARCHAR(50),
  updated_by   VARCHAR(50),
  created_at   datetime,
  updated_at   datetime
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on table D_API_CALL_STATISTICS
  is '记录渠道调用产品的总次数';
comment on column D_API_CALL_STATISTICS.id
  is '主键';
comment on column D_API_CALL_STATISTICS.api_name
  is 'API接口名称';
comment on column D_API_CALL_STATISTICS.channel_code
  is '渠道号(由企业征信系统提供)';
comment on column D_API_CALL_STATISTICS.channel_name
  is '渠道名称(由企业征信系统提供)';
comment on column D_API_CALL_STATISTICS.product_code
  is '产品号(由企业征信系统提供)';
comment on column D_API_CALL_STATISTICS.total_count
  is '调用次数';
comment on column D_API_CALL_STATISTICS.created_by
  is '创建人';
comment on column D_API_CALL_STATISTICS.updated_by
  is '更新人';
comment on column D_API_CALL_STATISTICS.created_at
  is '创建时间';
comment on column D_API_CALL_STATISTICS.updated_at
  is '更新时间';
alter table D_API_CALL_STATISTICS
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
alter table D_API_CALL_STATISTICS
  add constraint UK_CHANNEL_PRODUCT_CODE unique (CHANNEL_CODE, PRODUCT_CODE)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_API_CALL_STATISTICS to DATAPLATFORM_RW;

prompt Creating D_API_DATABASE_REL...
create table D_API_DATABASE_REL
(
  id            bigint(20) not null,
  api_id        VARCHAR(100),
  table_name    VARCHAR(100),
  create_time   datetime,
  update_time   datetime,
  database_type VARCHAR(100),
  process_bean  VARCHAR(100)
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on table D_API_DATABASE_REL
  is '接口与数据库映射表';
comment on column D_API_DATABASE_REL.api_id
  is '接口编号';
comment on column D_API_DATABASE_REL.table_name
  is '表名';
comment on column D_API_DATABASE_REL.create_time
  is '创建日期';
comment on column D_API_DATABASE_REL.update_time
  is '更新日期';
comment on column D_API_DATABASE_REL.database_type
  is '数据库类型';
comment on column D_API_DATABASE_REL.process_bean
  is 'API处理类';
alter table D_API_DATABASE_REL
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_API_DATABASE_REL to DATAPLATFORM_RW;

prompt Creating D_API_EXTERNAL_RESOURCE_REL...
create table D_API_EXTERNAL_RESOURCE_REL
(
  id              bigint(20) not null,
  api_id          VARCHAR(100) not null,
  resource_api_id VARCHAR(100) not null,
  priority        VARCHAR(100),
  call_rate       VARCHAR(10),
  create_time     datetime,
  update_time     datetime,
  group_id        VARCHAR(100)
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on table D_API_EXTERNAL_RESOURCE_REL
  is '接口产品与数据源接口对应表';
comment on column D_API_EXTERNAL_RESOURCE_REL.id
  is '主键ID';
comment on column D_API_EXTERNAL_RESOURCE_REL.api_id
  is '对外接口服务名称';
comment on column D_API_EXTERNAL_RESOURCE_REL.resource_api_id
  is '数据源接口代码';
comment on column D_API_EXTERNAL_RESOURCE_REL.priority
  is '优先级';
comment on column D_API_EXTERNAL_RESOURCE_REL.call_rate
  is '调用概率';
comment on column D_API_EXTERNAL_RESOURCE_REL.create_time
  is '创建日期';
comment on column D_API_EXTERNAL_RESOURCE_REL.update_time
  is '更新日期';
comment on column D_API_EXTERNAL_RESOURCE_REL.group_id
  is '组别ID';
alter table D_API_EXTERNAL_RESOURCE_REL
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_API_EXTERNAL_RESOURCE_REL to DATAPLATFORM_RW;

prompt Creating D_API_INFO...
create table D_API_INFO
(
  id             bigint(20) not null,
  api_id         VARCHAR(100) not null,
  name           VARCHAR(100) not null,
  status         VARCHAR(5) not null,
  remark         VARCHAR(300),
  category_code  VARCHAR(100),
  useage_example VARCHAR(1000),
  type           VARCHAR(100),
  create_time    datetime,
  update_time    datetime
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on table D_API_INFO
  is 'API信息表';
comment on column D_API_INFO.id
  is '主键';
comment on column D_API_INFO.api_id
  is 'API接口名称';
comment on column D_API_INFO.name
  is 'API接口的说明';
comment on column D_API_INFO.status
  is 'API接口是否有效，1:有效，0:无效';
comment on column D_API_INFO.remark
  is '注释';
comment on column D_API_INFO.category_code
  is '分类代码';
comment on column D_API_INFO.useage_example
  is '使用实例';
comment on column D_API_INFO.type
  is 'API类型';
comment on column D_API_INFO.create_time
  is '创建时间';
comment on column D_API_INFO.update_time
  is '更新时间';
alter table D_API_INFO
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_API_INFO to DATAPLATFORM_RW;

prompt Creating D_API_PARAM...
create table D_API_PARAM
(
  id           bigint(20) not null,
  api_id       VARCHAR(100) not null,
  param_id     VARCHAR(100) not null,
  name         VARCHAR(100),
  type         VARCHAR(10) not null,
  data_type    VARCHAR(100),
  remark       VARCHAR(300),
  must         VARCHAR(5),
  qualifier    VARCHAR(100),
  single       VARCHAR(100),
  parent_id    VARCHAR(100),
  create_time  datetime,
  source_param VARCHAR(100),
  group_id     VARCHAR(100),
  update_time  datetime,
  rule_id      VARCHAR(100),
  json_path    VARCHAR(100)
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on column D_API_PARAM.api_id
  is '接口名称';
comment on column D_API_PARAM.param_id
  is '系统内部参数名称';
comment on column D_API_PARAM.name
  is '参数中文名';
comment on column D_API_PARAM.type
  is '参数类型(INPUT,OUTPUT)';
comment on column D_API_PARAM.data_type
  is '参数数据类型';
comment on column D_API_PARAM.remark
  is '描述信息';
comment on column D_API_PARAM.must
  is '是否必需（Y:必需;N:不必需）';
comment on column D_API_PARAM.qualifier
  is '初始值';
comment on column D_API_PARAM.single
  is '节点类型(单节点，复节点)';
comment on column D_API_PARAM.parent_id
  is '父节点';
comment on column D_API_PARAM.create_time
  is '创建日期';
comment on column D_API_PARAM.source_param
  is '源参数';
comment on column D_API_PARAM.group_id
  is '组(扩展)';
comment on column D_API_PARAM.update_time
  is '更新日期';
comment on column D_API_PARAM.rule_id
  is '校验规则';
comment on column D_API_PARAM.json_path
  is '参数路径';
alter table D_API_PARAM
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_API_PARAM to DATAPLATFORM_RW;

prompt Creating D_DATA_RESOURCE...
create table D_DATA_RESOURCE
(
  id          bigint(20) not null,
  name        VARCHAR(100),
  protocol    VARCHAR(100),
  net_type    VARCHAR(100),
  server_ip   VARCHAR(100),
  port        VARCHAR(5),
  create_time datetime,
  update_time datetime,
  resource_id VARCHAR(100) not null
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on table D_DATA_RESOURCE
  is '数据源表';
comment on column D_DATA_RESOURCE.id
  is '主键ID';
comment on column D_DATA_RESOURCE.name
  is '数据源名称';
comment on column D_DATA_RESOURCE.protocol
  is '协议';
comment on column D_DATA_RESOURCE.net_type
  is '网络类型';
comment on column D_DATA_RESOURCE.server_ip
  is '服务器IP地址';
comment on column D_DATA_RESOURCE.port
  is '端口号';
comment on column D_DATA_RESOURCE.create_time
  is '创建时间';
comment on column D_DATA_RESOURCE.update_time
  is '修改时间';
comment on column D_DATA_RESOURCE.resource_id
  is '数据源ID';
alter table D_DATA_RESOURCE
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_DATA_RESOURCE to DATAPLATFORM_RW;

prompt Creating D_DATA_RESOURCE_API...
create table D_DATA_RESOURCE_API
(
  id              bigint(20) not null,
  name            VARCHAR(100),
  resource_api_id VARCHAR(100) not null,
  resource_id     VARCHAR(100) not null,
  vendor_id       VARCHAR(100) not null,
  url             VARCHAR(100),
  type            VARCHAR(100),
  useage_example  VARCHAR(1000),
  create_time     datetime,
  update_time     datetime,
  bean_name       VARCHAR(100)
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on table D_DATA_RESOURCE_API
  is '数据源接口信息表';
comment on column D_DATA_RESOURCE_API.id
  is '主键ID';
comment on column D_DATA_RESOURCE_API.name
  is '接口名称';
comment on column D_DATA_RESOURCE_API.resource_api_id
  is '接口代码';
comment on column D_DATA_RESOURCE_API.resource_id
  is '数据源代码';
comment on column D_DATA_RESOURCE_API.vendor_id
  is '供应商代码';
comment on column D_DATA_RESOURCE_API.url
  is 'URL地址';
comment on column D_DATA_RESOURCE_API.type
  is '接口类型(调用,被调用)';
comment on column D_DATA_RESOURCE_API.useage_example
  is '接口案例';
comment on column D_DATA_RESOURCE_API.create_time
  is '创建时间';
comment on column D_DATA_RESOURCE_API.update_time
  is '修改时间';
comment on column D_DATA_RESOURCE_API.bean_name
  is '实现类名称';
alter table D_DATA_RESOURCE_API
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_DATA_RESOURCE_API to DATAPLATFORM_RW;

prompt Creating D_DATA_RESOURCE_API_PARAM...
create table D_DATA_RESOURCE_API_PARAM
(
  id              bigint(20) not null,
  resource_api_id VARCHAR(100) not null,
  param_id        VARCHAR(100),
  name            VARCHAR(100),
  type            VARCHAR(10),
  data_type       VARCHAR(100),
  must            VARCHAR(100),
  qualifier       VARCHAR(2000),
  single          VARCHAR(100),
  dest_id         VARCHAR(100),
  create_time     datetime,
  update_time     datetime,
  json_path       VARCHAR(100)
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on table D_DATA_RESOURCE_API_PARAM
  is '数据源接口输入输出参数表';
comment on column D_DATA_RESOURCE_API_PARAM.id
  is '主键ID';
comment on column D_DATA_RESOURCE_API_PARAM.resource_api_id
  is '接口代码';
comment on column D_DATA_RESOURCE_API_PARAM.param_id
  is '参数代码';
comment on column D_DATA_RESOURCE_API_PARAM.name
  is '参数名称';
comment on column D_DATA_RESOURCE_API_PARAM.type
  is '参数类型(INPUT,OUTPUT)';
comment on column D_DATA_RESOURCE_API_PARAM.data_type
  is '参数数据类型';
comment on column D_DATA_RESOURCE_API_PARAM.must
  is '是否必需';
comment on column D_DATA_RESOURCE_API_PARAM.qualifier
  is '初始化值';
comment on column D_DATA_RESOURCE_API_PARAM.single
  is '节点类型(单节点，复节点)';
comment on column D_DATA_RESOURCE_API_PARAM.dest_id
  is '对应第三方数据平台参数代码';
comment on column D_DATA_RESOURCE_API_PARAM.create_time
  is '创建时间';
comment on column D_DATA_RESOURCE_API_PARAM.update_time
  is '修改时间';
comment on column D_DATA_RESOURCE_API_PARAM.json_path
  is '参数路径';
alter table D_DATA_RESOURCE_API_PARAM
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_DATA_RESOURCE_API_PARAM to DATAPLATFORM_RW;

prompt Creating D_DATA_RESOURCE_REPORT...
create table D_DATA_RESOURCE_REPORT
(
  id                bigint(20) not null,
  resource_id       VARCHAR(50) not null,
  resource_api_id   VARCHAR(50) not null,
  resource_api_name VARCHAR(100) not null,
  success_count     bigint(20) not null,
  fail_count        bigint(20) not null,
  total_count       bigint(20) not null,
  status            bigint(20) not null,
  created_by        VARCHAR(50) not null,
  updated_by        VARCHAR(50) not null,
  created_at        datetime not null,
  updated_at        datetime not null
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on table D_DATA_RESOURCE_REPORT
  is '数据源被调用统计';
comment on column D_DATA_RESOURCE_REPORT.id
  is '主键';
comment on column D_DATA_RESOURCE_REPORT.resource_id
  is '数据源标识';
comment on column D_DATA_RESOURCE_REPORT.resource_api_id
  is '数据源API标识';
comment on column D_DATA_RESOURCE_REPORT.resource_api_name
  is '数据源API名称';
comment on column D_DATA_RESOURCE_REPORT.success_count
  is '调用数据源API成功次数';
comment on column D_DATA_RESOURCE_REPORT.fail_count
  is '调用数据源API失败次数';
comment on column D_DATA_RESOURCE_REPORT.total_count
  is '调用数据源API总次数';
comment on column D_DATA_RESOURCE_REPORT.status
  is '状态，1：有效，0：无效';
comment on column D_DATA_RESOURCE_REPORT.created_by
  is '创建人';
comment on column D_DATA_RESOURCE_REPORT.updated_by
  is '更新人';
comment on column D_DATA_RESOURCE_REPORT.created_at
  is '创建时间';
comment on column D_DATA_RESOURCE_REPORT.updated_at
  is '更新时间';
alter table D_DATA_RESOURCE_REPORT
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
alter table D_DATA_RESOURCE_REPORT
  add constraint UK_RESOURCE_API_ID unique (RESOURCE_ID, RESOURCE_API_ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_DATA_RESOURCE_REPORT to DATAPLATFORM_RW;

prompt Creating D_PRODUCT_API_REL...
create table D_PRODUCT_API_REL
(
  id          bigint(20) not null,
  product_id  VARCHAR(100) not null,
  api_id      VARCHAR(100) not null,
  create_time datetime,
  update_time datetime
)
tablespace TS_CORES_EC
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
comment on table D_PRODUCT_API_REL
  is '产品API中间关联表';
comment on column D_PRODUCT_API_REL.id
  is '主键ID';
comment on column D_PRODUCT_API_REL.product_id
  is '产品CODE';
comment on column D_PRODUCT_API_REL.api_id
  is 'APIID';
comment on column D_PRODUCT_API_REL.create_time
  is '创建时间';
comment on column D_PRODUCT_API_REL.update_time
  is '修改时间';
alter table D_PRODUCT_API_REL
  add primary key (ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
grant select, insert, update, delete on D_PRODUCT_API_REL to DATAPLATFORM_RW;

prompt Creating SYS_MENU...
create table SYS_MENU
(
  menu_id        bigint not null,
  menu_name      VARCHAR(100),
  menu_type      VARCHAR(2),
  menu_url       VARCHAR(300),
  parent_id      bigint,
  menu_level     VARCHAR(100),
  menu_sort      bigint,
  whether_delete VARCHAR(10),
  create_time    datetime,
  create_user    VARCHAR(100),
  update_time    datetime,
  update_user    VARCHAR(100),
  menu_icon      VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
comment on table SYS_MENU
  is '菜单表';
comment on column SYS_MENU.menu_id
  is '菜单ID';
comment on column SYS_MENU.menu_name
  is '菜单名称';
comment on column SYS_MENU.menu_type
  is '菜单类型';
comment on column SYS_MENU.menu_url
  is '菜单URL';
comment on column SYS_MENU.parent_id
  is '上级菜单id';
comment on column SYS_MENU.menu_level
  is '菜单级别';
comment on column SYS_MENU.menu_sort
  is '菜单排序';
comment on column SYS_MENU.whether_delete
  is '是否删除0是1否';
comment on column SYS_MENU.create_time
  is '创建日期';
comment on column SYS_MENU.create_user
  is '创建用户';
comment on column SYS_MENU.update_time
  is '修改日期';
comment on column SYS_MENU.update_user
  is '更新用户';
comment on column SYS_MENU.menu_icon
  is '菜单图标';
alter table SYS_MENU
  add constraint PK_SYS_MENU primary key (MENU_ID);

prompt Creating SYS_ROLE...
create table SYS_ROLE
(
  role_id        bigint not null,
  role_code      VARCHAR(100),
  role_name      VARCHAR(100),
  role_desc      VARCHAR(300),
  whether_delete VARCHAR(10),
  create_time    datetime,
  create_user    VARCHAR(100),
  update_time    datetime,
  update_user    VARCHAR(100)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
comment on table SYS_ROLE
  is '角色表';
comment on column SYS_ROLE.role_id
  is '角色ID';
comment on column SYS_ROLE.role_code
  is '角色code';
comment on column SYS_ROLE.role_name
  is '角色名称';
comment on column SYS_ROLE.role_desc
  is '角色描述';
comment on column SYS_ROLE.whether_delete
  is '是否删除0是1否';
comment on column SYS_ROLE.create_time
  is '创建日期';
comment on column SYS_ROLE.create_user
  is '创建用户';
comment on column SYS_ROLE.update_time
  is '修改日期';
comment on column SYS_ROLE.update_user
  is '更新用户';
alter table SYS_ROLE
  add constraint PK_SYS_ROLE primary key (ROLE_ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );

prompt Creating SYS_ROLE_MENU...
create table SYS_ROLE_MENU
(
  role_id     bigint not null,
  menu_id     bigint not null,
  create_time datetime,
  create_user VARCHAR(100),
  update_time datetime,
  update_user VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
comment on table SYS_ROLE_MENU
  is '角色菜单表';
comment on column SYS_ROLE_MENU.role_id
  is '角色ID';
comment on column SYS_ROLE_MENU.menu_id
  is '菜单ID';
comment on column SYS_ROLE_MENU.create_time
  is '创建日期';
comment on column SYS_ROLE_MENU.create_user
  is '创建用户';
comment on column SYS_ROLE_MENU.update_time
  is '修改日期';
comment on column SYS_ROLE_MENU.update_user
  is '更新用户';
alter table SYS_ROLE_MENU
  add constraint PK_SYS_ROLE_MENU primary key (ROLE_ID, MENU_ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );

prompt Creating SYS_USER...
create table SYS_USER
(
  user_id        bigint not null,
  user_account   VARCHAR(100),
  password       VARCHAR(100),
  user_name      VARCHAR(100),
  user_status    VARCHAR(10),
  emp_no         VARCHAR(10),
  belong_depart  VARCHAR(100),
  create_time    datetime,
  create_user    VARCHAR(100),
  update_time    datetime,
  update_user    VARCHAR(100),
  whether_delete VARCHAR(10),
  phone_no       VARCHAR(20),
  email          VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
comment on table SYS_USER
  is '用户表';
comment on column SYS_USER.user_id
  is '用户ID';
comment on column SYS_USER.user_account
  is '用户账号';
comment on column SYS_USER.password
  is '登录密码';
comment on column SYS_USER.user_name
  is '用户姓名';
comment on column SYS_USER.user_status
  is '状态0启用1停用';
comment on column SYS_USER.emp_no
  is '工号';
comment on column SYS_USER.belong_depart
  is '所属部门';
comment on column SYS_USER.create_time
  is '创建日期';
comment on column SYS_USER.create_user
  is '创建用户';
comment on column SYS_USER.update_time
  is '修改日期';
comment on column SYS_USER.update_user
  is '更新用户';
comment on column SYS_USER.whether_delete
  is '是否删除0是1否';
comment on column SYS_USER.phone_no
  is '手机号码';
comment on column SYS_USER.email
  is '邮箱';
alter table SYS_USER
  add constraint PK_SYS_USER primary key (USER_ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );

prompt Creating SYS_USER_ROLE...
create table SYS_USER_ROLE
(
  user_id     bigint not null,
  role_id     bigint not null,
  create_time datetime,
  create_user VARCHAR(100),
  update_time datetime,
  update_user VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
comment on table SYS_USER_ROLE
  is '用户角色表';
comment on column SYS_USER_ROLE.user_id
  is '用户ID';
comment on column SYS_USER_ROLE.role_id
  is '角色ID';
comment on column SYS_USER_ROLE.create_time
  is '创建日期';
comment on column SYS_USER_ROLE.create_user
  is '创建用户';
comment on column SYS_USER_ROLE.update_time
  is '修改日期';
comment on column SYS_USER_ROLE.update_user
  is '更新用户';
alter table SYS_USER_ROLE
  add constraint PK_SYS_USER_ROLE primary key (USER_ID, ROLE_ID)
  using index 
  tablespace TS_CORES_EC
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 1M
    next 1M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );

prompt Disabling triggers for DICTIONARY...
alter table DICTIONARY disable all triggers;
prompt Disabling triggers for D_API_CALL_STATISTICS...
alter table D_API_CALL_STATISTICS disable all triggers;
prompt Disabling triggers for D_API_DATABASE_REL...
alter table D_API_DATABASE_REL disable all triggers;
prompt Disabling triggers for D_API_EXTERNAL_RESOURCE_REL...
alter table D_API_EXTERNAL_RESOURCE_REL disable all triggers;
prompt Disabling triggers for D_API_INFO...
alter table D_API_INFO disable all triggers;
prompt Disabling triggers for D_API_PARAM...
alter table D_API_PARAM disable all triggers;
prompt Disabling triggers for D_DATA_RESOURCE...
alter table D_DATA_RESOURCE disable all triggers;
prompt Disabling triggers for D_DATA_RESOURCE_API...
alter table D_DATA_RESOURCE_API disable all triggers;
prompt Disabling triggers for D_DATA_RESOURCE_API_PARAM...
alter table D_DATA_RESOURCE_API_PARAM disable all triggers;
prompt Disabling triggers for D_DATA_RESOURCE_REPORT...
alter table D_DATA_RESOURCE_REPORT disable all triggers;
prompt Disabling triggers for D_PRODUCT_API_REL...
alter table D_PRODUCT_API_REL disable all triggers;
prompt Disabling triggers for SYS_MENU...
alter table SYS_MENU disable all triggers;
prompt Disabling triggers for SYS_ROLE...
alter table SYS_ROLE disable all triggers;
prompt Disabling triggers for SYS_ROLE_MENU...
alter table SYS_ROLE_MENU disable all triggers;
prompt Disabling triggers for SYS_USER...
alter table SYS_USER disable all triggers;
prompt Disabling triggers for SYS_USER_ROLE...
alter table SYS_USER_ROLE disable all triggers;
prompt Loading DICTIONARY...
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (45, 'auth_status', '授权状态', '2', '停用', 'asc', sysdate(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (34, 'user_status', '用户状态', '0', '启用', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (35, 'user_status', '用户状态', '1', '停用', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (19, 'user_auth_status', '用户授权状态', '1', '未获取', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (20, 'user_auth_status', '用户授权状态', '2', '申请中', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (21, 'user_auth_status', '用户授权状态', '3', '协查中', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (22, 'user_auth_status', '用户授权状态', '4', '已超时', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (23, 'user_auth_status', '用户授权状态', '5', '已获取', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (31, 'obj_status', '异议状态', '0', '新申请', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (32, 'obj_status', '异议状态', '1', '处理中', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (33, 'obj_status', '异议状态', '2', '已回复', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (30, 'auth_type', '授权类型', '0', '查询和采集', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (1, 'status', '状态', '0', '启用', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (2, 'status', '状态', '1', '停用', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (7, 'auth_status', '授权状态', '0', '正式', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (8, 'auth_status', '授权状态', '1', '试用', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (9, 'auth_record_status', '授权记录状态', '0', '新增已申请', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (10, 'auth_record_status', '授权记录状态', '1', '修改已申请', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (11, 'auth_record_status', '授权记录状态', '2', '删除已申请', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (12, 'auth_record_status', '授权记录状态', '3', '新增不通过', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (13, 'auth_record_status', '授权记录状态', '4', '修改不通过', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (14, 'auth_record_status', '授权记录状态', '5', '删除不通过', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (15, 'auth_record_status', '授权记录状态', '6', '新增已复核', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (16, 'auth_record_status', '授权记录状态', '7', '修改已复核', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (17, 'auth_record_status', '授权记录状态', '8', '已删除', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (18, 'auth_record_status', '授权记录状态', '9', '已开通', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (28, 'network_type', '网络类型', '0', '公网', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (29, 'network_type', '网络类型', '1', '内网', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (3, 'type', '类型', '0', '集团内部', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (4, 'type', '类型', '1', '集团外部', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (24, 'cert_type', '证件类型', '0', '二代身份证', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (25, 'cert_type', '证件类型', '1', '军官证', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (26, 'cert_type', '证件类型', '2', '港澳通行证', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (27, 'cert_type', '证件类型', '3', '台胞证', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (36, 'check_status', '核查状态', '0', '有效', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (37, 'check_status', '核查状态', '1', '无效', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (38, 'check_status', '核查状态', '2', '未知', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (39, 'obj_cores_status', '异议状态', '0', '待登记', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (40, 'obj_cores_status', '异议状态', '1', '核查中', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (41, 'obj_cores_status', '异议状态', '2', '已驳回', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (42, 'obj_cores_status', '异议状态', '3', '已结案', 'asc',  SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (43, 'product_status', '产品状态', '1', '启用', 'asc', SYSDATE(), null, 1, null);
insert into DICTIONARY (dic_id, dic_type, dic_type_desc, dic_code, dic_desc, dic_sort, create_time, update_time, create_user, update_user)
values (44, 'product_status', '产品状态', '0', '停用', 'asc', SYSDATE(), null, 1, null);
commit;
prompt 43 records loaded
prompt Loading D_API_CALL_STATISTICS...
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525986, 'fingerPrint/sendBusinessData', 'QD16000005', '内部测试', 'CP16000008', 2, 'sys', 'sys', to_date('18-10-2016 16:03:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-10-2016 16:18:15', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525959, 'identify/verifyBankCard', 'QD16000002', '金融云渠道', 'CP16000003', 17, 'sys', 'sys', to_date('22-08-2016 11:04:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-08-2016 13:01:36', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525949, 'identify/verifyID', 'QD16000001', '数据平台测试渠道1', 'CP16000001', 62, 'sys', 'sys', to_date('02-08-2016 19:45:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-08-2016 14:29:56', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525962, 'identify/verifyBankCard', 'QD16000003', '你我贷理财', 'CP16000003', 21, 'sys', 'sys', to_date('25-08-2016 15:24:57', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-11-2016 09:57:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525978, 'verifyIsMocaWarehouse', 'QD16000003', '你我贷理财', 'CP16000006', 3, 'sys', 'sys', to_date('09-10-2016 10:35:28', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-10-2016 10:44:08', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525982, 'identify/verifyIdMobile', 'QD16000005', '内部测试', 'CP16000002', 1, 'sys', 'sys', to_date('11-10-2016 09:58:51', 'dd-mm-yyyy hh24:mi:ss'), to_date('11-10-2016 09:58:51', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525985, 'fingerPrint/getFingerPrintingId', 'QD16000005', '内部测试', 'CP16000009', 1, 'sys', 'sys', to_date('18-10-2016 16:01:48', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-10-2016 16:01:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525960, 'identify/verifyID', 'QD16000002', '金融云渠道', 'CP16000001', 20, 'sys', 'sys', to_date('22-08-2016 11:10:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 19:29:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525967, 'verifyIsMocaWarehouse', 'QD16000006', '数据平台中移动疑似养卡测试', 'CP16000006', 2, 'sys', 'sys', to_date('31-08-2016 09:36:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-08-2016 10:05:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525953, 'identify/verifyIdMobile', 'QD16000001', '数据平台测试渠道1', 'CP16000002', 8, 'sys', 'sys', to_date('09-08-2016 17:47:57', 'dd-mm-yyyy hh24:mi:ss'), to_date('12-08-2016 16:58:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525980, 'verifyIsMocaWarehouse', 'QD16000005', '内部测试', 'CP16000006', 109, 'sys', 'sys', to_date('11-10-2016 09:57:42', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-10-2016 13:52:21', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525981, 'identify/verifyBankCard', 'QD16000005', '内部测试', 'CP16000003', 1, 'sys', 'sys', to_date('11-10-2016 09:58:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('11-10-2016 09:58:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525983, 'identify/verifyID', 'QD16000005', '内部测试', 'CP16000001', 4, 'sys', 'sys', to_date('11-10-2016 10:28:17', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:29:13', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525984, 'fingerPrint/sendDeviceData', 'QD16000009', '金融云 移动APP', 'CP16000004', 69, 'sys', 'sys', to_date('11-10-2016 15:54:52', 'dd-mm-yyyy hh24:mi:ss'), to_date('08-11-2016 21:06:55', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525970, 'fingerPrint/getFingerPrintingId', 'QD16000007', '反欺诈应用', 'CP16000004', 393, 'sys', 'sys', to_date('26-09-2016 19:49:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-09-2016 14:23:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525968, 'anti-fraud/decision', 'QD1000002', '反欺诈渠道', 'CP16000007', 86, 'sys', 'sys', to_date('26-09-2016 19:31:29', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-10-2016 10:40:38', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525973, 'identify/verifyID', 'QD16000007', '反欺诈应用', 'CP16000001', 8, 'sys', 'sys', to_date('27-09-2016 09:57:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-09-2016 14:22:14', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525975, 'identify/verifyIdMobile', 'QD16000008', '金融云', 'CP16000002', 1, 'sys', 'sys', to_date('27-09-2016 13:30:48', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-09-2016 13:30:48', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525955, 'identify/verifyBankCard', 'QD16000001', '数据平台测试渠道1', 'CP16000003', 31, 'sys', 'sys', to_date('09-08-2016 17:54:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 19:16:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525965, 'verifyPhoneBlacklist', 'QD16000005', '内部测试', 'CP16000005', 122, 'sys', 'sys', to_date('30-08-2016 19:33:18', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-10-2016 13:37:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525969, 'identify/verifyBankCard', 'QD16000007', '反欺诈应用', 'CP16000003', 1, 'sys', 'sys', to_date('26-09-2016 19:35:30', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-09-2016 19:35:30', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525971, 'verifyIsMocaWarehouse', 'QD16000007', '反欺诈应用', 'CP16000006', 30, 'sys', 'sys', to_date('26-09-2016 20:16:17', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-09-2016 14:23:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525972, 'verifyPhoneBlacklist', 'QD16000007', '反欺诈应用', 'CP16000005', 30, 'sys', 'sys', to_date('26-09-2016 20:16:48', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-09-2016 14:23:16', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525974, 'identify/verifyID', 'QD16000008', '金融云', 'CP16000001', 59, 'sys', 'sys', to_date('27-09-2016 13:29:06', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-09-2016 16:55:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525976, 'identify/verifyBankCard', 'QD16000008', '金融云', 'CP16000003', 1, 'sys', 'sys', to_date('27-09-2016 13:32:24', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-09-2016 13:32:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525979, 'verifyPhoneBlacklist', 'QD16000003', '你我贷理财', 'CP16000005', 2, 'sys', 'sys', to_date('09-10-2016 10:44:18', 'dd-mm-yyyy hh24:mi:ss'), to_date('10-10-2016 13:38:55', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525961, 'identify/verifyIdMobile', 'QD16000002', '金融云渠道', 'CP16000002', 1, 'sys', 'sys', to_date('22-08-2016 19:20:20', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-08-2016 19:20:20', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525966, 'fingerPrint/sendDeviceData', 'QD16000004', '数据平台设备指纹测试', 'CP16000004', 351, 'sys', 'sys', to_date('30-08-2016 19:42:17', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-11-2016 16:55:17', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2525977, 'fingerPrint/sendDeviceData', 'QD1000002', '反欺诈渠道', 'CP16000004', 16, 'sys', 'sys', to_date('27-09-2016 18:48:19', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-10-2016 14:12:24', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2526001, 'identify/verifyBankCard', 'QD16000010', '你我贷嘉银数据', 'CP16000003', 40, 'sys', 'sys', to_date('15-11-2016 10:44:56', 'dd-mm-yyyy hh24:mi:ss'), to_date('15-11-2016 16:26:28', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2526298, 'getCompanyBusInfo', 'QD16000005', '内部测试', 'CP16000012', 12, 'sys', 'sys', to_date('18-11-2016 18:22:13', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-11-2016 14:56:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2526292, 'getPersonalBreachedInfo', 'QD16000005', '内部测试', 'CP16000014', 6, 'sys', 'sys', to_date('18-11-2016 10:44:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-11-2016 17:09:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2526288, 'getPersonalInvestmentInfo', 'QD16000005', '内部测试', 'CP16000010', 17, 'sys', 'sys', to_date('18-11-2016 09:42:03', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-11-2016 14:26:42', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2526296, 'environment/getOthers', 'QD16000001', '测试渠道pl01', 'CP16000015', 14, 'sys', 'sys', to_date('18-11-2016 13:47:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 17:25:38', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2526290, 'getPersonalExecutedInfo', 'QD16000005', '内部测试', 'CP16000013', 10, 'sys', 'sys', to_date('18-11-2016 10:32:04', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-11-2016 14:26:05', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2526294, 'environment/getEnviCreditRank', 'QD16000001', '测试渠道pl01', 'CP16000010', 30, 'sys', 'sys', to_date('18-11-2016 10:58:58', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-11-2016 16:59:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_CALL_STATISTICS (id, api_name, channel_code, channel_name, product_code, total_count, created_by, updated_by, created_at, updated_at)
values (2526314, 'getCompanyLawsuitInfo', 'QD16000005', '内部测试', 'CP16000011', 18, 'sys', 'sys', to_date('22-11-2016 11:09:42', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-11-2016 16:35:56', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 37 records loaded
prompt Loading D_API_DATABASE_REL...
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (1, 'identify/verifyID', 'D_IDENTIFY_BASE', to_date('02-08-2016 12:32:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:32:34', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'identifyIdService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (2, 'identify/verifyIdMobile', 'D_IDENTIFY_BASE_PHONE', to_date('09-08-2016 15:20:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:20:38', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'identifyIdMobileService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (3, 'identify/verifyBankCard', 'D_IDENTIFY_BASE_BANK', to_date('09-08-2016 15:20:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:20:38', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'identifyBankCardService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (4, 'verifyPhoneBlacklist', 'D_VERIFY_PHONE_BLACK_LIST', to_date('30-08-2016 17:40:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:40:36', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'verifyPhoneBlackListService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (5, 'verifyIsMocaWarehouse', 'D_VERIFY_PHONE_BLACK_LIST', to_date('30-08-2016 17:40:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:40:36', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'chinaMobileMocaWarehouseService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (6, 'fingerPrint/getFingerPrintingId', null, to_date('30-08-2016 17:49:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:49:14', 'dd-mm-yyyy hh24:mi:ss'), null, 'deviceFingerPrintService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (7, 'fingerPrint/sendBusinessData', null, to_date('30-08-2016 17:49:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:49:14', 'dd-mm-yyyy hh24:mi:ss'), null, 'deviceFingerPrintService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (8, 'fingerPrint/sendDeviceData', null, to_date('30-08-2016 17:49:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:49:14', 'dd-mm-yyyy hh24:mi:ss'), null, 'deviceFingerPrintService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (9, 'anti-fraud/decision', null, to_date('26-09-2016 19:02:58', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-09-2016 19:02:58', 'dd-mm-yyyy hh24:mi:ss'), null, 'decisionServiceImpl');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (41, 'getCompanyBusInfo', 'D_STOCK_DATA', to_date('02-08-2016 12:32:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:32:34', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (40, 'getCompanyLawsuitInfo', 'D_STOCK_DATA', to_date('02-08-2016 12:32:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:32:34', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (42, 'tax/abnormal', 'D_STOCK_DATA', to_date('21-11-2016 10:33:29', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:33:29', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (10, 'querySingleEducation', null, to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), null, 'querySingleEducationService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (11, 'getPersonalInvestmentInfo', 'D_STOCK_DATA', to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (12, 'getPersonalExecutedInfo', 'D_STOCK_DATA', to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (13, 'getPersonalBreachedInfo', 'D_STOCK_DATA', to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (21, 'blackListCheck', 'D_BLACK_LIST_INFO', to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'blackListInfoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (22, 'illegalDetailCheck', 'D_CASE_ILLEGAL_DETAIL_INFO', to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'caseIllegalDetailInfoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (25, 'illegalCheck', 'D_CASE_ILLEGAL_INFO', to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'caseIllegalInfoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (23, 'queryRiskDegreeInfo', 'D_RISK_DEGREE_INFO', to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'queryRiskDegreeInfoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (24, 'queryOftenBorrowGuestInfo', 'D_OFTEN_BORROW_GUEST_INFO', to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'queryOftenBorrowGuestInfoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (37, 'queryAntiFraudRiskDegreeInfo', 'D_ANTI_FRAUD_RISK_DEGREE_INFO', to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:43', 'dd-mm-yyyy hh24:mi:ss'), 'oracle', 'queryAntiFraudRiskDegreeInfoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (38, 'environment/getPollutionCharge', 'D_STOCK_DATA', to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (26, 'environment/getEnviProNoStand', 'D_STOCK_DATA', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (27, 'environment/getAdminPenalty', 'D_STOCK_DATA', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (28, 'environment/getInspectHandling', 'D_STOCK_DATA', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (29, 'environment/getStressMonitor', 'D_STOCK_DATA', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (30, 'environment/getEnviCreditRank', 'D_STOCK_DATA', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (43, 'environment/getIllegalCase', 'D_STOCK_DATA', to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
insert into D_API_DATABASE_REL (id, api_id, table_name, create_time, update_time, database_type, process_bean)
values (44, 'environment/getOthers', 'D_STOCK_DATA', to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'mongo', 'mongoService');
commit;
prompt 30 records loaded
prompt Loading D_API_EXTERNAL_RESOURCE_REL...
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (1, 'identify/verifyID', 'custInfoPicVerify', '30', null, to_date('02-08-2016 12:31:42', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:31:42', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (2, 'identify/verifyID', 'jyVerifyIdentity', '40', null, to_date('02-08-2016 12:31:42', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:31:42', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (3, 'identify/verifyID', 'zeWeiVerifyIdentity', '20', null, to_date('09-08-2016 15:26:17', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:26:17', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (4, 'identify/verifyID', 'unionpayVerifyIdentity', '10', null, to_date('09-08-2016 15:26:17', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:26:17', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (5, 'identify/verifyIdMobile', 'zeWeiVerifyIdMobile', '1', null, to_date('09-08-2016 15:48:06', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:48:06', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (6, 'identify/verifyBankCard', 'jyVerifyBankCard', '30', null, to_date('09-08-2016 15:52:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:52:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (7, 'identify/verifyBankCard', 'zeWeiVerifyBankCard', '20', null, to_date('09-08-2016 15:52:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:52:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (8, 'identify/verifyBankCard', 'unionpayVerifyRelation', '10', null, to_date('09-08-2016 15:52:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:52:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (9, 'verifyPhoneBlacklist', 'payegisPhoneBlackList', '1', null, to_date('30-08-2016 17:39:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:39:46', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (10, 'verifyIsMocaWarehouse', 'chinaMobileQueryMocaWarehouse', '1', null, to_date('30-08-2016 17:39:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:39:46', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (33, 'environment/getPollutionCharge', 'getPollutionCharge', '1', '1', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (34, 'getCompanyBusInfo', 'getEntinfo', '1', '1', to_date('18-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (35, 'getCompanyLawsuitInfo', 'getLitigationDatas', '1', '1', to_date('18-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (11, 'querySingleEducation', 'asSingleEducation', '1', null, to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (12, 'getPersonalInvestmentInfo', 'asGetIcPersonalInfo', '1', '1', to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (13, 'getPersonalExecutedInfo', 'asGetExecutedInd2', '1', '1', to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (14, 'getPersonalBreachedInfo', 'asGetLostFaithInd2', '1', '1', to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (22, 'blackListCheck', 'xsBlackListCheck', '1', '1', to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:53', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (23, 'illegalDetailCheck', 'xsIllegalDetailCheck', '1', '1', to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (26, 'illegalCheck', 'xsIllegalCheck', '1', '1', to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (24, 'queryRiskDegreeInfo', 'asGetFXDInfo', '1', '1', to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (25, 'queryAntiFraudRiskDegreeInfo', 'asGetFQZFXDInfo', '1', '1', to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (27, 'queryOftenBorrowGuestInfo', 'asQueryCDKInfo', '1', '1', to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:54', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (28, 'environment/getEnviProNoStand', 'asGetEnviProNoStand', '1', '1', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (29, 'environment/getAdminPenalty', 'asGetAdminPenalty', '1', '1', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (30, 'environment/getInspectHandling', 'asGetInspectHandling', '1', '1', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (31, 'environment/getStressMonitor', 'asGetStressMonitor', '1', '1', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (32, 'environment/getEnviCreditRank', 'asGetEnviCreditRank', '1', '1', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (38, 'tax/abnormal', 'taxAbnormal', '1', '1', to_date('22-11-2016 16:32:23', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-11-2016 16:32:23', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (36, 'environment/getIllegalCase', 'getIllegalCase', '1', '1', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_API_EXTERNAL_RESOURCE_REL (id, api_id, resource_api_id, priority, call_rate, create_time, update_time, group_id)
values (37, 'environment/getOthers', 'getOthers', '1', '1', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
commit;
prompt 31 records loaded
prompt Loading D_API_INFO...
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (1, 'identify/verifyID', '核身简项认证', '1', null, '1', null, 'in', to_date('02-08-2016 12:25:52', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:25:52', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (2, 'identify/verifyIdMobile', '核身三联验证', '1', null, '1', null, 'in', to_date('09-08-2016 15:12:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:12:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (3, 'identify/verifyBankCard', '核身银行卡要素验证', '1', null, '1', null, 'in', to_date('09-08-2016 15:12:53', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:12:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (4, 'verifyPhoneBlacklist', '手机号码黑名单验证', '1', null, '1', null, 'in', to_date('30-08-2016 17:37:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:37:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (5, 'verifyIsMocaWarehouse', '中国移动疑似养卡库验证', '1', null, '1', null, 'in', to_date('30-08-2016 17:37:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:37:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (6, 'fingerPrint/sendDeviceData', '收集设备指纹信息', '1', null, '1', null, 'in', to_date('30-08-2016 17:50:23', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:50:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (7, 'fingerPrint/sendBusinessData', '接收移动端业务数据', '1', null, '1', null, 'in', to_date('30-08-2016 17:50:23', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:50:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (8, 'fingerPrint/getFingerPrintingId', '获取设备编号', '1', null, '1', null, 'in', to_date('30-08-2016 17:50:23', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:50:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (9, 'anti-fraud/decision', '反欺诈决策服务', '1', null, '1', null, 'in', to_date('26-09-2016 19:01:04', 'dd-mm-yyyy hh24:mi:ss'), to_date('26-09-2016 19:01:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (31, 'environment/getPollutionCharge', '排污收费信息', '1', null, '1', null, 'in', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (32, 'environment/getIllegalCase', '违法案件', '1', null, '1', null, 'in', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (33, 'environment/getOthers', '其他', '1', null, '1', null, 'in', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (10, 'querySingleEducation', '个人学历信息查询', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (11, 'getPersonalInvestmentInfo', '个人投资任职基本信息查询', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (12, 'getPersonalExecutedInfo', '个人被执行信息查询', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (13, 'getPersonalBreachedInfo', '个人失信被执行信息', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (25, 'illegalCheck', '不良信息查询', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (21, 'blackListCheck', '黑名单验证', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (22, 'illegalDetailCheck', '不良详情信息查询', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (20, 'queryRiskDegreeInfo', '风险度查询', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (23, 'queryAntiFraudRiskDegreeInfo', '反欺诈风险度认证查询', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (24, 'queryOftenBorrowGuestInfo', '常贷客查询', '1', null, '1', null, 'in', to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:51:59', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (41, 'getCompanyBusInfo', '企业工商信息', '1', null, '1', null, 'in', to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (42, 'getCompanyLawsuitInfo', '企业诉讼信息查询', '1', null, '1', null, 'in', to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (34, 'tax/abnormal', '税务-非正常户信息', '1', null, '1', null, 'in', to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (35, 'tax/illegal', '税务-涉税违法信息', '1', null, '1', null, 'in', to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (36, 'tax/urgency', '税务-纳税催报信息', '1', null, '1', null, 'in', to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (37, 'tax/bussinessSuspend', '税务-停业注销信息', '1', null, '1', null, 'in', to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (38, 'tax/credit', '税务-纳税信用查询', '1', null, '1', null, 'in', to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (39, 'tax/topHundreds', '税务-纳税百强信息', '1', null, '1', null, 'in', to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (40, 'tax/correct', '税务-责令期改信息', '1', null, '1', null, 'in', to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:24:46', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (26, 'environment/getEnviProNoStand', '环保-不达标信息查询', '1', null, '1', null, 'in', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (27, 'environment/getAdminPenalty', '环保-行政处罚信息查询', '1', null, '1', null, 'in', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (28, 'environment/getInspectHandling', '环保-挂牌督办信息查询', '1', null, '1', null, 'in', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (29, 'environment/getStressMonitor', '环保-国控重点企业名单信息查询', '1', null, '1', null, 'in', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_API_INFO (id, api_id, name, status, remark, category_code, useage_example, type, create_time, update_time)
values (30, 'environment/getEnviCreditRank', '环保-信用行为排名查询', '1', null, '1', null, 'in', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 36 records loaded
prompt Loading D_API_PARAM...
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (1, 'identify/verifyID', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('02-08-2016 12:26:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('02-08-2016 12:26:34', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (2, 'identify/verifyID', 'name', '用户姓名', 'input', 'String', null, 'Y', null, null, 'root', to_date('02-08-2016 12:26:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('02-08-2016 12:26:34', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (3, 'identify/verifyID', 'idCard', '用户身份证', 'input', 'String', null, 'Y', null, null, 'root', to_date('02-08-2016 12:26:34', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('02-08-2016 12:26:34', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (4, 'identify/verifyIdMobile', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('09-08-2016 15:14:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:14:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (5, 'identify/verifyIdMobile', 'name', '用户姓名', 'input', 'String', null, 'Y', null, null, 'root', to_date('09-08-2016 15:14:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:14:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (6, 'identify/verifyIdMobile', 'idCard', '用户身份证', 'input', 'String', null, 'Y', null, null, 'root', to_date('09-08-2016 15:14:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:14:19', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (7, 'identify/verifyIdMobile', 'phoneNo', '手机号', 'input', 'String', null, 'Y', null, null, 'root', to_date('09-08-2016 15:14:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:14:19', 'dd-mm-yyyy hh24:mi:ss'), 'phoneNo', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (8, 'identify/verifyBankCard', 'name', '用户姓名', 'input', 'String', null, null, null, null, 'root', to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (9, 'identify/verifyBankCard', 'idCard', '证件号码', 'input', 'String', null, null, null, null, 'root', to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (10, 'identify/verifyBankCard', 'idType', '证件类型', 'input', 'String', null, null, '0', null, 'root', to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (11, 'identify/verifyBankCard', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (12, 'identify/verifyBankCard', 'phoneNo', '电话号码', 'input', 'String', null, null, null, null, 'root', to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), 'phoneNo', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (13, 'identify/verifyBankCard', 'bankCard', '银行卡号', 'input', 'String', null, 'Y', null, null, 'root', to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), 'bankCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (14, 'identify/verifyBankCard', 'type', '验证类型', 'input', 'String', '验证类型，1：卡三要素验证 银行卡+姓名+身份证 2：卡四要素验证 银行卡+姓名+身份证+手机号 3：卡二要素 银行卡+姓名 4：卡二要素 银行卡+手机号', 'Y', null, null, 'root', to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('09-08-2016 15:18:32', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (15, 'verifyPhoneBlacklist', 'type', '查询类型', 'input', 'String', null, null, 'C', null, 'root', to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (16, 'verifyPhoneBlacklist', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), 'authCode', null, to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (17, 'verifyPhoneBlacklist', 'phoneNo', '手机号', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), 'phoneNo', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (18, 'verifyIsMocaWarehouse', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), 'authCode', null, to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (19, 'verifyIsMocaWarehouse', 'phoneNo', '手机号', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:38:33', 'dd-mm-yyyy hh24:mi:ss'), 'phoneNo', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (20, 'fingerPrint/sendDeviceData', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), 'appKey', null, to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (21, 'fingerPrint/sendDeviceData', 'deviceId', '存储在移动的虚拟设备ID', 'input', 'String', null, 'N', null, null, 'root', to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (22, 'fingerPrint/sendDeviceData', 'deviceType', '设备类型', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (23, 'fingerPrint/sendDeviceData', 'deviceData', '设备指纹信息', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (24, 'fingerPrint/sendBusinessData', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (25, 'fingerPrint/sendBusinessData', 'blackBox', '存储在移动端的设备信息', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (26, 'fingerPrint/sendBusinessData', 'businessData', '业务数据，json字符串', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (27, 'fingerPrint/getFingerPrintingId', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (28, 'fingerPrint/getFingerPrintingId', 'blackBox', '存储在移动端的设备信息', 'input', 'String', null, 'Y', null, null, 'root', to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('30-08-2016 17:51:46', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (29, 'anti-fraud/decision', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (30, 'anti-fraud/decision', 'scenarioId', '场景标识', 'input', 'String', null, 'Y', null, null, 'root', to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (31, 'anti-fraud/decision', 'eventId', '事件标识', 'input', 'String', null, 'Y', null, null, 'root', to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (32, 'anti-fraud/decision', 'occurTime', '事件发生时间', 'input', 'String', null, 'Y', null, null, 'root', to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (33, 'anti-fraud/decision', 'userAccount', '用户账号', 'input', 'String', null, 'N', null, null, 'root', to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (34, 'anti-fraud/decision', 'ipAddress', '用户IP地址', 'input', 'String', null, 'Y', null, null, 'root', to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (35, 'anti-fraud/decision', 'fingerPrint', '用户设备标识', 'input', 'String', null, 'N', null, null, 'root', to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (36, 'anti-fraud/decision', 'exParameter', '业务数据', 'input', 'String', null, 'N', null, null, 'root', to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (37, 'anti-fraud/decision', 'blackBox', '用户设备标识', 'input', 'String', null, 'N', null, null, 'root', to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('26-09-2016 19:02:21', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (164, 'environment/getPollutionCharge', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (165, 'environment/getPollutionCharge', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (166, 'environment/getPollutionCharge', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (167, 'environment/getPollutionCharge', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (188, 'environment/getPollutionCharge', 'beginDate', '查询开始时间', 'input', 'String', 'yyyy/mm/dd', 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (190, 'environment/getEnviCreditRank', 'beginDate', '查询开始时间', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (191, 'environment/getEnviProNoStand', 'beginDate', '查询开始时间', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (192, 'environment/getAdminPenalty', 'beginDate', '查询开始时间', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (193, 'environment/getInspectHandling', 'beginDate', '查询开始时间', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (194, 'environment/getStressMonitor', 'beginDate', '查询开始时间', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (177, 'getCompanyBusInfo', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (178, 'getCompanyBusInfo', 'entNameOrNo', '企业名称或注册号', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (179, 'getCompanyLawsuitInfo', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (180, 'getCompanyLawsuitInfo', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (181, 'getCompanyLawsuitInfo', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (182, 'getCompanyLawsuitInfo', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (183, 'getCompanyLawsuitInfo', 'ptype', '公告类型', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (184, 'tax/abnormal', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('21-11-2016 10:18:44', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('21-11-2016 10:18:44', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (185, 'tax/abnormal', 'taxPayerName', '纳税人名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('21-11-2016 10:18:44', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('21-11-2016 10:18:44', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (186, 'tax/abnormal', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('21-11-2016 10:18:44', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('21-11-2016 10:18:44', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (187, 'tax/abnormal', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('21-11-2016 10:18:44', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('21-11-2016 10:18:44', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (38, 'querySingleEducation', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:18', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (39, 'querySingleEducation', 'name', '姓名', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:18', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:18', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (40, 'querySingleEducation', 'idCard', '身份证', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (41, 'getPersonalInvestmentInfo', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (42, 'getPersonalInvestmentInfo', 'idCard', '身份证', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (43, 'getPersonalExecutedInfo', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (44, 'getPersonalExecutedInfo', 'idCard', '身份证号码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (45, 'getPersonalExecutedInfo', 'name', '被执行人名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (46, 'getPersonalBreachedInfo', 'name', '姓名', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (47, 'getPersonalBreachedInfo', 'idCard', '身份证号码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (48, 'getPersonalBreachedInfo', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (111, 'illegalCheck', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (112, 'illegalCheck', 'idCard', '用户身份证', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (110, 'illegalCheck', 'name', '用户姓名', 'input', 'input', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (83, 'blackListCheck', 'phoneNo', '手机号码', 'input', 'input', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), 'phoneNo', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (80, 'blackListCheck', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (81, 'blackListCheck', 'idCard', '用户身份证', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (82, 'blackListCheck', 'name', '用户姓名', 'input', 'input', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (90, 'illegalDetailCheck', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:19', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (91, 'illegalDetailCheck', 'idCard', '用户身份证', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), 'idCard', null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (92, 'illegalDetailCheck', 'name', '用户姓名', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (72, 'queryRiskDegreeInfo', 'idNo', '证件号码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (73, 'queryRiskDegreeInfo', 'idType', '证件', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (74, 'queryRiskDegreeInfo', 'name', '姓名', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (75, 'queryRiskDegreeInfo', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (93, 'queryRiskDegreeInfo', 'ips', 'IP集', 'input', 'String', null, null, null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (94, 'queryRiskDegreeInfo', 'cardNos', '卡号集', 'input', 'String', null, null, null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (95, 'queryRiskDegreeInfo', 'moblieNos', '手机号码集', 'input', 'String', null, null, null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (96, 'queryRiskDegreeInfo', 'entityAuthCode', '信息主体授权码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (97, 'queryRiskDegreeInfo', 'entityAuthDate', '信息主体授权时间', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (126, 'queryAntiFraudRiskDegreeInfo', 'entityAuthDate', '信息主体授权时间', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (125, 'queryAntiFraudRiskDegreeInfo', 'entityAuthCode', '信息主体授权码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (124, 'queryAntiFraudRiskDegreeInfo', 'name', '姓名', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (123, 'queryAntiFraudRiskDegreeInfo', 'idType', '证件', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (122, 'queryAntiFraudRiskDegreeInfo', 'idNo', '证件号码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (127, 'queryAntiFraudRiskDegreeInfo', 'reasonNo', '查询原因', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (128, 'queryAntiFraudRiskDegreeInfo', 'phoneNo', '手机号码', 'input', 'String', null, null, null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (129, 'queryAntiFraudRiskDegreeInfo', 'ipAddress', 'IP地址', 'input', 'String', null, null, null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (102, 'queryOftenBorrowGuestInfo', 'entityAuthDate', '信息主体授权时间', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (101, 'queryOftenBorrowGuestInfo', 'entityAuthCode', '信息主体授权码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (99, 'queryOftenBorrowGuestInfo', 'idType', '证件', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (98, 'queryOftenBorrowGuestInfo', 'idNo', '证件号码', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
commit;
prompt 100 records committed...
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (100, 'queryOftenBorrowGuestInfo', 'name', '姓名', 'input', 'String', null, 'Y', null, null, 'root', to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('16-11-2016 16:52:20', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (130, 'environment/getEnviProNoStand', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (131, 'environment/getEnviProNoStand', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (132, 'environment/getEnviProNoStand', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (133, 'environment/getEnviProNoStand', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (174, 'tax/correct', 'taxPayerName', '纳税人名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('18-11-2016 10:23:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('18-11-2016 10:23:50', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (175, 'tax/correct', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('18-11-2016 10:23:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('18-11-2016 10:23:50', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (176, 'tax/correct', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('18-11-2016 10:23:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('18-11-2016 10:23:50', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (210, 'getCompanyLawsuitInfo', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2017', 'dd-mm-yyyy'), null, null, to_date('17-11-2017', 'dd-mm-yyyy'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (211, 'getCompanyLawsuitInfo', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2017', 'dd-mm-yyyy'), null, null, to_date('17-11-2017', 'dd-mm-yyyy'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (140, 'environment/getAdminPenalty', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (141, 'environment/getAdminPenalty', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (142, 'environment/getAdminPenalty', 'getCompanyLawsuitInfo', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (143, 'environment/getAdminPenalty', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (150, 'environment/getInspectHandling', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (151, 'environment/getInspectHandling', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (152, 'environment/getInspectHandling', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (153, 'environment/getInspectHandling', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (160, 'environment/getStressMonitor', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (161, 'environment/getStressMonitor', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (162, 'environment/getStressMonitor', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (163, 'environment/getStressMonitor', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (170, 'environment/getEnviCreditRank', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (171, 'environment/getEnviCreditRank', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (172, 'environment/getEnviCreditRank', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (173, 'environment/getEnviCreditRank', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2017 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (200, 'environment/getIllegalCase', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (201, 'environment/getIllegalCase', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (202, 'environment/getIllegalCase', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (203, 'environment/getIllegalCase', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (204, 'environment/getIllegalCase', 'beginDate', '查询开始时间', 'input', 'String', 'yyyy/mm/dd', 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (205, 'environment/getOthers', 'authCode', '授权代码', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (206, 'environment/getOthers', 'entName', '企业名称', 'input', 'String', null, 'Y', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (207, 'environment/getOthers', 'province', '省份', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (208, 'environment/getOthers', 'city', '城市', 'input', 'String', null, 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
insert into D_API_PARAM (id, api_id, param_id, name, type, data_type, remark, must, qualifier, single, parent_id, create_time, source_param, group_id, update_time, rule_id, json_path)
values (209, 'environment/getOthers', 'beginDate', '查询开始时间', 'input', 'String', 'yyyy/mm/dd', 'N', null, null, 'root', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null, null);
commit;
prompt 136 records loaded
prompt Loading D_DATA_RESOURCE...
insert into D_DATA_RESOURCE (id, name, protocol, net_type, server_ip, port, create_time, update_time, resource_id)
values (1, '中国移动', 'https', '公网', null, null, to_date('02-08-2016 12:35:07', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:35:07', 'dd-mm-yyyy hh24:mi:ss'), 'chinamobile');
insert into D_DATA_RESOURCE (id, name, protocol, net_type, server_ip, port, create_time, update_time, resource_id)
values (2, '上海骏聿', 'https', '公网', null, null, to_date('02-08-2016 12:35:08', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:35:08', 'dd-mm-yyyy hh24:mi:ss'), 'junyu');
insert into D_DATA_RESOURCE (id, name, protocol, net_type, server_ip, port, create_time, update_time, resource_id)
values (3, '上海泽维', 'http', '公网', null, null, to_date('09-08-2016 15:29:58', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:29:58', 'dd-mm-yyyy hh24:mi:ss'), 'zewei');
insert into D_DATA_RESOURCE (id, name, protocol, net_type, server_ip, port, create_time, update_time, resource_id)
values (4, '银联智惠', 'https', '公网', null, null, to_date('09-08-2016 15:29:58', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:29:58', 'dd-mm-yyyy hh24:mi:ss'), 'unionpaysmart');
insert into D_DATA_RESOURCE (id, name, protocol, net_type, server_ip, port, create_time, update_time, resource_id)
values (5, '通付盾', 'https', '公网', null, null, to_date('30-08-2016 17:41:20', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:41:20', 'dd-mm-yyyy hh24:mi:ss'), 'payegis');
insert into D_DATA_RESOURCE (id, name, protocol, net_type, server_ip, port, create_time, update_time, resource_id)
values (6, '小视科技', 'http', '公网', null, '80', to_date('28-10-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-10-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'xiaoshi');
insert into D_DATA_RESOURCE (id, name, protocol, net_type, server_ip, port, create_time, update_time, resource_id)
values (7, '安硕信息', 'http', '公网', null, '80', to_date('09-10-2016', 'dd-mm-yyyy'), to_date('09-10-2016', 'dd-mm-yyyy'), 'anshuo');
commit;
prompt 7 records loaded
prompt Loading D_DATA_RESOURCE_API...
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (1, '中移动身份证查验接口', 'custInfoPicVerify', 'chinamobile', 'chinamobile', 'https://api.realnameonline.cn:24200/smz-resapi/restservice/custInfoPicVerify', 'out', null, to_date('02-08-2016 12:43:09', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:43:09', 'dd-mm-yyyy hh24:mi:ss'), 'chinaMobileSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (2, '骏聿简项查询', 'jyVerifyIdentity', 'junyu', 'junyu', 'https://120.92.191.86:843/CompareInterfaceService/services/JYWebservice', 'out', null, to_date('02-08-2016 12:51:24', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:51:24', 'dd-mm-yyyy hh24:mi:ss'), 'junYuCheckSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (3, '泽维三联验证', 'zeWeiVerifyIdMobile', 'zewei', 'zewei', null, 'out', null, to_date('09-08-2016 15:33:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:33:37', 'dd-mm-yyyy hh24:mi:ss'), 'zeWeiVerifyIdMobileServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (4, '骏聿银行卡验证', 'jyVerifyBankCard', 'junyu', 'junyu', 'https://120.92.191.86:944/AuthInterfaceService/services/JYWebservice', 'out', null, to_date('09-08-2016 15:36:23', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:36:23', 'dd-mm-yyyy hh24:mi:ss'), 'junYuBankCardSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (5, '泽维简项验证', 'zeWeiVerifyIdentity', 'zewei', 'zewei', 'http://tt.taoyer.cn/zwOpen/interface/isRightFX', 'out', null, to_date('09-08-2016 15:37:11', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:37:11', 'dd-mm-yyyy hh24:mi:ss'), 'zeWeiVerifyIDSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (6, '泽维卡要素验证', 'zeWeiVerifyBankCard', 'zewei', 'zewei', null, 'out', null, to_date('09-08-2016 15:39:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:39:01', 'dd-mm-yyyy hh24:mi:ss'), 'zeWeiVerifyBankCardServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (7, '银联简项认证', 'unionpayVerifyIdentity', 'unionpaysmart', 'unionpaysmart', 'https://data.unionpaysmart.com/auth/valid', 'out', null, to_date('09-08-2016 15:40:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:40:34', 'dd-mm-yyyy hh24:mi:ss'), 'unionpaySourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (8, '银联智惠卡要素验证', 'unionpayVerifyRelation', 'unionpaysmart', 'unionpaysmart', 'https://data.unionpaysmart.com/auth/valid', 'out', null, to_date('09-08-2016 15:40:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:40:34', 'dd-mm-yyyy hh24:mi:ss'), 'unionpaySourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (9, '通付盾手机黑名单查询', 'payegisPhoneBlackList', 'payegis', 'payegis', 'https://pws.payegis.com.cn/id_creditcardapi/blacklist/phoneBlackList', 'out', null, to_date('30-08-2016 17:42:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:42:59', 'dd-mm-yyyy hh24:mi:ss'), 'payegisSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (10, '中移动疑似养卡库接口认证', 'chinaMobileQueryMocaWarehouse', 'chinamobile', 'chinamobile', 'https://api.realnameonline.cn:24200/smz-resapi/restservice/queryMocaWarehouse', 'out', null, to_date('30-08-2016 17:42:59', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:42:59', 'dd-mm-yyyy hh24:mi:ss'), 'chinaMobileSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (32, '环保--排污收费信息', 'getPollutionCharge', 'anshuo', 'anshuo', 'http://www.amarsoft.com/dataservice/getPollutionCharge', 'out', null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (11, '安硕个人学历信息', 'asSingleEducation', 'anshuo', 'anshuo', 'http://www.amarsoft.com/dataservice/querySingleEducation', 'out', null, to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (12, '安硕个人投资任职基本信息查询', 'asGetIcPersonalInfo', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getIcPersonalInfo', 'out', null, to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (13, '安硕个人被执行人查询接口', 'asGetExecutedInd2', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getExecutedInd2', 'out', null, to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (14, '安硕个人失信被执行人接口', 'asGetLostFaithInd2', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getLostFaithInd2', 'out', null, to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (25, '小视不良信息验证', 'xsIllegalCheck', 'xiaoshi', 'xiaoshi', 'https://www.miniscores.cn:8313/CreditFunc/v2.1/IllegalCheck', 'out', null, to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), 'xiaoShiSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (21, '小视黑名单验证', 'xsBlackListCheck', 'xiaoshi', 'xiaoshi', 'https://www.miniscores.cn:8313/CreditFunc/v2.1/BlackListCheck', 'out', null, to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), 'xiaoShiSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (22, '小视不良详情信息查询', 'xsIllegalDetailCheck', 'xiaoshi', 'xiaoshi', 'https://www.miniscores.cn:8313/CreditFunc/v2.1/IllegalDetailCheck', 'out', null, to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), 'xiaoShiSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (23, '安硕风险度查询', 'asGetFXDInfo', 'anshuo', 'anshuo', 'http://www.amarsoft.com/dataservice/getFXD2Info', 'out', null, to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:31', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (24, '安硕常贷客信息查询', 'asQueryCDKInfo', 'anshuo', 'anshuo', 'http://www.amarsoft.com/dataservice/queryCDKInfo', 'out', null, to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (26, '反欺诈风险度认证查询', 'asGetFQZFXDInfo', 'anshuo', 'anshuo', 'http://www.amarsoft.com/dataservice/getFQZFXDInfo', 'out', null, to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (31, '环保--环保不达标', 'asGetEnviProNoStand', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getEnviProNoStand', 'out', null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (28, '环保--行政处罚', 'asGetAdminPenalty', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getAdminPenalty', 'out', null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (27, '环保--挂牌督办', 'asGetInspectHandling', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getInspectHandling', 'out', null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (29, '环保--国控重点企业名单', 'asGetStressMonitor', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getStressMonitor', 'out', null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (30, '环保--环境信用行为排名', 'asGetEnviCreditRank', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getEnviCreditRank', 'out', null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (34, '安硕企业工商信息查询 ', 'getEntinfo', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getEntinfo', 'out', null, to_date('18-11-2016 19:23:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 19:23:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (35, '安硕诉讼数据查询接口', 'getLitigationDatas', 'anshuo', 'anshuo', 'https://www.amarsoft.com/dataservice/getLitigationDatas', 'out', null, to_date('18-11-2016 19:23:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 19:23:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (33, '税务--非正常户', 'taxAbnormal', 'anshuo', 'anshuo', 'http://www.amarsoft.com/dataservice/getTaxAbnormal', 'out', null, to_date('17-11-2016 19:23:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 19:23:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (36, '环保--违法案件', 'getIllegalCase', 'anshuo', 'anshuo', 'http://www.amarsoft.com/dataservice/getIllegalCase', 'out', null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
insert into D_DATA_RESOURCE_API (id, name, resource_api_id, resource_id, vendor_id, url, type, useage_example, create_time, update_time, bean_name)
values (37, '环保--其他(污染隐患大排查、环境检查整治表）', 'getOthers', 'anshuo', 'anshuo', 'http://www.amarsoft.com/dataservice/getOthers', 'out', null, to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), 'anShuoSourceServiceImpl');
commit;
prompt 31 records loaded
prompt Loading D_DATA_RESOURCE_API_PARAM...
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (1, 'custInfoPicVerify', 'userId', '用户名', 'input', 'String', 'y', 'KSZJsh', null, 'userId', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (2, 'custInfoPicVerify', 'userPwd', '密码', 'input', 'String', 'y', 'XTIyGEmVP', null, 'userPwd', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (3, 'custInfoPicVerify', 'idCard', '身份证号', 'input', 'String', 'y', null, null, 'custCertNo', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (4, 'custInfoPicVerify', 'name', '姓名', 'input', 'String', 'y', null, null, 'custName', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (5, 'custInfoPicVerify', 'secretKey', '报文加密密钥', 'input', 'String', 'y', 'YgE~F$I', null, 'secretKey', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (6, 'custInfoPicVerify', 'singnatureKey', '私钥', 'input', 'String', 'y', 'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCF90OofLMJZkoA/dvYjy+7G5Lx8H1MmEA6p/Wm0DnrlsnIdiPkKSiEgSq3wsOoRM94gR8WubxFqQ6Rcp/o+8pfKUokw797s+Qq8HMyZ5WPGYniJwI+iqMd91A8ahntoAgscZrU02XqX/5WGx0v+9VoYR8SrJRJyxqvJRgc+/Om/maOwewZIEy40Vl0Zl7ctXBiTLVokGnhMM7RwMAD42bXIgPoKkIB4PZwhUtqLhJIwVIWZkwAv1mHcIJXMIihfteXA95uGJddgDiyoiWXpq/FdwT2rXXvpwtyN6AxpTXxMJ7DgIbom68vGbIiaYFnwEDDA14e7s9VqVuAWzRh4oBjAgMBAAECggEAQsxGGi8Dfr5YTCJIirTq0dsv7B9D+vs3m4fAP0s4djYbqy7tOokjQN6/FB2zPaYB5U5M2CIItJtVPkTvY1aZU9XcuHQ6eE38iUSXzBxGQLI1RGS7A8BREVIN2fH1t7zCFpcW4uP9v13aDck7Rn/Fq2QyADe5QQpa5dYTLfCbTzp04CBVGg1vKXgCcxqeipzwxsns3EefDTf9ZL5mPIqYA9WAtHDzQnbIu9G05Vi8AP6gSDZIrVBMHeO1J05Q9NRev2GZvSLuimiGwfSFsFUil1Qey7N5ru9eQ9N74IS5a4TbN+MTrVtDLfAIE2B9VLr/ZqX/9M7Z0W2DF/ydBca9YQKBgQDOFQCsSodo+aWXZnmO5qjtD88BeaqMYk3WcIFpMO0YhebjV/KPpVB3f2Dw4Q/yRyW9GgPoMzAalL0WxZKn1Cl/dy1Ras7k9S5543yFP/obfsGrBgXUuEtWg/LCniInUOS3L7V7aRUQYnW8YiDW9h9kY1AaLz04GbRn0+ZXb3JcqwKBgQCmamQHznO3LgdcoGGm0qiqVncX/Na0LCa2yakrRnXa4za8Zeah9jRv0U0VvqR/yX7ePjeL5o7f03HLVu2sYi9aQdXCNzjfOSZyCDMulfq9Yq+Zpc51v/mpl+ilU/Uq+7+nfT6ZnpaU81C7NE0cJyPUMqjLXU0LSP92BRvISyL7KQKBgQDFfo80jgAS9BxjaYtZDWgaN6o0SbrN6m+Z8Bu1CXROqhRJD0Gfs9fXjTUD40v67YAXJ1VTM6sH7j8AEbuoJsTWKQo/GlLITMeLfB0bPeKccu96zLzNzQg2EyGUrSMh9n4ZqBkN+fh7yT/3lzrNhvUyqZJcZaUPnGKtlf8LD/zTHQKBgEaId0c7wJ3WG3at31W2mZhAt49qMZIB2JLGnDXkUlVo0i09v2fME2OFQXfC6rPisiv+EMrx+IJzexqlCG102/8UQkZj423xKhNQ2GiZVsHoTub/eKc9q9KuuQNBt3r1YsDZe6vepJITIpeFzlztVek9Y392Vw4+bVAXUDQvbG8pAoGBAMkzWkM8DjLEWsUrzS7n7UHV5FdzgV643bnSLbWe03/POMQAFQAkas0upyKOwx+NZDqhAYqCcJhWjx+ccimg7dySIlk7qtLa8GH8vhZi2HwMCimakWFCGY3qOZu/zDJJhy3GdQHHf21IxObegLIoq1LxZJbXoLEG0nAZawbqLHDd', null, 'singnatureKey', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (7, 'custInfoPicVerify', 'requestSource', '请求源', 'input', 'String', 'y', '210224', null, 'requestSource', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (8, 'custInfoPicVerify', 'busiCode', '业务码', 'input', 'String', 'y', 'custInfoPicVerify', null, 'busiCode', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (9, 'custInfoPicVerify', 'retCode', '返回码', 'output', 'String', 'y', null, null, '$.returnCode', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (10, 'custInfoPicVerify', 'valid', '验证结果', 'output', 'int', 'y', null, null, '$.bean.checkResult', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.valid');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (11, 'custInfoPicVerify', 'reason', '不一致原因', 'output', 'String', 'y', null, null, '$.returnMessage', to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:40:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.reason');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (12, 'jyVerifyIdentity', 'name', '姓名', 'input', 'String', 'y', null, null, 'strName', to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (13, 'jyVerifyIdentity', 'idCard', '身份证', 'input', 'String', 'y', null, null, 'strId', to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (14, 'jyVerifyIdentity', 'strAppKey', '签名key', 'input', 'String', 'y', '94854CA2DD0FE2F82C69B39DACB515BC', null, 'strAppKey', to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (15, 'jyVerifyIdentity', 'strAppSecret', '签名Secret', 'input', 'String', 'y', '19b8958d2d5addfa97ced32859f9ce20', null, 'strAppSecret', to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (16, 'jyVerifyIdentity', 'retCode', '返回码', 'output', 'String', 'y', null, null, '$.code', to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (17, 'jyVerifyIdentity', 'retMsg', '返回信息', 'output', 'String', 'y', null, null, '$.info', to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (18, 'jyVerifyIdentity', 'data', '返回数据', 'output', 'JSONObject', 'y', null, null, '$.data', to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (19, 'jyVerifyIdentity', 'valid', '匹配码', 'output', 'String', null, null, null, null, to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.valid');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (20, 'jyVerifyIdentity', 'reason', '匹配原因', 'output', 'String', null, null, null, null, to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 12:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.reason');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (21, 'zeWeiVerifyIdentity', 'appCode', '渠道号', 'input', 'String', 'Y', 'SH009', null, 'appcode', to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (22, 'zeWeiVerifyIdentity', 'idCard', '身份证', 'input', 'String', 'Y', null, null, 'certificateCode', to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (23, 'zeWeiVerifyIdentity', 'name', '姓名', 'input', 'String', 'Y', null, null, 'custName', to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (24, 'zeWeiVerifyIdentity', 'key', '加密key', 'input', 'String', 'Y', 'ZW_jMiHWiYo947qSnwrZ', null, 'key', to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (25, 'zeWeiVerifyIdentity', 'sign', '签名', 'input', 'String', 'Y', null, null, 'sign', to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (26, 'zeWeiVerifyIdentity', 'retCode', '返回码', 'output', 'String', null, null, null, '$.errorCode', to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (27, 'zeWeiVerifyIdentity', 'retMsg', '返回消息', 'output', 'String', null, null, null, null, to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (28, 'zeWeiVerifyIdentity', 'valid', '匹配码', 'output', 'String', null, null, null, '$.ISR', to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), '$.data.valid');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (29, 'zeWeiVerifyIdentity', 'reason', '不匹配原因', 'output', 'String', null, null, null, null, to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:42:55', 'dd-mm-yyyy hh24:mi:ss'), '$.data.reason');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (30, 'unionpayVerifyIdentity', 'valid', '匹配码', 'output', 'String', null, null, null, '$.stat', to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), '$.data.valid');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (31, 'unionpayVerifyIdentity', 'account', '用户账号', 'input', 'String', 'Y', '870817', null, 'account', to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (32, 'unionpayVerifyIdentity', 'type', '认证方式', 'input', 'String', 'Y', '5', null, 'type', to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (33, 'unionpayVerifyIdentity', 'sign', '签名', 'input', 'String', 'Y', null, null, 'sign', to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (34, 'unionpayVerifyIdentity', 'name', '姓名', 'input', 'String', 'Y', null, null, 'name', to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (35, 'unionpayVerifyIdentity', 'idCard', '身份证号', 'input', 'String', 'Y', null, null, 'cid', to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (36, 'unionpayVerifyIdentity', 'retCode', '返回码', 'output', 'String', null, null, null, '$.stat', to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (37, 'unionpayVerifyIdentity', 'privateKey', '私钥', 'input', 'String', 'Y', '072e6faa534440e6a2a048592a2b35e2', null, 'privateKey', to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (38, 'unionpayVerifyIdentity', 'reason', '不一致原因', 'output', 'String', null, null, null, '$.resMsg', to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:45:25', 'dd-mm-yyyy hh24:mi:ss'), '$.data.reason');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (39, 'unionpayVerifyRelation', 'valid', '匹配码', 'output', 'String', null, null, null, '$.stat', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), '$.data.valid');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (40, 'unionpayVerifyRelation', 'account', '用户账号', 'input', 'String', 'Y', '870817', null, 'account', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (41, 'unionpayVerifyRelation', 'type', '认证方式', 'input', 'String', 'Y', null, null, 'type', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (42, 'unionpayVerifyRelation', 'sign', '签名', 'input', 'String', 'Y', null, null, 'sign', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (43, 'unionpayVerifyRelation', 'bankCard', '银行卡全卡号', 'input', 'String', null, null, null, 'card', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (44, 'unionpayVerifyRelation', 'name', '姓名', 'input', 'String', null, null, null, 'name', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (45, 'unionpayVerifyRelation', 'phoneNo', '手机号', 'input', 'String', null, null, null, 'mobile', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (46, 'unionpayVerifyRelation', 'idCard', '身份证号', 'input', 'String', null, null, null, 'cid', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (47, 'unionpayVerifyRelation', 'retCode', '返回码', 'output', 'String', null, null, null, '$.stat', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (48, 'unionpayVerifyRelation', 'privateKey', '私钥', 'input', 'String', 'Y', '072e6faa534440e6a2a048592a2b35e2', null, 'privateKey', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (49, 'unionpayVerifyRelation', 'reason', '不一致原因', 'output', 'String', null, null, null, '$.resMsg', to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 15:55:44', 'dd-mm-yyyy hh24:mi:ss'), '$.data.reason');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (50, 'jyVerifyBankCard', 'three_type', '三要素接口类型', 'input', 'String', 'y', '15', null, 'three_type', to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (51, 'jyVerifyBankCard', 'three_license_code', '三要素签名key', 'input', 'String', 'y', '9AAA78E126CC4568B5666C9102140181', null, 'three_license_code', to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (52, 'jyVerifyBankCard', 'three_strAppSecret', '三要素签名Secret', 'input', 'String', 'y', 'b8779609961d17d08ec3fa7ea4ed33acd1577489', null, 'three_strAppSecret', to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (53, 'jyVerifyBankCard', 'phoneNo', '电话号码', 'input', 'String', null, null, null, 'cellPhoneNumber', to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (54, 'jyVerifyBankCard', 'bankCard', '卡号', 'input', 'String', 'y', null, null, 'cardbigint', to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (55, 'jyVerifyBankCard', 'retMsg', '返回信息', 'output', 'String', 'y', null, null, '$.info', to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (56, 'jyVerifyBankCard', 'data', '返回数据', 'output', 'JSONObject', 'y', null, null, '$.data', to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (57, 'jyVerifyBankCard', 'valid', '匹配码', 'output', 'String', null, null, null, null, to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), '$.data.valid');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (58, 'jyVerifyBankCard', 'reason', '匹配原因', 'output', 'String', null, null, null, null, to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), '$.data.reason');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (59, 'jyVerifyBankCard', 'idCard', '身份证', 'input', 'String', null, null, null, 'identityNumber', to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:14', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (60, 'jyVerifyBankCard', 'name', '姓名', 'input', 'String', 'y', null, null, 'personName', to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (61, 'jyVerifyBankCard', 'idType', '证件类型', 'input', 'String', null, '0', null, 'identityType', to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (62, 'jyVerifyBankCard', 'four_type', '四要素接口类型', 'input', 'String', 'y', '16', null, 'four_type', to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (63, 'jyVerifyBankCard', 'four_license_code', '四要素签名key', 'input', 'String', 'y', '2ACA0F6705DE493EA0B49584ABB7BB2C', null, 'four_license_code', to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (64, 'jyVerifyBankCard', 'four_strAppSecret', '四要素签名Secret', 'input', 'String', 'y', 'ef468d3502c52afb71f577e19ab3a1ce1c4420fc', null, 'four_strAppSecret', to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (65, 'jyVerifyBankCard', 'retCode', '返回码', 'output', 'String', 'y', null, null, '$.code', to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (66, 'jyVerifyBankCard', 'type', '验证类型', 'input', 'String', 'y', null, null, 'type', to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 18:47:15', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (67, 'custInfoPicVerify', 'isCheckValiddate', '是否验证身份证有效期', 'input', 'String', 'y', '0', null, 'isCheckValiddate', to_date('30-08-2016 17:36:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:36:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (68, 'custInfoPicVerify', 'needStaffCheck', '是否需要人工审核', 'input', 'String', 'y', '0', null, 'needStaffCheck', to_date('30-08-2016 17:36:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:36:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (69, 'custInfoPicVerify', 'isInterfaceCombination', '是否联合使用接口', 'input', 'String', 'y', '0', null, 'isInterfaceCombination', to_date('30-08-2016 17:36:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:36:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (70, 'payegisPhoneBlackList', 'type', '查询列表', 'input', 'String', 'y', null, null, 'queryList', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (71, 'payegisPhoneBlackList', 'valid', '匹配码', 'output', 'String', null, null, null, '$.isBlack', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), '$.data.valid');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (72, 'payegisPhoneBlackList', 'type', '查询列表', 'output', 'String', null, null, null, '$.queryList', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), '$.data.queryList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (73, 'payegisPhoneBlackList', 'phoneNo', '手机号', 'input', 'String', null, null, null, 'phone', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), '$.phone');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (74, 'payegisPhoneBlackList', 'isBlack', '手机号码是黑名单', 'output', 'String', null, null, null, 'isBlack', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), '$.isBlack');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (75, 'payegisPhoneBlackList', 'retCode', '返回码', 'output', 'String', null, null, null, '$.statCode', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (76, 'payegisPhoneBlackList', 'appKey', 'AppKey', 'input', 'String', 'y', 'c2d21bb4-7b3f-4b3b-9a26-a72b1190e5b0', null, 'appKey', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (77, 'payegisPhoneBlackList', 'appId', 'AppID', 'input', 'String', 'y', '6kycd59', null, 'appId', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (78, 'payegisPhoneBlackList', 'customSource', '黑名单泄露源', 'output', 'String', null, null, null, '$.customSource', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), '$.data.customSource');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (79, 'chinaMobileQueryMocaWarehouse', 'retCode', '返回码', 'output', 'String', 'y', null, null, '$.returnCode', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (80, 'chinaMobileQueryMocaWarehouse', 'valid', '验证结果', 'output', 'int', 'y', null, null, '$.bean.compareResult', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), '$.data.valid');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (81, 'chinaMobileQueryMocaWarehouse', 'singnatureKey', '私钥', 'input', 'String', 'y', 'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCF90OofLMJZkoA/dvYjy+7G5Lx8H1MmEA6p/Wm0DnrlsnIdiPkKSiEgSq3wsOoRM94gR8WubxFqQ6Rcp/o+8pfKUokw797s+Qq8HMyZ5WPGYniJwI+iqMd91A8ahntoAgscZrU02XqX/5WGx0v+9VoYR8SrJRJyxqvJRgc+/Om/maOwewZIEy40Vl0Zl7ctXBiTLVokGnhMM7RwMAD42bXIgPoKkIB4PZwhUtqLhJIwVIWZkwAv1mHcIJXMIihfteXA95uGJddgDiyoiWXpq/FdwT2rXXvpwtyN6AxpTXxMJ7DgIbom68vGbIiaYFnwEDDA14e7s9VqVuAWzRh4oBjAgMBAAECggEAQsxGGi8Dfr5YTCJIirTq0dsv7B9D+vs3m4fAP0s4djYbqy7tOokjQN6/FB2zPaYB5U5M2CIItJtVPkTvY1aZU9XcuHQ6eE38iUSXzBxGQLI1RGS7A8BREVIN2fH1t7zCFpcW4uP9v13aDck7Rn/Fq2QyADe5QQpa5dYTLfCbTzp04CBVGg1vKXgCcxqeipzwxsns3EefDTf9ZL5mPIqYA9WAtHDzQnbIu9G05Vi8AP6gSDZIrVBMHeO1J05Q9NRev2GZvSLuimiGwfSFsFUil1Qey7N5ru9eQ9N74IS5a4TbN+MTrVtDLfAIE2B9VLr/ZqX/9M7Z0W2DF/ydBca9YQKBgQDOFQCsSodo+aWXZnmO5qjtD88BeaqMYk3WcIFpMO0YhebjV/KPpVB3f2Dw4Q/yRyW9GgPoMzAalL0WxZKn1Cl/dy1Ras7k9S5543yFP/obfsGrBgXUuEtWg/LCniInUOS3L7V7aRUQYnW8YiDW9h9kY1AaLz04GbRn0+ZXb3JcqwKBgQCmamQHznO3LgdcoGGm0qiqVncX/Na0LCa2yakrRnXa4za8Zeah9jRv0U0VvqR/yX7ePjeL5o7f03HLVu2sYi9aQdXCNzjfOSZyCDMulfq9Yq+Zpc51v/mpl+ilU/Uq+7+nfT6ZnpaU81C7NE0cJyPUMqjLXU0LSP92BRvISyL7KQKBgQDFfo80jgAS9BxjaYtZDWgaN6o0SbrN6m+Z8Bu1CXROqhRJD0Gfs9fXjTUD40v67YAXJ1VTM6sH7j8AEbuoJsTWKQo/GlLITMeLfB0bPeKccu96zLzNzQg2EyGUrSMh9n4ZqBkN+fh7yT/3lzrNhvUyqZJcZaUPnGKtlf8LD/zTHQKBgEaId0c7wJ3WG3at31W2mZhAt49qMZIB2JLGnDXkUlVo0i09v2fME2OFQXfC6rPisiv+EMrx+IJzexqlCG102/8UQkZj423xKhNQ2GiZVsHoTub/eKc9q9KuuQNBt3r1YsDZe6vepJITIpeFzlztVek9Y392Vw4+bVAXUDQvbG8pAoGBAMkzWkM8DjLEWsUrzS7n7UHV5FdzgV643bnSLbWe03/POMQAFQAkas0upyKOwx+NZDqhAYqCcJhWjx+ccimg7dySIlk7qtLa8GH8vhZi2HwMCimakWFCGY3qOZu/zDJJhy3GdQHHf21IxObegLIoq1LxZJbXoLEG0nAZawbqLHDd', null, 'singnatureKey', null, null, null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (82, 'chinaMobileQueryMocaWarehouse', 'busiCode', '业务码', 'input', 'String', 'y', 'queryMocaWarehouse', null, 'busiCode', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (83, 'chinaMobileQueryMocaWarehouse', 'requestSource', '请求源', 'input', 'String', 'y', '210224', null, 'requestSource', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (84, 'chinaMobileQueryMocaWarehouse', 'userPwd', '密码', 'input', 'String', 'y', 'XTIyGEmVP', null, 'userPwd', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (85, 'chinaMobileQueryMocaWarehouse', 'userId', '用户名', 'input', 'String', 'y', 'KSZJsh', null, 'userId', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (86, 'chinaMobileQueryMocaWarehouse', 'secretKey', '报文加密密钥', 'input', 'String', 'y', 'YgE~F$I', null, 'secretKey', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (87, 'chinaMobileQueryMocaWarehouse', 'phoneNo', '手机号码', 'input', 'String', 'y', null, null, 'phoneNo', to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:45:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (555, 'getIllegalCase', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (556, 'getIllegalCase', 'province', '省份', 'input', 'String', null, null, null, 'Province', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (557, 'getIllegalCase', 'city', '城市', 'input', 'String', null, null, null, 'City', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (558, 'getIllegalCase', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (559, 'getIllegalCase', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R807', null, 'tradeCode', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (560, 'getIllegalCase', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (561, 'getIllegalCase', 'beginDate', '查询开始时间', 'input', 'String', null, null, null, 'BeginDate', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (562, 'getIllegalCase', 'pageIndex', '页码', 'input', 'String', null, '1', null, 'PageIndex', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (563, 'getIllegalCase', 'pageSize', '每页显示数目', 'input', 'String', null, '200', null, 'PageSize', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (564, 'getIllegalCase', 'illegalCaseList', '违法案件循环体', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.IllegalCaseList', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.illegalCaseList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (565, 'getIllegalCase', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (566, 'getIllegalCase', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (567, 'getIllegalCase', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
commit;
prompt 100 records committed...
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (568, 'getIllegalCase', 'entName', '企业名称', 'output', 'String', null, null, null, '$.Body.NoAS400.ENTNAME', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.entName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (570, 'getOthers', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (571, 'getOthers', 'province', '省份', 'input', 'String', null, null, null, 'Province', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (572, 'getOthers', 'city', '城市', 'input', 'String', null, null, null, 'City', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (573, 'getOthers', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (574, 'getOthers', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R808', null, 'tradeCode', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (575, 'getOthers', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (576, 'getOthers', 'beginDate', '查询开始时间', 'input', 'String', null, null, null, 'BeginDate', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (577, 'getOthers', 'pageIndex', '页码', 'input', 'String', null, '1', null, 'PageIndex', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (578, 'getOthers', 'pageSize', '每页显示数目', 'input', 'String', null, '200', null, 'PageSize', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (579, 'getOthers', 'othersList', '其他：行政处罚信息循环体', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.OthersList', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.othersList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (580, 'getOthers', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (581, 'getOthers', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (582, 'getOthers', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (583, 'getOthers', 'entName', '企业名称', 'output', 'String', null, null, null, '$.Body.NoAS400.ENTNAME', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.entName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (492, 'getEntinfo', 'entNameOrNo', '公司名称或工商注册号', 'input', 'String', 'y', null, null, 'name', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (494, 'getEntinfo', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (493, 'getEntinfo', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (495, 'getEntinfo', 'data', '返回数据', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (496, 'getEntinfo', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'jiayincredit', null, 'senderId', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (497, 'getEntinfo', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R1136', null, 'tradeCode', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (429, 'getPollutionCharge', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (469, 'getPollutionCharge', 'province', '省份', 'input', 'String', null, null, null, 'Province', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (470, 'getPollutionCharge', 'city', '城市', 'input', 'String', null, null, null, 'City', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (471, 'getPollutionCharge', 'pollutionChargeList', '排污收费信息循环体', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.PollutionChargeList', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.pollutionChargeList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (472, 'getPollutionCharge', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (473, 'getPollutionCharge', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (474, 'getPollutionCharge', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (475, 'getPollutionCharge', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (530, 'asGetEnviProNoStand', 'pageIndex', '页码', 'input', 'String', 'N', '1', null, 'PageIndex', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (531, 'asGetEnviProNoStand', 'pageSize', '每页显示数目', 'input', 'String', 'N', '200', null, 'PageSize', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (532, 'asGetEnviProNoStand', 'beginDate', '页码', 'input', 'String', 'N', null, null, 'BeginDate', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (533, 'asGetAdminPenalty', 'pageIndex', '页码', 'input', 'String', 'N', '1', null, 'PageIndex', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (534, 'asGetAdminPenalty', 'pageSize', '每页显示数目', 'input', 'String', 'N', '200', null, 'PageSize', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (535, 'asGetAdminPenalty', 'beginDate', '页码', 'input', 'String', 'N', null, null, 'BeginDate', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (536, 'asGetInspectHandling', 'pageIndex', '页码', 'input', 'String', 'N', '1', null, 'PageIndex', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (537, 'asGetInspectHandling', 'pageSize', '每页显示数目', 'input', 'String', 'N', '200', null, 'PageSize', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (538, 'asGetInspectHandling', 'beginDate', '页码', 'input', 'String', 'N', null, null, 'BeginDate', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (539, 'asGetStressMonitor', 'pageIndex', '页码', 'input', 'String', 'N', '1', null, 'PageIndex', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (540, 'asGetStressMonitor', 'pageSize', '每页显示数目', 'input', 'String', 'N', '200', null, 'PageSize', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (541, 'asGetStressMonitor', 'beginDate', '页码', 'input', 'String', 'N', null, null, 'BeginDate', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (542, 'asGetEnviCreditRank', 'pageIndex', '页码', 'input', 'String', 'N', '1', null, 'PageIndex', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (543, 'asGetEnviCreditRank', 'pageSize', '每页显示数目', 'input', 'String', 'N', '200', null, 'PageSize', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (544, 'asGetEnviCreditRank', 'beginDate', '页码', 'input', 'String', 'N', null, null, 'BeginDate', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (550, 'getPollutionCharge', 'beginDate', '查询开始时间', 'input', 'String', null, null, null, 'BeginDate', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (551, 'getPollutionCharge', 'pageIndex', '页码', 'input', 'String', null, '1', null, 'PageIndex', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (552, 'getPollutionCharge', 'pageSize', '每页显示数目', 'input', 'String', null, '200', null, 'PageSize', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (498, 'taxAbnormal', 'taxPayerName', '纳税人名称', 'input', 'String', 'Y', null, null, 'TaxPayerName', to_date('21-11-2016 10:13:30', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:30', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (499, 'taxAbnormal', 'senderId', '安硕开放的账户', 'input', 'String', 'Y', 'jiayincredit', null, 'senderId', to_date('21-11-2016 10:13:30', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:30', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (500, 'taxAbnormal', 'tradeCode', '请求接口代码', 'input', 'String', 'Y', 'R701', null, 'tradeCode', to_date('21-11-2016 10:13:30', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:30', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (501, 'taxAbnormal', 'taxPayerName', '纳税人名称', 'output', 'String', 'Y', null, null, 'TaxPayerName', to_date('21-11-2016 10:13:30', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:30', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (502, 'taxAbnormal', 'taxAbnormalList', '税务信息列表', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.TaxAbnormalList', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.taxAbnormalList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (503, 'taxAbnormal', 'serialNo', '序列号', 'output', 'String', null, null, null, '$.Body.NoAS400.SerialNo', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.serialNo');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (504, 'taxAbnormal', 'taxPayerName', '纳税人名称', 'output', 'String', null, null, null, '$.Body.NoAS400.TexPayerName', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.texPayerName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (505, 'taxAbnormal', 'abnormalType', '非正常类型', 'output', 'String', null, null, null, '$.Body.NoAS400.AbnormalType', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.abnormalType');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (506, 'taxAbnormal', 'cardNum', '组织机构代码', 'output', 'String', null, null, null, '$.Body.NoAS400.CardNum', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.cardNum');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (507, 'taxAbnormal', 'icRegeditId', '工商注册号', 'output', 'String', null, null, null, '$.Body.NoAS400.ICRegeditID', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.icRegeditId');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (508, 'taxAbnormal', 'taxPayerType', '纳税人类型', 'output', 'String', null, null, null, '$.Body.NoAS400.TaxPayerType', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.texPayerType');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (509, 'taxAbnormal', 'taxRegesitNo', '纳税人登记号', 'output', 'String', null, null, null, '$.Body.NoAS400.Identification', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.taxRegesitNo');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (510, 'taxAbnormal', 'taxRegisterID', '税务登记号', 'output', 'String', null, null, null, '$.Body.NoAS400.TaxRegisterID', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.taxRegisterID');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (511, 'taxAbnormal', 'legalrepresent', '法定代表人', 'output', 'String', null, null, null, '$.Body.NoAS400.Legalrepresent', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.legalrepresent');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (512, 'taxAbnormal', 'legalrepresentID', '有效证件号码', 'output', 'String', null, null, null, '$.Body.NoAS400.LegalrepresentID', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.legalrepresentID');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (513, 'taxCorrect', 'address', '经营地点', 'output', 'String', null, null, null, '$.Body.NoAS400.Address', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.address');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (514, 'taxAbnormal', 'oweTaxType', '欠税税种', 'output', 'String', null, null, null, '$.Body.NoAS400.OweTaxType', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.oweTaxType');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (515, 'taxAbnormal', 'taxRemain', '欠税余额', 'output', 'String', null, null, null, '$.Body.NoAS400.TaxRemain', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.taxRemain');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (516, 'taxAbnormal', 'newTax', '当期新发生的欠税金额', 'output', 'String', null, null, null, '$.Body.NoAS400.NewTax', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.newTax');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (517, 'taxAbnormal', 'abnormalRegeditDate', '认定时间', 'output', 'String', null, null, null, '$.Body.NoAS400.AbnormalRegeditDate', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.abnormalRegeditDate');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (518, 'taxAbnormal', 'taxAuthority', '主管税务所', 'output', 'String', null, null, null, '$.Body.NoAS400.TaxAuthority', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.taxAuthority');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (519, 'taxAbnormal', 'reamrk', '备注', 'output', 'String', null, null, null, '$.Body.NoAS400.Reamrk', to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:13:31', 'dd-mm-yyyy hh24:mi:ss'), '$.data.reamrk');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (520, 'taxAbnormal', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('21-11-2016 10:15:27', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 10:15:27', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (88, 'asSingleEducation', 'idCard', '身份证', 'input', 'String', 'y', null, null, 'identity', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (89, 'asSingleEducation', 'name', '姓名', 'input', 'String', 'y', null, null, 'userName', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (90, 'asSingleEducation', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (91, 'asSingleEducation', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R637', null, 'tradeCode', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (92, 'asSingleEducation', 'graduate', '毕业院校', 'output', 'String', null, null, null, '$.Body.NoAS400.GRADUATE', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.graduate');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (93, 'asSingleEducation', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Body.NoAS400.RESULT', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (94, 'asSingleEducation', 'data', '返回数据', 'output', 'JSONObject', 'y', null, null, '$.Body.NoAS400', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (95, 'asSingleEducation', 'studyResult', '毕业结论', 'output', 'String', null, null, null, '$.Body.NoAS400.STUDYRESULT', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.studyResult');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (96, 'asSingleEducation', 'idCard', '身份证号', 'output', 'String', null, null, null, '$.Body.NoAS400.IDENTITY', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.idCard');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (97, 'asSingleEducation', 'specialityName', '专业', 'output', 'String', null, null, null, '$.Body.NoAS400.SPECIALITYNAME', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.specialityName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (98, 'asSingleEducation', 'educationDegree', '学历', 'output', 'String', null, null, null, '$.Body.NoAS400.EDUCATIONDEGREE', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.educationDegree');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (99, 'asSingleEducation', 'schoolType', '毕业院校类型', 'output', 'String', null, null, null, '$.Body.NoAS400.SCHOOLTYPE', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.schoolType');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (100, 'asSingleEducation', 'studyStyle', '学历类型', 'output', 'String', null, null, null, '$.Body.NoAS400.STUDYSTYLE', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.studyStyle');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (101, 'asSingleEducation', 'enrolDate', '入学年份', 'output', 'String', null, null, null, '$.Body.NoAS400.ENROLDATE', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.enrolDate');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (102, 'asSingleEducation', 'name', '姓名', 'output', 'String', null, null, null, '$.Body.NoAS400.USERNAME', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.name');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (103, 'asSingleEducation', 'graduateTime', '毕业时间', 'output', 'String', null, null, null, '$.Body.NoAS400.GRADUATETIME', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.graduateTime');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (104, 'asSingleEducation', 'sex', '性别', 'output', 'String', null, null, null, '$.Body.NoAS400.sex', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.sex');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (105, 'asSingleEducation', 'photo', '照片', 'output', 'String', null, null, null, '$.Body.NoAS400.PHOTO', to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:32', 'dd-mm-yyyy hh24:mi:ss'), '$.data.photo');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (106, 'asSingleEducation', 'schoolCity', '学校所在城市', 'output', 'String', null, null, null, '$.Body.NoAS400.SCHOOLCITY', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.schoolCity');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (107, 'asSingleEducation', 'schoolTrade', '学校性质(公办、民办等)', 'output', 'String', null, null, null, '$.Body.NoAS400.SCHOOLTRADE', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.schoolTrade');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (108, 'asSingleEducation', 'organization', '学校所属主管单位', 'output', 'String', null, null, null, '$.Body.NoAS400.ORGANIZATION', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.organization');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (109, 'asSingleEducation', 'schoolNature', '学校类型(理工、医药、综合等)', 'output', 'String', null, null, null, '$.Body.NoAS400.SCHOOLNATURE', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.schoolNature');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (110, 'asSingleEducation', 'schoolCategory', '学校类别(211 工程院校)', 'output', 'String', null, null, null, '$.Body.NoAS400.SCHOOLCATEGORY', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.schoolCategory');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (111, 'asSingleEducation', 'schoolLevel', '办学层次', 'output', 'String', null, null, null, '$.Body.NoAS400.SCHOOLLEVEL', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.schoolLevel');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (112, 'asSingleEducation', 'educationApproach', '办学形式(全日制、函授等)', 'output', 'String', null, null, null, '$.Body.NoAS400.EDUCATIONAPPROACH', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.educationApproach');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (113, 'asSingleEducation', 'is985', '是否为985', 'output', 'String', null, null, null, '$.Body.NoAS400.IS985', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.is985');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (114, 'asSingleEducation', 'is211', '是否为211', 'output', 'String', null, null, null, '$.Body.NoAS400.IS211', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.is211');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (115, 'asSingleEducation', 'createDate', '学校创建日期', 'output', 'String', null, null, null, '$.Body.NoAS400.CREATEDATE', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.createDate');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (116, 'asSingleEducation', 'createYear', '创建年限', 'output', 'String', null, null, null, '$.Body.NoAS400.CREATEYEAR', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.createYear');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (117, 'asSingleEducation', 'academicianNum', '学校院士人数', 'output', 'String', null, null, null, '$.Body.NoAS400.ACADEMICIANNUM', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.academicianNum');
commit;
prompt 200 records committed...
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (118, 'asSingleEducation', 'bsdNum', '博士点数目', 'output', 'String', null, null, null, '$.Body.NoAS400.BSDNUM', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.bsdNum');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (119, 'asSingleEducation', 'bshldzNum', '博士后流动站数目', 'output', 'String', null, null, null, '$.Body.NoAS400.BSHLDZNUM', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.bshldzNum');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (120, 'asSingleEducation', 'ssdNum', '硕士点数目', 'output', 'String', null, null, null, '$.Body.NoAS400.SSDNUM', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.ssdNum');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (121, 'asSingleEducation', 'zdxkNum', '国家重点学科数目', 'output', 'String', null, null, null, '$.Body.NoAS400.ZDXKNUM', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.zdxkNum');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (122, 'asSingleEducation', 'lklqpc', '理科录取批次', 'output', 'String', null, null, null, '$.Body.NoAS400.lklqpc', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.lklqpc');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (123, 'asSingleEducation', 'wklqpc', '文科录取批次', 'output', 'String', null, null, null, '$.Body.NoAS400.wklqpc', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.wklqpc');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (124, 'asSingleEducation', 'schoolAddress', '学校详细地址', 'output', 'String', null, null, null, '$.Body.NoAS400.xxdz', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.schoolAddress');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (125, 'asSingleEducation', 'idcOriCt', '身份证原始发证地', 'output', 'String', null, null, null, '$.Body.NoAS400.idcOriCt', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.idcOriCt');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (126, 'asSingleEducation', 'birthday', '出生日期', 'output', 'String', null, null, null, '$.Body.NoAS400.birthday', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.birthday');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (127, 'asSingleEducation', 'schoolHisName', '原院校名称', 'output', 'String', null, null, null, '$.Body.NoAS400.hisname', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), '$.data.schoolHisName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (128, 'asGetIcPersonalInfo', 'idCard', '身份证号码', 'input', 'String', 'y', null, null, 'Cid', to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:33', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (129, 'asGetIcPersonalInfo', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Body.NoAS400.code', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (130, 'asGetIcPersonalInfo', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Body.NoAS400.msg', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (131, 'asGetIcPersonalInfo', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (132, 'asGetIcPersonalInfo', 'idCard', '身份证号码', 'output', 'String', null, null, null, '$.Body.NoAS400.cid', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), '$.data.idCard');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (133, 'asGetIcPersonalInfo', 'perInfoResponseBody', '个人投资信息', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400.perInfoResponseBody', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), '$.data.perInfoResponseBody');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (134, 'asGetIcPersonalInfo', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (135, 'asGetIcPersonalInfo', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R1104', null, 'tradeCode', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (136, 'asGetLostFaithInd2', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (137, 'asGetLostFaithInd2', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R216', null, 'tradeCode', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (138, 'asGetLostFaithInd2', 'name', '姓名', 'input', 'String', 'y', null, null, 'INAME', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (139, 'asGetLostFaithInd2', 'idCard', '身份证号码', 'input', 'String', 'y', null, null, 'ICardnum', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (140, 'asGetLostFaithInd2', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (141, 'asGetLostFaithInd2', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (142, 'asGetLostFaithInd2', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (143, 'asGetLostFaithInd2', 'lostFaithIndList', '失信被执行人循环体', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.LostFaithIndList', to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:34', 'dd-mm-yyyy hh24:mi:ss'), '$.data.lostFaithIndList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (158, 'asGetLostFaithInd2', 'pageSize', '每页显示数目', 'input', 'int', null, '200', null, 'PageSize', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (159, 'asGetLostFaithInd2', 'pageIndex', '页码', 'input', 'int', null, '1', null, 'PageIndex', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (160, 'asGetExecutedInd2', 'name', '被执行人名称', 'input', 'String', 'y', null, null, 'Pname', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (161, 'asGetExecutedInd2', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (162, 'asGetExecutedInd2', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R214', null, 'tradeCode', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (163, 'asGetExecutedInd2', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (164, 'asGetExecutedInd2', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (165, 'asGetExecutedInd2', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (166, 'asGetExecutedInd2', 'executedBody', '被执行人数据列表', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.ExecutedBody', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.data.courtExecutedInfoList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (167, 'asGetExecutedInd2', 'idCard', '身份证号码', 'input', 'String', 'y', null, null, 'PartyCardnum', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (168, 'asGetExecutedInd2', 'name', '被执行人姓名/名称', 'output', 'String', null, null, null, '$.Body.NoAS400.ExecutedBody.PNAME', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.data.courtExecutedInfoList.name');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (169, 'asGetExecutedInd2', 'caseCode', '案号', 'output', 'String', null, null, null, '$.Body.NoAS400.ExecutedBody.CASECODE', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.data.courtExecutedInfoList.caseCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (170, 'asGetExecutedInd2', 'execCourtName', '执行法院', 'output', 'String', null, null, null, '$.Body.NoAS400.ExecutedBody.EXECCOURTNAME', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.data.courtExecutedInfoList.execCourtName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (171, 'asGetExecutedInd2', 'execMoney', '执行标的', 'output', 'String', null, null, null, '$.Body.NoAS400.ExecutedBody.CASECREATETIME', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.data.courtExecutedInfoList.execMoney');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (172, 'asGetExecutedInd2', 'partyCardNum', '身份证号码/组织机构代码', 'output', 'String', null, null, null, '$.Body.NoAS400.ExecutedBody.PARTYCARDNUM', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.data.courtExecutedInfoList.partyCardNum');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (173, 'asGetExecutedInd2', 'caseCreateTime', '立案时间', 'output', 'String', null, null, null, '$.Body.NoAS400.ExecutedBody.CASECREATETIME', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), '$.data.courtExecutedInfoList.caseCreateTime');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (174, 'asGetExecutedInd2', 'pageSize', '每页显示数目', 'input', 'int', null, '200', null, 'PageSize', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (175, 'asGetExecutedInd2', 'pageIndex', '页码', 'input', 'int', null, '1', null, 'PageIndex', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (339, 'xsIllegalDetailCheck', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.DETAIL', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (370, 'xsIllegalCheck', 'name', '姓名', 'input', 'String', 'Y', null, null, 'name', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (371, 'xsIllegalCheck', 'idCard', '身份证号码', 'input', 'String', 'Y', null, null, 'idCard', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (372, 'xsIllegalCheck', 'loginName', '账户', 'input', 'String', 'Y', 'test2', null, 'loginName', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (373, 'xsIllegalCheck', 'pwd', '密码', 'input', 'String', 'Y', '123456', null, 'pwd', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (374, 'xsIllegalCheck', 'retCode', '返回码', 'output', 'String', 'Y', null, null, '$.RESULT', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (375, 'xsIllegalCheck', 'authCode', '匹配码', 'output', 'String', 'Y', null, null, '$.RESULT', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.authCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (376, 'xsIllegalCheck', 'authMsg', '匹配信息', 'output', 'String', null, null, null, '$.MESSAGE', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.authMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (378, 'xsIllegalCheck', 'caseTime', '案情信息', 'output', 'JSONArray', null, null, null, '$.caseTime', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.caseTime');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (317, 'xsIllegalDetailCheck', 'checkType', '刑事类别', 'output', 'String', null, null, null, '$.DETAIL.checkType', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.checkType');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (318, 'xsIllegalDetailCheck', 'checkDesc', '形式描述', 'output', 'String', null, null, null, '$.DETAIL.checkDesc', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.checkDesc');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (319, 'xsIllegalDetailCheck', 'checkDetail', '核查明细', 'output', 'JSONArray', null, null, null, '$.DETAIL.checkDetail', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.checkDetail');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (340, 'xsIllegalDetailCheck', 'caseTime', '案件时间', 'output', 'String', null, null, null, '$.DETAIL.checkDetail.caseTime', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.checkDetail.caseTime');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (341, 'xsIllegalDetailCheck', 'caseSource', '案件源', 'output', 'String', null, null, null, '$.DETAIL.checkDetail.caseSource', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.checkDetail.caseSource');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (342, 'xsIllegalDetailCheck', 'caseType', '案件类型', 'output', 'String', null, null, null, '$.DETAIL.checkDetail.caseType', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.data.checkDetail.caseType');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (327, 'xsBlackListCheck', 'phoneNo', '手机号', 'input', 'String', 'Y', null, null, 'mobile', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (310, 'xsIllegalDetailCheck', 'name', '姓名', 'input', 'String', 'Y', null, null, 'name', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (311, 'xsIllegalDetailCheck', 'idCard', '身份证号码', 'input', 'String', 'Y', null, null, 'idCard', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (312, 'xsIllegalDetailCheck', 'loginName', '账户', 'input', 'String', 'Y', 'jiayinzhengxin', null, 'loginName', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (313, 'xsIllegalDetailCheck', 'pwd', '密码', 'input', 'String', 'Y', '123456', null, 'pwd', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (314, 'xsIllegalDetailCheck', 'retCode', '返回码', 'output', 'String', 'Y', null, null, '$.RESULT', to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:36', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (316, 'xsIllegalDetailCheck', 'retMsg', '原因', 'output', 'String', null, null, null, '$.MESSAGE', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (320, 'xsBlackListCheck', 'name', '姓名', 'input', 'String', 'Y', null, null, 'name', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (321, 'xsBlackListCheck', 'idCard', '身份证号码', 'input', 'String', 'Y', null, null, 'idCard', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (322, 'xsBlackListCheck', 'loginName', '账户', 'input', 'String', 'Y', 'test2', null, 'loginName', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (323, 'xsBlackListCheck', 'pwd', '密码', 'input', 'String', 'Y', '123456', null, 'pwd', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (324, 'xsBlackListCheck', 'retCode', '返回码', 'output', 'String', 'Y', null, null, '$.RESULT', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (325, 'xsBlackListCheck', 'valid', '匹配码', 'output', 'String', 'Y', null, null, '$.RESULT', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.data.valid');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (326, 'xsBlackListCheck', 'reason', '原因', 'output', 'String', null, null, null, '$.MESSAGE', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.data.reason');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (328, 'asGetFXDInfo', 'idNo', '证件号码', 'input', 'String', 'Y', null, null, 'idNo', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (329, 'asGetFXDInfo', 'idType', '证件类型', 'input', 'String', 'Y', null, null, 'idType', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (330, 'asGetFXDInfo', 'name', '姓名', 'input', 'String', 'Y', null, null, 'name', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (476, 'getPollutionCharge', 'entName', '企业名称', 'output', 'String', null, null, null, '$.Body.NoAS400.ENTNAME', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.entName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (490, 'getPollutionCharge', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R806', null, 'tradeCode', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (491, 'getPollutionCharge', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (481, 'asGetEnviProNoStand', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R801', null, 'tradeCode', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (433, 'asGetAdminPenalty', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (439, 'asGetAdminPenalty', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R802', null, 'tradeCode', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (443, 'asGetInspectHandling', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (449, 'asGetInspectHandling', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R803', null, 'tradeCode', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (453, 'asGetStressMonitor', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (459, 'asGetStressMonitor', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R804', null, 'tradeCode', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (463, 'asGetEnviCreditRank', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (480, 'asGetEnviCreditRank', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R805', null, 'tradeCode', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (423, 'asGetEnviProNoStand', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:35', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (331, 'asGetFXDInfo', 'entityAuthCode', '信息主体授权码', 'input', 'String', 'Y', null, null, 'entityAuthCode', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (332, 'asGetFXDInfo', 'entityAuthDate', '信息主体授权时间', 'input', 'String', 'Y', null, null, 'entityAuthDate', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (344, 'asGetFXDInfo', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R6201', null, 'tradeCode', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (343, 'asGetFXDInfo', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (345, 'asGetFXDInfo', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (346, 'asGetFXDInfo', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (347, 'asGetFXDInfo', 'idNo', '证件号码', 'output', 'String', null, null, null, '$.Body.NoAS400.idNo', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.data.idNo');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (348, 'asGetFXDInfo', 'idType', '证件类型', 'output', 'String', null, null, null, '$.Body.NoAS400.idType', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.data.idType');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (349, 'asGetFXDInfo', 'name', '姓名', 'output', 'String', null, null, null, '$.Body.NoAS400.name', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.data.name');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (350, 'asGetFXDInfo', 'sourceId', '来源代码', 'output', 'String', null, null, null, '$.Body.NoAS400.sourceId', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.data.sourceId');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (351, 'asGetFXDInfo', 'rskScore', '风险得分', 'output', 'String', null, null, null, '$.Body.NoAS400.rskScore', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.data.rskScore');
commit;
prompt 300 records committed...
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (352, 'asGetFXDInfo', 'rskMark', '风险标记', 'output', 'String', null, null, null, '$.Body.NoAS400.rskMark', to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:37', 'dd-mm-yyyy hh24:mi:ss'), '$.data.rskMark');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (377, 'asGetFXDInfo', 'dataStatus', '数据状态', 'output', 'String', null, null, null, '$.Body.NoAS400.dataStatus', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.dataStatus');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (369, 'asGetFXDInfo', 'busiDate', '业务发生时间', 'output', 'String', null, null, null, '$.Body.NoAS400.dataBuildTime', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.busiDate');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (412, 'asGetFXDInfo', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (354, 'asQueryCDKInfo', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R6204', null, 'tradeCode', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (353, 'asQueryCDKInfo', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (364, 'asQueryCDKInfo', 'name', '姓名', 'output', 'String', null, null, null, '$.Body.NoAS400.name', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.name');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (359, 'asQueryCDKInfo', 'entityAuthDate', '信息主体授权时间', 'input', 'String', 'Y', null, null, 'entityAuthDate', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (358, 'asQueryCDKInfo', 'entityAuthCode', '信息主体授权码', 'input', 'String', 'Y', null, null, 'entityAuthCode', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (357, 'asQueryCDKInfo', 'name', '姓名', 'input', 'String', 'Y', null, null, 'name', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (356, 'asQueryCDKInfo', 'idType', '证件类型', 'input', 'String', 'Y', null, null, 'idType', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (355, 'asQueryCDKInfo', 'idNo', '证件号码', 'input', 'String', 'Y', null, null, 'idNo', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (363, 'asQueryCDKInfo', 'idType', '证件类型', 'output', 'String', null, null, null, '$.Body.NoAS400.idType', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.idType');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (362, 'asQueryCDKInfo', 'idNo', '证件号码', 'output', 'String', null, null, null, '$.Body.NoAS400.idNo', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.idNo');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (361, 'asQueryCDKInfo', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (360, 'asQueryCDKInfo', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (365, 'asQueryCDKInfo', 'reasonCode', '查询原因', 'output', 'String', null, null, null, '$.Body.NoAS400.reasonCode', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.reasonCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (366, 'asQueryCDKInfo', 'industry', '机构所属行业', 'output', 'String', null, null, null, '$.Body.NoAS400.industry', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.industry');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (367, 'asQueryCDKInfo', 'amount', '命中机构数目', 'output', 'String', null, null, null, '$.Body.NoAS400.amount', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.amount');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (368, 'asQueryCDKInfo', 'busiDate', '业务发生时间', 'output', 'String', null, null, null, '$.Body.NoAS400.busiDate', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.busiDate');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (413, 'asQueryCDKInfo', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (393, 'asGetFQZFXDInfo', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (394, 'asGetFQZFXDInfo', 'ipRiskDesc', 'IP风险描述', 'output', 'String', null, null, null, '$.Body.NoAS400.iRskDesc', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.ipRiskDesc');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (395, 'asGetFQZFXDInfo', 'isMachdBlackList', '命中第三方标注IP黑名单', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdBlacklist', to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:38', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdBlackList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (396, 'asGetFQZFXDInfo', 'isMachdBlMakt', '命中第三方标注手机黑名单', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdBlMakt', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdBlMakt');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (397, 'asGetFQZFXDInfo', 'isMachdCraCall', '命中骚扰电话', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachCraCall', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdCraCall');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (398, 'asGetFQZFXDInfo', 'isMachdDNS', '命中DNS服务器', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdDNS', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdDNS');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (399, 'asGetFQZFXDInfo', 'isMachdCrawler', '命中爬虫', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdCrawler', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdCrawler');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (400, 'asGetFQZFXDInfo', 'isMachdEmpty', '命中空号（非正常短信语音号码）', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachEmpty', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdEmpty');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (401, 'asGetFQZFXDInfo', 'isMachdForce', '命中暴力破解', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdForce', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdForce');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (405, 'asGetFQZFXDInfo', 'isMachdProxy', '命中代理服务器', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdProxy', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdProxy');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (404, 'asGetFQZFXDInfo', 'isMachdOrg', '命中组织出口', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdOrg', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdOrg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (403, 'asGetFQZFXDInfo', 'isMachdMailServ', '命中邮件服务器', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdMailServ', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdMailServ');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (402, 'asGetFQZFXDInfo', 'isMachdFraud', '命中欺诈号码', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachFraud', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdFraud');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (406, 'asGetFQZFXDInfo', 'isMachdVPN', '命中vpn服务器', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdVPN', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdVPN');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (407, 'asGetFQZFXDInfo', 'isMachdSEO', '命中seo', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdSEO', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdSEO');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (408, 'asGetFQZFXDInfo', 'isMachdWebServ', '命中web服务器', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachdWebServ', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdWebServ');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (409, 'asGetFQZFXDInfo', 'isMachdYzPhone', '命中收码平台号码', 'output', 'String', null, null, null, '$.Body.NoAS400.isMachYZmobile', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.isMachdYzPhone');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (410, 'asGetFQZFXDInfo', 'phoneRiskDate', '手机号码风险时间', 'output', 'String', null, null, null, '$.Body.NoAS400.mUpdateDate', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.phoneRiskDate');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (411, 'asGetFQZFXDInfo', 'phoneRiskDesc', '手机号码风险描述', 'output', 'String', null, null, null, '$.Body.NoAS400.mRskDesc', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), '$.data.phoneRiskDesc');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (385, 'asGetFQZFXDInfo', 'entityAuthDate', '信息主体授权时间', 'input', 'String', 'Y', null, null, 'entityAuthDate', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (384, 'asGetFQZFXDInfo', 'entityAuthCode', '信息主体授权码', 'input', 'String', 'Y', null, null, 'entityAuthCode', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (383, 'asGetFQZFXDInfo', 'name', '姓名', 'input', 'String', 'Y', null, null, 'name', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (382, 'asGetFQZFXDInfo', 'idType', '证件类型', 'input', 'String', 'Y', null, null, 'idType', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (381, 'asGetFQZFXDInfo', 'idNo', '证件号码', 'input', 'String', 'Y', null, null, 'idNo', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (380, 'asGetFQZFXDInfo', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R6202', null, 'tradeCode', to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:39', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (379, 'asGetFQZFXDInfo', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (386, 'asGetFQZFXDInfo', 'reasonNo', '查询原因', 'input', 'String', null, null, null, 'reasonNo', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (387, 'asGetFQZFXDInfo', 'phoneNo', '手机号码', 'input', 'String', null, null, null, 'mobileNo', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (388, 'asGetFQZFXDInfo', 'ipAddress', 'IP地址', 'input', 'String', null, null, null, 'ip', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (390, 'asGetFQZFXDInfo', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (389, 'asGetFQZFXDInfo', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (391, 'asGetFQZFXDInfo', 'phoneNo', '手机号码', 'output', 'String', null, null, null, '$.Body.NoAS400.mobileNo', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), '$.data.phoneNo');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (392, 'asGetFQZFXDInfo', 'ipAddress', 'IP地址', 'output', 'String', null, null, null, '$.Body.NoAS400.ip', to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:40', 'dd-mm-yyyy hh24:mi:ss'), '$.data.ipAddress');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (420, 'asGetEnviProNoStand', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (421, 'asGetEnviProNoStand', 'province', '省份', 'input', 'String', 'N', null, null, 'Province', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (422, 'asGetEnviProNoStand', 'city', '城市', 'input', 'String', 'N', null, null, 'City', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (424, 'asGetEnviProNoStand', 'entName', '企业名称', 'output', 'String', null, null, null, '$.Body.NoAS400.ENTNAME', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.entName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (425, 'asGetEnviProNoStand', 'enviProNoStandList', '环保不达标信息', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.EnviProNoStandList', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.enviProNoStandList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (426, 'asGetEnviProNoStand', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (427, 'asGetEnviProNoStand', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (428, 'asGetEnviProNoStand', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (430, 'asGetAdminPenalty', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (431, 'asGetAdminPenalty', 'province', '省份', 'input', 'String', 'N', null, null, 'Province', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (432, 'asGetAdminPenalty', 'city', '城市', 'input', 'String', 'N', null, null, 'City', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (434, 'asGetAdminPenalty', 'entName', '企业名称', 'output', 'String', null, null, null, '$.Body.NoAS400.ENTNAME', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.entName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (435, 'asGetAdminPenalty', 'adminPenaltyList', '行政处罚信息', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.AdminPenaltyList', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.adminPenaltyList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (436, 'asGetAdminPenalty', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (437, 'asGetAdminPenalty', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (438, 'asGetAdminPenalty', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (440, 'asGetInspectHandling', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (441, 'asGetInspectHandling', 'province', '省份', 'input', 'String', 'N', null, null, 'Province', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (442, 'asGetInspectHandling', 'city', '城市', 'input', 'String', 'N', null, null, 'City', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (444, 'asGetInspectHandling', 'entName', '企业名称', 'output', 'String', null, null, null, '$.Body.NoAS400.ENTNAME', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.entName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (445, 'asGetInspectHandling', 'inspectHandlingList', '环保不达标信息', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.InspectHandlingList', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.inspectHandlingList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (446, 'asGetInspectHandling', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (447, 'asGetInspectHandling', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (448, 'asGetInspectHandling', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (450, 'asGetStressMonitor', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (451, 'asGetStressMonitor', 'province', '省份', 'input', 'String', 'N', null, null, 'Province', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (452, 'asGetStressMonitor', 'city', '城市', 'input', 'String', 'N', null, null, 'City', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (454, 'asGetStressMonitor', 'entName', '企业名称', 'output', 'String', null, null, null, '$.Body.NoAS400.ENTNAME', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.entName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (455, 'asGetStressMonitor', 'stressMonitorList', '环保不达标信息', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.StressMonitorList', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.stressMonitorList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (456, 'asGetStressMonitor', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (457, 'asGetStressMonitor', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (458, 'asGetStressMonitor', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (460, 'asGetEnviCreditRank', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (461, 'asGetEnviCreditRank', 'province', '省份', 'input', 'String', 'N', null, null, 'Province', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (462, 'asGetEnviCreditRank', 'city', '城市', 'input', 'String', 'N', null, null, 'City', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (464, 'asGetEnviCreditRank', 'entName', '企业名称', 'output', 'String', null, null, null, '$.Body.NoAS400.ENTNAME', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.entName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (465, 'asGetEnviCreditRank', 'enviCreditRankList', '环保不达标信息', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.EnviCreditRankList', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data.enviCreditRankList');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (466, 'asGetEnviCreditRank', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (467, 'asGetEnviCreditRank', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (468, 'asGetEnviCreditRank', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (584, 'getLitigationDatas', 'entName', '企业名称', 'input', 'String', 'y', null, null, 'EntName', to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (585, 'getLitigationDatas', 'province', '省份', 'input', 'String', null, null, null, 'Province', to_date('17-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (586, 'getLitigationDatas', 'city', '城市', 'input', 'String', null, null, null, 'City', to_date('18-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (587, 'getLitigationDatas', 'ptype', '公告类型', 'input', 'String', null, null, null, 'Ptype', to_date('19-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (588, 'getLitigationDatas', 'beginDate', '开始日期', 'input', 'String', null, null, null, 'BeginDate', to_date('20-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('20-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (589, 'getLitigationDatas', 'pageSize', '每页显示数目', 'input', 'String', null, null, null, 'PageSize', to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), null);
commit;
prompt 400 records committed...
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (590, 'getLitigationDatas', 'pageIndex', '页码', 'input', 'String', null, null, null, 'PageIndex', to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (591, 'getLitigationDatas', 'tradeCode', '请求的接口代码', 'input', 'String', 'y', 'R202', null, 'tradeCode', to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (592, 'getLitigationDatas', 'senderId', '安硕开放的账户', 'input', 'String', 'y', 'Jiayindata', null, 'senderId', to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), null);
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (593, 'getLitigationDatas', 'entName', '企业名称', 'output', 'String', null, null, null, '$.Body.NoAS400.EntName', to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), '$.data.entName');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (594, 'getLitigationDatas', 'retCode', '返回码', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorCode', to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), '$.retCode');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (595, 'getLitigationDatas', 'retMsg', '返回信息', 'output', 'String', null, null, null, '$.Header.HeadType.gwErrorMessage', to_date('17-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), '$.retMsg');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (596, 'getLitigationDatas', 'data', '返回数据', 'output', 'JSONObject', null, null, null, '$.Body.NoAS400', to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), '$.data');
insert into D_DATA_RESOURCE_API_PARAM (id, resource_api_id, param_id, name, type, data_type, must, qualifier, single, dest_id, create_time, update_time, json_path)
values (597, 'getLitigationDatas', 'litigationList', '被执行人姓名/名称', 'output', 'JSONArray', null, null, null, '$.Body.NoAS400.LitigationList', to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 16:53:00', 'dd-mm-yyyy hh24:mi:ss'), '$.data.litigationList');
commit;
prompt 408 records loaded
prompt Loading D_DATA_RESOURCE_REPORT...
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525963, 'chinamobile', 'chinaMobileQueryMocaWarehouse', '中移动疑似养卡库接口认证', 108, 2, 110, 1, 'sys', 'sys', to_date('30-08-2016 19:31:40', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-10-2016 13:52:21', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525964, 'payegis', 'payegisPhoneBlackList', '通付盾手机黑名单查询', 108, 0, 108, 1, 'sys', 'sys', to_date('30-08-2016 19:33:18', 'dd-mm-yyyy hh24:mi:ss'), to_date('28-10-2016 13:37:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525951, 'unionpaysmart', 'unionpayVerifyIdentity', '银联简项认证', 3, 0, 3, 1, 'sys', 'sys', to_date('09-08-2016 16:50:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-08-2016 14:34:55', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525956, 'zewei', 'zeWeiVerifyBankCard', '泽维卡要素验证', 38, 0, 38, 1, 'sys', 'sys', to_date('09-08-2016 17:59:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('15-11-2016 13:46:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525952, 'zewei', 'zeWeiVerifyIdMobile', '泽维三联验证', 9, 0, 9, 1, 'sys', 'sys', to_date('09-08-2016 17:47:57', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-08-2016 19:20:20', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525954, 'unionpaysmart', 'unionpayVerifyRelation', '银联智惠卡要素验证', 9, 4, 13, 1, 'sys', 'sys', to_date('09-08-2016 17:54:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('25-08-2016 17:04:02', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525958, 'junyu', 'jyVerifyBankCard', '骏聿银行卡验证', 33, 3, 36, 1, 'sys', 'sys', to_date('09-08-2016 18:48:37', 'dd-mm-yyyy hh24:mi:ss'), to_date('16-11-2016 15:12:34', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525947, 'chinamobile', 'custInfoPicVerify', '中移动身份证查验接口', 19, 0, 19, 1, 'sys', 'sys', to_date('02-08-2016 19:32:41', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 19:29:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525950, 'junyu', 'jyVerifyIdentity', '骏聿简项查询', 47, 6, 53, 1, 'sys', 'sys', to_date('02-08-2016 20:00:22', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 16:00:47', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2525957, 'zewei', 'zeWeiVerifyIdentity', '泽维简项验证', 2, 0, 2, 1, 'sys', 'sys', to_date('09-08-2016 18:12:17', 'dd-mm-yyyy hh24:mi:ss'), to_date('12-08-2016 16:42:11', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526313, 'anshuo', 'getLitigationDatas', '安硕诉讼数据查询接口', 26, 0, 26, 1, 'sys', 'sys', to_date('22-11-2016 11:07:29', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-11-2016 16:35:56', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526289, 'anshuo', 'asGetExecutedInd2', '安硕个人被执行人查询接口', 5, 0, 5, 1, 'sys', 'sys', to_date('18-11-2016 10:32:04', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 11:19:52', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526287, 'anshuo', 'asGetIcPersonalInfo', '安硕个人投资任职基本信息查询', 5, 0, 5, 1, 'sys', 'sys', to_date('18-11-2016 09:42:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 17:11:54', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526291, 'anshuo', 'asGetLostFaithInd2', '安硕个人失信被执行人接口', 6, 0, 6, 1, 'sys', 'sys', to_date('18-11-2016 10:44:44', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-11-2016 17:09:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526297, 'anshuo', 'getEntinfo', '安硕企业工商信息查询 ', 16, 13, 29, 1, 'sys', 'sys', to_date('18-11-2016 17:27:52', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-11-2016 14:56:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526293, 'anshuo', 'asGetEnviProNoStand', '环保--环保不达标', 14, 3, 17, 1, 'sys', 'sys', to_date('18-11-2016 10:53:28', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-11-2016 15:16:53', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526295, 'anshuo', 'getPollutionCharge', '环保--排污收费信息', 10, 3, 13, 1, 'sys', 'sys', to_date('18-11-2016 13:38:17', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 11:36:13', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526312, 'anshuo', 'getOthers', '环保--其他(污染隐患大排查、环境检查整治表）', 5, 0, 5, 1, 'sys', 'sys', to_date('21-11-2016 16:20:54', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 17:25:38', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526309, 'anshuo', 'getIllegalCase', '环保--违法案件', 2, 0, 2, 1, 'sys', 'sys', to_date('21-11-2016 14:21:06', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 14:22:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526300, 'anshuo', 'asGetAdminPenalty', '环保--行政处罚', 4, 0, 4, 1, 'sys', 'sys', to_date('21-11-2016 10:40:11', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-11-2016 16:46:39', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526301, 'anshuo', 'asGetInspectHandling', '环保--挂牌督办', 4, 0, 4, 1, 'sys', 'sys', to_date('21-11-2016 10:42:24', 'dd-mm-yyyy hh24:mi:ss'), to_date('22-11-2016 14:54:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526302, 'anshuo', 'asGetStressMonitor', '环保--国控重点企业名单', 2, 0, 2, 1, 'sys', 'sys', to_date('21-11-2016 10:43:33', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-11-2016 16:53:19', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_DATA_RESOURCE_REPORT (id, resource_id, resource_api_id, resource_api_name, success_count, fail_count, total_count, status, created_by, updated_by, created_at, updated_at)
values (2526303, 'anshuo', 'asGetEnviCreditRank', '环保--环境信用行为排名', 5, 0, 5, 1, 'sys', 'sys', to_date('21-11-2016 10:44:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('23-11-2016 16:59:00', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 23 records loaded
prompt Loading D_PRODUCT_API_REL...
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (1, 'CP16000001', 'identify/verifyID', to_date('02-08-2016 17:58:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-08-2016 17:58:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (2, 'CP16000002', 'identify/verifyIdMobile', to_date('09-08-2016 16:05:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 16:05:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (3, 'CP16000003', 'identify/verifyBankCard', to_date('09-08-2016 16:05:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('09-08-2016 16:05:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (4, 'CP16000008', 'fingerPrint/sendBusinessData', to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (5, 'CP16000004', 'fingerPrint/sendDeviceData', to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (6, 'CP16000009', 'fingerPrint/getFingerPrintingId', to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (7, 'CP16000005', 'verifyPhoneBlacklist', to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (8, 'CP16000006', 'verifyIsMocaWarehouse', to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-08-2016 17:56:35', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (9, 'CP16000007', 'anti-fraud/decision', to_date('26-09-2016', 'dd-mm-yyyy'), to_date('26-09-2016', 'dd-mm-yyyy'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (15, 'CP16000015', 'environment/getPollutionCharge', to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (10, 'CP16000010', 'getPersonalInvestmentInfo', to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (26, 'CP16000015', 'tax/abnormal', to_date('21-11-2016 11:11:14', 'dd-mm-yyyy hh24:mi:ss'), to_date('21-11-2016 11:11:14', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (11, 'CP16000011', 'getCompanyLawsuitInfo', to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (12, 'CP16000012', 'getCompanyBusInfo', to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (13, 'CP16000013', 'getPersonalExecutedInfo', to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (14, 'CP16000014', 'getPersonalBreachedInfo', to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (16, 'CP16000010', 'environment/getEnviProNoStand', to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (17, 'CP16000010', 'environment/getAdminPenalty', to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (18, 'CP16000010', 'environment/getInspectHandling', to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (19, 'CP16000010', 'environment/getStressMonitor', to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (20, 'CP16000010', 'environment/getEnviCreditRank', to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('18-11-2016 00:01:00', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (23, 'CP16000004', 'illegalCheck', to_date('02-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('02-11-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (24, 'CP16000004', 'blackListCheck', to_date('31-10-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-10-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (25, 'CP16000004', 'illegalDetailCheck', to_date('31-10-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'), to_date('31-10-2016 00:00:01', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (27, 'CP16000015', 'environment/getIllegalCase', to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into D_PRODUCT_API_REL (id, product_id, api_id, create_time, update_time)
values (28, 'CP16000015', 'environment/getOthers', to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'), to_date('17-11-2016 11:58:50', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 26 records loaded
prompt Loading SYS_MENU...




insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (1, '核心系统', '0', null, 0, '0', 0, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (22, '机构管理', '0', null, 1, '1', 0, '1', SYSDATE(), '1', null, null, '&#xe612;');
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (221, '新建机构', '1', 'organization_new', 22, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (222, '机构查询', '1', 'organization_search', 22, '2', 2, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (33, '渠道管理', '0', null, 1, '1', 0, '1', SYSDATE(), '1', null, null, '&#xe600;');
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (331, '新建渠道', '1', 'channel_new', 33, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (332, '渠道查询', '1', 'channel_list', 33, '2', 2, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (77, '用户授权', '0', null, 1, '1', 0, '1', SYSDATE(), '1', null, null, '&#xe61e;');
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (771, '用户授权记录', '1', 'userAuth_list', 77, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (772, '用户授权管理', '1', 'userAuth_manage', 77, '2', 2, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (44, '产品管理', '0', null, 1, '1', 0, '1', SYSDATE(), '1', null, null, '&#xe615;');
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (444, '新建产品', '1', 'product_new', 44, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (441, '产品查询', '1', 'product_list', 44, '2', 2, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (443, '产品复核', '1', 'product_recheck', 44, '2', 3, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (442, '未通过复核', '1', 'product_disrecheck', 44, '2', 4, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (45, '产品授权', '0', null, 1, '1', 0, '1', SYSDATE(), '1', null, null, '&#xe614;');
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (451, '新建产品授权', '1', 'productLicense_new', 45, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (452, '产品授权列表', '1', 'productLicense_list', 45, '2', 2, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (453, '产品授权复核', '1', 'productLicense_recheck', 45, '2', 3, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (454, '产品授权开通', '1', 'productLicense_open', 45, '2', 4, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (66, '异议管理', '0', null, 1, '1', 0, '1', SYSDATE(), '1', null, null, '&#xe611;');
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (661, '异议登记', '1', 'objection_register', 66, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (662, '异议核查', '1', 'objection_check', 66, '2', 2, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (663, '异议查询', '1', 'objection_list', 66, '2', 3, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (88, '报表管理', '0', null, 1, '1', 0, '1', SYSDATE(), '1', null, null, '&#xe618;');
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (881, '报表查询', '1', 'reportForms_list', 88, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (882, '报表上传', '1', 'reportForms_upload', 88, '2', 2, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (100, '系统管理', '0', null, 1, '1', 0, '1', SYSDATE(), '1', null, null, '&#xe61d;');
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (1001, '新建用户', '1', 'user_new', 100, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (1002, '用户管理', '1', 'user_manage', 100, '2', 2, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (55, '计费管理', '0', null, 1, '1', 0, '1', SYSDATE(), '1', null, null, '&#xe608;');
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (551, '计费查询', '1', 'feet_list', 55, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (991, '生成token', '1', 'generatetoken', 100, '2', 1, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (992, 'token查询', '1', 'searchtoken', 100, '2', 2, '1', SYSDATE(), '1', null, null, null);
insert into SYS_MENU (menu_id, menu_name, menu_type, menu_url, parent_id, menu_level, menu_sort, whether_delete, create_time, create_user, update_time, update_user, menu_icon)
values (1003, '角色管理', '1', 'roleManager.do?method=main', 100, '2', 3, '1', SYSDATE(), '1', null, null, null);
commit;
prompt 35 records loaded
prompt Loading SYS_ROLE...


insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520582, 'CPSQCXY', '产品授权查询员', '具备产品授权管理菜单，查询操作权限', '1', SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520583, 'CPSQGLY', '产品授权管理员', '具备产品授权管理菜单，查询、修改、删除、新增权限、开通操作权限', '1',SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520584, 'CPSQFHY', '产品授权复核员', '具备产品授权管理菜单，查询、复核操作权限', '1',SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520591, 'BBCXY', '报表查询员', '具备报表管理菜单操作权限', '1',SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520592, 'YYCXY', '异议查询员', '具备异议查询菜单的操作权限', '1', SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520593, 'YYDJY', '异议登记员', '具备异议登记菜单操作权限', '1', SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520574, 'JGGLY', '机构管理员', '具备增加、查询、修改机构权限', '1',SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520575, 'QDGLY', '渠道管理员', '具备增加、查询、修改渠道权限', '1', SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520576, 'YHSQCXY', '用户授权查询员', '具备用户授权记录菜单操作权限', '1', SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520577, 'YHSQJCY', '用户授权检查员', '具备用户授权记录，用户授权管理未授权、协查中、已超时、已获取菜单操作权限', '1',SYSDATE();
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520580, 'CPGLY', '产品管理员', '具有产品新建，查询，修改菜单的操作权限', '1', SYSDATE(), 'admin', null, 'admin');
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520581, 'CPFHY', '产品复核员', '具有新建产品复核菜单的操作权限', '1', SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520594, 'YYHCY', '异议核查员', '具备异议核查菜单的操作权限', '1', SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520596, 'YYGLY', '用户管理员', '具备系统管理->用户管理菜单操作权限', '1',SYSDATE(), 'admin', null, 'admin');
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (2520598, 'JSGLY', '角色管理员', '具备系统管理->角色管理菜单操作权限', '0',SYSDATE(), 'admin', null, null);
insert into SYS_ROLE (role_id, role_code, role_name, role_desc, whether_delete, create_time, create_user, update_time, update_user)
values (299, 'JFGLY', '计费管理员', '计费管理菜单权限', '1', SYSDATE(), 'admin', null, null);
commit;
prompt 16 records loaded
prompt Loading SYS_ROLE_MENU...
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520575, 99, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520575, 992, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520575, 991, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520577, 77, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520577, 771, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520577, 772, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520578, 771, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520578, 772, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520578, 77, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520576, 771, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520576, 77, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (297, 881, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (297, 882, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (297, 88, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520574, 221, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520574, 222, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520574, 22, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520575, 331, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520575, 332, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520575, 33, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520583, 451, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520583, 452, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520583, 454, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520583, 45, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520584, 453, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520582, 452,SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520582, 45,SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520584, 45, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520591, 881,SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520591, 88,SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520580, 444, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520580, 441, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520580, 442, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520580, 44, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520596, 100,SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520596, 1001, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520596, 1002, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2519504, 33, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2519800, 22, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2519800, 33,SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2519800, 1002, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520581, 443, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520592, 663,SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520592, 66,SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520593, 661, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520593, 66, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520594, 662, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520594, 66, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520581, 44, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2519678, 1002, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2519678, 22, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2519678, 33, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (299, 55, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (299, 551, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520600, 100, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520600, 991, SYSDATE(), null, null, null);
insert into SYS_ROLE_MENU (role_id, menu_id, create_time, create_user, update_time, update_user)
values (2520600, 992, SYSDATE(), null, null, null);
commit;
prompt 57 records loaded
prompt Loading SYS_USER...
insert into SYS_USER (user_id, user_account, password, user_name, user_status, emp_no, belong_depart, create_time, create_user, update_time, update_user, whether_delete, phone_no, email)
values (2526148, 'liyong4', 'MTIzNDU2', '李勇', '0', null, '嘉银征信',SYSDATE(), '系统管理员', SYSDATE(), '系统管理员', '1', '13641992220', 'liyong4@jiayincredit.com');
insert into SYS_USER (user_id, user_account, password, user_name, user_status, emp_no, belong_depart, create_time, create_user, update_time, update_user, whether_delete, phone_no, email)
values (2525982, 'sdsf', 'MTIzNDU2', '大方的', '0', null, '嘉银征信',SYSDATE(), null, null, '系统管理员', '1', '13655555544', 'sdsf@jiayincredit.com');
insert into SYS_USER (user_id, user_account, password, user_name, user_status, emp_no, belong_depart, create_time, create_user, update_time, update_user, whether_delete, phone_no, email)
values (1, 'admin', 'MTIzNDU2', '系统管理员', '0', '123', null, null, '系统管理员',SYSDATE(), 'admin', '1', null, 'system@jiayincredit.com');
insert into SYS_USER (user_id, user_account, password, user_name, user_status, emp_no, belong_depart, create_time, create_user, update_time, update_user, whether_delete, phone_no, email)
values (2526791, 'token', 'MTIzNDU2', 'token管理员', '0', null, '嘉银征信', SYSDATE(), null, null, '系统管理员', '1', '18288888888', 'tokenManager@jiayincredit.com');
commit;
prompt 4 records loaded
prompt Loading SYS_USER_ROLE...
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520582, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520583, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520584, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520591, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520592, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520593, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520574, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520575, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520576, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520577, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520580, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520581, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520594, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 2520596, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526148, 299, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2525982, 2520582, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2525982, 2520583, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2525982, 2520584, SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520582,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520583,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520584,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520591,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520592,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520593,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520574,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520575,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520576,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520577,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520580,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520581,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520594,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 2520596,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 297,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (1, 299,SYSDATE(), null, null, null);
insert into SYS_USER_ROLE (user_id, role_id, create_time, create_user, update_time, update_user)
values (2526791, 2520600,SYSDATE(), null, null, null);
commit;
prompt 35 records loaded
prompt Enabling triggers for DICTIONARY...
alter table DICTIONARY enable all triggers;
prompt Enabling triggers for D_API_CALL_STATISTICS...
alter table D_API_CALL_STATISTICS enable all triggers;
prompt Enabling triggers for D_API_DATABASE_REL...
alter table D_API_DATABASE_REL enable all triggers;
prompt Enabling triggers for D_API_EXTERNAL_RESOURCE_REL...
alter table D_API_EXTERNAL_RESOURCE_REL enable all triggers;
prompt Enabling triggers for D_API_INFO...
alter table D_API_INFO enable all triggers;
prompt Enabling triggers for D_API_PARAM...
alter table D_API_PARAM enable all triggers;
prompt Enabling triggers for D_DATA_RESOURCE...
alter table D_DATA_RESOURCE enable all triggers;
prompt Enabling triggers for D_DATA_RESOURCE_API...
alter table D_DATA_RESOURCE_API enable all triggers;
prompt Enabling triggers for D_DATA_RESOURCE_API_PARAM...
alter table D_DATA_RESOURCE_API_PARAM enable all triggers;
prompt Enabling triggers for D_DATA_RESOURCE_REPORT...
alter table D_DATA_RESOURCE_REPORT enable all triggers;
prompt Enabling triggers for D_PRODUCT_API_REL...
alter table D_PRODUCT_API_REL enable all triggers;
prompt Enabling triggers for SYS_MENU...
alter table SYS_MENU enable all triggers;
prompt Enabling triggers for SYS_ROLE...
alter table SYS_ROLE enable all triggers;
prompt Enabling triggers for SYS_ROLE_MENU...
alter table SYS_ROLE_MENU enable all triggers;
prompt Enabling triggers for SYS_USER...
alter table SYS_USER enable all triggers;
prompt Enabling triggers for SYS_USER_ROLE...
alter table SYS_USER_ROLE enable all triggers;
set feedback on
set define on
prompt Done.
