# Домашнее задание к занятию "`Что такое DevOps. СI/СD`" - `Пётр`

### Задание 1

![Скрин 1](https://github.com/tprvx/Netology-Homeworks/blob/8.2-Netology/img_homework/1.1.png?raw=true)

![Скрин 2](https://github.com/tprvx/Netology-Homeworks/blob/8.2-Netology/img_homework/1.2.png?raw=true)

---

### Задание 2

##### Код пайплайна:
```pipeline
pipeline {
 agent any
 stages {
  stage('Git') {
   steps {
   git 'https://github.com/tprvx/8.2-Netology_dop.git'
   }
  }
  stage('Test') {
   steps {
    sh 'go test .'
   }
  }
  stage('Build') {
   steps {
    sh 'docker build .'
   }
  }
 }
}
```

![Скрин 1](https://github.com/tprvx/Netology-Homeworks/blob/8.2-Netology/img_homework/2.1.png?raw=true)

![Скрин 2](https://github.com/tprvx/Netology-Homeworks/blob/8.2-Netology/img_homework/2.2.png?raw=true)

---

### Задание 3

##### Код пайплайна:
```pipeline
pipeline {
 agent any
 stages {
  stage('Git') {
   steps {
   git 'https://github.com/tprvx/8.2-Netology_dop.git'
   }
  }
  stage('Test') {
   steps {
    sh 'go test .'
   }
  }
  stage('Build') {
   steps {
    sh 'go build -a -installsuffix nocgo -o /tmp/sample .'
   }
  }
  stage('Upload') {
   steps {
    sh 'curl --fail -u admin:12345 --upload-file /tmp/sample http://localhost:8081/repository/my_raw_repo/'
   }
  }
 }
}
```

![Скрин 1](https://github.com/tprvx/Netology-Homeworks/blob/8.2-Netology/img_homework/3.1.png?raw=true)

---

## Дополнительные задания (со звездочкой*)

### Задание 4

##### Код пайплайна:
```pipeline
pipeline {
 agent any
 stages {
  stage('Git') {
   steps {
   git 'https://github.com/tprvx/8.2-Netology_dop.git'
   }
  }
  stage('Test') {
   steps {
    sh 'go test .'
   }
  }
  stage('Build') {
   steps {
    sh 'go build -a -installsuffix nocgo -o /tmp/sample_v$BUILD_NUMBER .'
   }
  }
  stage('Upload') {
   steps {
    sh 'curl --fail -u admin:12345 --upload-file /tmp/sample_v$BUILD_NUMBER http://localhost:8081/repository/my_raw_repo/'
   }
  }
 }
}
```

![Скрин 1](https://github.com/tprvx/Netology-Homeworks/blob/8.2-Netology/img_homework/4.1.png?raw=true)

---
