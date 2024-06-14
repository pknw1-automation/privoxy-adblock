# privoxy-adblock
![logo](https://i.imgur.com/xBYqP0y.png)

A privoxy image with pre-built filters and actions from easylist, updated at build time for in-situ ad-blocking and filtering.


### command line
```
docker run -d -p 8118:8118 pknw1/privoxy-adblock:latest
curl --proxy localhost:8118 https://www.google.com
```

### docker-compose
```
services:
  privoxy-adblock:
    image: pknw1/privoxy-adblock:latest
    dns:
      - 1.1.1.1
      - 8.8.8.8
    container_name: privoxy-adblock
    hostname: privoxy-adblock
    ports:
      - 0.0.0.0:8118:8118
```

## Based on 
```
https://github.com/essandess/adblock2privoxy
https://github.com/pierre42100/docker-privoxy-alpine
```

## Todo
- incorporate adblock2privoxy to update lists at startup rather than build time
