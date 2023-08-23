# "`Что такое DevOps. СI/СD`" - `Petr`

### Задание 1

![Скрин 1](https://github.com/tprvx/Netology-Homeworks/blob/8.3-Netology/img_homework/1.1.png?raw=true)

![Скрин 2](https://github.com/tprvx/Netology-Homeworks/blob/8.3-Netology/img_homework/1.2.png?raw=true)

![Скрин 3](https://github.com/tprvx/Netology-Homeworks/blob/8.3-Netology/img_homework/1.3.png?raw=true)

---

### Задание 2

##### Код пайплайна:
```pipeline
stages:
  - test
  - build

test:
  stage: test
  image: golang:1.17
  script: 
   - go test .

static-analysis:
 stage: test
 image:
  name: sonarsource/sonar-scanner-cli
  entrypoint: [""]
 variables:
 script:
  - sonar-scanner -Dsonar.projectKey=myproject1 -Dsonar.sources=. -Dsonar.host.url=http://192.168.1.152:9000 -Dsonar.login=<sqp_token>

build:
  stage: build
  image: docker:latest
  script:
   - docker build .

```

![Скрин 1](https://github.com/tprvx/Netology-Homeworks/blob/8.3-Netology/img_homework/2.1.png?raw=true)

![Скрин 2](https://github.com/tprvx/Netology-Homeworks/blob/8.3-Netology/img_homework/2.2.png?raw=true)

![Скрин 3](https://github.com/tprvx/Netology-Homeworks/blob/8.3-Netology/img_homework/2.3.png?raw=true)
