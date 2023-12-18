# JavaWeb-MyStore
简易的电子商务网站

使用spring bootv3.1.4作为框架，集成jsp页面搭建的电子商务网站，用于课程设计

打包jar包的环境为jdk19，经测试在jdk19与jdk21下均可运行

数据库版本为8.0.27

管理员账号为admin，用户名为admin即可进入后台管理网站

.sql文件中只有表结构，建议导入数据库后为表productType添加几个初始项，并且数据库中的密码是由MD5加密的，故建议管理员账户采用网站中的注册页面进行注册，即注册一个用户名为admin的账号；更改位于LoginController.java中registerSuccess方法和loginSuccess方法的逻辑可以修改数据库中对密码的加密




运行前请注意：
1.修改/src/main/application.yml第15-18行(数据库连接配置)；

2.修改/src/main/application.yml第30-32行(邮件发送配置)；

3.修改/src/main/application.yml中第22行的file:/路径为你想映射为web资源访问地址的本地路径；
  如：file:static时，我将jar包放在/demo下运行，则web会从/demo/static/下获取资源(image、css、js等)；
	
4.导入数据库表结构后，在运行该spring boot程序前，请为table mystore.productType添加至少一个元组，否则jsp页面会报错，该问题由于时间原因尚未解决；

5.productType无法通过web端的接口进行变更，请通过直接修改数据库的方式进行修改；

本人学号姓名：202130442624_黄宁
