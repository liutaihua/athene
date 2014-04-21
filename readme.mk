# 日志分析

**athene** 把原始文件转换到数据库里的记录



#### 输入

原始日志文件

`format=json userid=1133 uri=/scene/back_to_city client=flash sessionid=178624daba3e1e42223bcef60d77947d tag=1363259186725 time=2013-03-14_19:05:27.102052 consume_time=0 accountid=11
consume_time=0 uri=/admin/leave time=2013-03-14_19:05:27.272039
union_name=gh4 format=json userid=1115 uri=/union/create client=flash sessionid=8f69bd9f15d02f89ae3ec7788148aa7f tag=1363259179907 time=2013-03-14_19:05:29.146812 consume_time=0 accountid=20
consume_time=0 uri=/admin/leave time=2013-03-14_19:05:29.704592
`

一行一条记录

k=v 形式，空格分割


#### 项目结构

`athene/source` 表示数据源

`processor` 是处理脚本

`run.py` 入口脚本

#### 数据库结构

`schema` 存放所有表结构文件

每个表使用userid, key, time作为主键