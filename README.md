### docker-ssr-client
Docker版的ShadowsocksR镜像，带有Http代理。


### 1 修改shadowsocks/config.json
```bash
填写ssr服务器账目密码等信息
```

### 2 构建image
```bash
docker build  -t ssr_client:v1 .
```


### 3 运行
```bash
docker run -d -p1081:1081 -p1086:1086 ssr_client:v2
```

### 4 端口说明
```bash
http-proxt 端口 1081
socks5  端口 1086
```
