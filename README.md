# dhso/rrshare-web
> rrshare web for docker.

> 人人影视WEB客户端 docker版

# 运行 run
```bash
docker run -d \
--name rrshare-web \
--restart=always \
-p 3001:3001 \
-v <media dir>:/opt/work/store \
dhso/rrshare-web:latest
```

# 配合h5ai可以实现在线播放 play videos on line with h5ai
```bash
docker run -d \
--name h5ai \
-p 10080:80 \
-v <media dir>:/h5ai \
ilemonrain/h5ai:full
```