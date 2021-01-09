FROM debian:stable-slim
#MAINTAINER Dr
#更新软件源为国内https://blog.csdn.net/zmzwll1314/article/details/100557519
#RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update

# bash
RUN apt install nano fish wget unzip -y
RUN apt install python3-openssl libffi-dev python-gtk2 python-ayatana-appindicator libnss3-tools -y

# 获取临xx-net
RUN wget https://github.com/XX-net/XX-Net/archive/4.4.3.zip

# 要执行的第一步操作


RUN unzip 4.4.3.zip
WORKDIR /XX-Net-4.4.3/



# 设置权限
# RUN chmod 777 /home/node/bin/*

EXPOSE 1080/tcp 8085/tcp 8087/tcp

ENTRYPOINT ["/XX-Net-4.4.3/start"]


# docker run -it --name xx-net --net=nginxNet --restart=always -p 8085:8080 -p 8087:8087 -p 1080:1080 debian/xx-net