# Serverless Java17 Spring Boot Native Image Web Adapter Container Example

**Convert Spring Boot 3 to Native Image with GraalVM and launch with AWS Lambda Web Adapter**

| -                           | -                              |
|:----------------------------|--------------------------------|
| Java                        | Java17                         |
| Application Framework       | Spring Boot 3.0.6              |
| Deploy Framework            | AWS SAM CLI 1.82.0             |
| Development environment     | Ubuntu Desktop 20.04           |
| Container build environment | Docker Desktop on Linux 4.17.0 |

## Result of K6

```

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: slsjava_springboot_ni_wa_ecr.js
     output: -

  scenarios: (100.00%) 1 scenario, 200 max VUs, 31s max duration (incl. graceful stop):
           * default: 200 looping VUs for 1s (gracefulStop: 30s)


     data_received..................: 1.2 MB 467 kB/s
     data_sent......................: 137 kB 55 kB/s
     http_req_blocked...............: avg=493.65ms min=152.33ms med=514.05ms max=997.54ms p(90)=730.64ms p(95)=810.79ms
     http_req_connecting............: avg=79.5ms   min=59.27ms  med=70.96ms  max=122.14ms p(90)=109.93ms p(95)=110.28ms
     http_req_duration..............: avg=541.31ms min=28.59ms  med=569.1ms  max=1s       p(90)=879.28ms p(95)=905.08ms
       { expected_response:true }...: avg=541.31ms min=28.59ms  med=569.1ms  max=1s       p(90)=879.28ms p(95)=905.08ms
     http_req_failed................: 0.00%  ✓ 0         ✗ 200  
     http_req_receiving.............: avg=32.1µs   min=7µs      med=24µs     max=142µs    p(90)=68.1µs   p(95)=90.09µs 
     http_req_sending...............: avg=56.94µs  min=21µs     med=46µs     max=372µs    p(90)=92.6µs   p(95)=123.1µs 
     http_req_tls_handshaking.......: avg=397.37ms min=72.35ms  med=411.5ms  max=896.81ms p(90)=643.55ms p(95)=725.81ms
     http_req_waiting...............: avg=541.22ms min=28.48ms  med=569.04ms max=1s       p(90)=879.21ms p(95)=905.01ms
     http_reqs......................: 200    79.813651/s
     iteration_duration.............: avg=2.03s    min=1.73s    med=2.02s    max=2.5s     p(90)=2.23s    p(95)=2.26s   
     iterations.....................: 200    79.813651/s
     vus............................: 118    min=118     max=200
     vus_max........................: 200    min=200     max=200


running (02.5s), 000/200 VUs, 200 complete and 0 interrupted iterations
default ✓ [======================================] 200 VUs  1s
```

**CloudWatch Logs Insights**
query-string:
```
filter @type="REPORT" and ispresent(@initDuration)
| stats count() as coldStarts, avg(@maxMemoryUsed), avg(@duration), avg(@initDuration), min(@initDuration), max(@initDuration) by bin(10m)
```
---
| coldStarts | avg(@maxMemoryUsed) | avg(@duration) | avg(@initDuration) | min(@initDuration) | max(@initDuration) |
|------------|---------------------|----------------|--------------------|--------------------|--------------------|
| 161        | 99000000            | 3.2762         | 414.4176           | 216.84             | 776.54             |
---

## Getting Started

### Build
```make
make build-native-image
make sam-build
```

### Deploy (Initial)
```make
make sam-deploy-guided
```

### Deploy
```
make sam-deploy
```
