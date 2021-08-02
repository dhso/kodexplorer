# dhso/kodexplorer
> kodexplorer for docker.
> 
> current version: 4.46


## 运行 run
```bash
docker run -d \
--name kodexplorer \
--restart=always \
-p 10800:80 \
-v <kodexplorer dir>:/var/www/html \
dhso/kodexplorer:latest
```

## 编译
```bash
docker build -t dhso/kodexplorer .
```
