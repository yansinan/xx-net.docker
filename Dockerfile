FROM debian:stable-slim
#MAINTAINER Dr
#更新软件源为国内https://blog.csdn.net/zmzwll1314/article/details/100557519
#RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories
#RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list  #错误：只适用于ubuntu
# RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list
# RUN sed -i s@/security.debian.org/debian-security@/mirrors.aliyun.com/debian-security@g /etc/apt/sources.list
RUN sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
#20220305::stable/updates这个路径被更新了，需要换掉
RUN sed -i 's/stable\/updates/stable-security\/updates/' /etc/apt/sources.list 
#通用方法：报错了
# RUN sed -i "s@http://\(deb\|security\).debian.org@http://mirrors.aliyun.com@g" /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update

# bash
RUN apt install nano fish -y
RUN apt install git -y
# RUN apt install wget unzip -y
RUN apt install python3-openssl libffi-dev libnss3-tools -y
#20220305:: 更新国内源后出现：用aptitude解决后面两个包无法定位的问题：
# aptitude 与 apt-get 一样，是 Debian 及其衍生系统中功能极其强大的包管理工具。
# aptitude 在处理依赖问题上更佳一些。举例来说，aptitude 在删除一个包时，会同时删除本身所依赖的包。这样，系统中不会残留无用的包，整个系统更为干净。
# 最后还是没装上，不装也能用....
# RUN apt install aptitude -y
# RUN aptitude install python-gtk2 python-ayatana-appindicator -y

# 获取临xx-net
#RUN wget https://github.com/XX-net/XX-Net/archive/4.4.3.zip
#RUN wget https://github.com/XX-net/XX-Net/archive/4.7.2.zip
RUN git clone https://github.com/XX-net/XX-Net.git

# 要执行的第一步操作


#RUN unzip 4.7.2.zip
#WORKDIR /XX-Net-4.7.2/

#配置文件


# 设置权限
# RUN chmod 777 /home/node/bin/*

EXPOSE 1080/tcp 8085/tcp 8086/tcp 8087/tcp

#ENTRYPOINT ["/XX-Net-4.7.2/start"]
ENTRYPOINT ["/XX-Net/start"]

# docker run -it --name xx-net --net=nginxNet --restart=always -p 8085:8080 -p 8087:8087 -p 1080:1080 debian/xx-net
# docker run -it --name xx-net --net=nginxNet --restart=always -v $(pwd)/data:/XX-Net/data  -p 8085:8080 -p8086:8086 -p 8087:8087 -p 1080:1080 debian/xx-net
