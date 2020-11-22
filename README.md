## MarketPlace配置

感觉插件有很多对部署不友好的bug，我折腾了好几天也没在master机器上部署成功。

主要体现在以下：

1. 官方的给的镜像用不起来，没有识别我传进去的rest_server入口参数；

2. 与master主机上的服务端口冲突，而且修改端口后rest_server无法访问数据库，应该也是没有识别外部传入的参数； 

3. master机器的许多参数被openpai部署程序修改，导致无法个性化定制，比如在master机器上启动自己的docker容器会无法联网等等。

最后我的实现方案是在Worker机器上自己构建镜像来部署MarketPlace。过程比较复杂，还得去学Nginx，Dockerfile，docker-compose等，所以我也没想要写教程。我把我的配置文件共享出来即可，有兴趣的自己研究，没兴趣那就直接用。

项目地址：[https://github.com/siaimes/openpaimarketplace](https://github.com/siaimes/openpaimarketplace)

执行步骤：

1. 将项目克隆到worker机器家目录；

2. 修改`openpaimarketplace/webportal_plugin/Dockerfile`中的WrokerIP为你的工作节点IP；

3. 运行`./build.sh`构建镜像；

4. 修改nginx配置文件中的ssl为你的ssl证书信息，证书的生成按照[这个文档执行即可](https://github.com/microsoft/pai/blob/master/docs_zh_CN/manual/cluster-admin/basic-management-operations.md#%E5%A6%82%E4%BD%95%E8%AE%BE%E7%BD%AEhttps%E8%AE%BF%E9%97%AE)，区别在于加密参数写2048，1024太短了，nginx不接受；

5. 运行`sudo docker-compose up -d`启动服务。

6. 在openpai配置文件中相关位置填入[https://WorkerIP/openpaimarketplace_webportal/plugin.js](https://WorkerIP/openpaimarketplace_webportal/plugin.js)

这样部署有一个缺点：若是使用了自签证书，默认情况下，插件无法被加载，需要在浏览器中输入5中的地址，手动允许不安全的链接。当然，如果有公网机器和域名的话，这个问题就不是问题了。