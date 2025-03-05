# Avalanche 노드 구성

## 개요

이 디렉토리는 Avalanche 네트워크의 프라이빗 노드를 구성하기 위한 설정 파일과 스크립트를 포함하고 있습니다. 총 4개의 검증 노드로 구성된 로컬 Avalanche 네트워크를 Docker 컨테이너를 통해 실행할 수 있습니다.

## 구성 요소

이 설정은 다음과 같은 주요 구성 요소로 이루어져 있습니다:

1. **4개의 Avalanche 노드**: 각 노드는 독립적인 Docker 컨테이너로 실행됩니다.
2. **제네시스 블록 설정**: 프라이빗 네트워크의 초기 상태를 정의합니다.
3. **노드별 설정 파일**: 각 노드의 네트워크 및 API 설정을 정의합니다.
4. **스테이킹 인증서**: 노드 간 통신을 위한 TLS 인증서와 키 파일을 포함합니다.

## 디렉토리 구조

```
avax-chain/
├── configs/              # 노드별 설정 파일
│   ├── node1.json
│   ├── node2.json
│   ├── node3.json
│   └── node4.json
├── chains/               # 체인별 설정 파일
├── data/                 # 노드 데이터 저장 디렉토리
├── staking/              # 스테이킹 인증서 및 키 파일
│   ├── node1/
│   ├── node2/
│   ├── node3/
│   └── node4/
├── genesis.json          # 제네시스 블록 설정
└── docker-compose.yml    # Docker Compose 설정 파일
```

## 사전 요구 사항

- Docker 및 Docker Compose가 설치되어 있어야 합니다.
- 최소 8GB RAM과 50GB 디스크 공간을 권장합니다.

## 설치 및 실행 방법

1. 이 디렉토리로 이동합니다:
   ```bash
   cd avax-chain
   ```

2. Docker Compose를 사용하여 Avalanche 노드를 시작합니다:
   ```bash
   docker-compose up -d
   ```

3. 노드 상태를 확인합니다:
   ```bash
   docker-compose ps
   ```

4. 노드 로그를 확인합니다:
   ```bash
   docker-compose logs -f
   ```

## 네트워크 구성

- **네트워크 ID**: 1234 (프라이빗 네트워크)
- **C-Chain Chain ID**: 43112
- **노드 IP 주소**:
  - 노드 1: 172.30.0.101
  - 노드 2: 172.30.0.102
  - 노드 3: 172.30.0.103
  - 노드 4: 172.30.0.104

## API 엔드포인트

각 노드는 다음과 같은 API 엔드포인트를 제공합니다:

- **노드 1**: http://localhost:9650
- **노드 2**: http://localhost:9652
- **노드 3**: http://localhost:9654
- **노드 4**: http://localhost:9656

## 주요 설정 파일

### genesis.json

제네시스 블록 설정 파일로, 다음과 같은 주요 설정을 포함합니다:
- 네트워크 ID: 1234
- 초기 토큰 할당
- 초기 스테이커 설정
- C-Chain 제네시스 설정

### configs/nodeX.json

각 노드의 설정 파일로, 다음과 같은 주요 설정을 포함합니다:
- HTTP API 설정
- 스테이킹 설정
- 로깅 설정
- 메트릭스 설정
- 부트스트랩 노드 설정

## 스테이킹 인증서

각 노드는 다음과 같은 스테이킹 관련 파일을 가지고 있습니다:
- `staker.crt`: 노드 인증서
- `staker.key`: 노드 개인 키
- `signer.key`: 트랜잭션 서명용 키

## 사용 방법

### 노드와 상호작용

Avalanche 노드와 상호작용하기 위해 다음과 같은 방법을 사용할 수 있습니다:

1. **Avalanche CLI**:
   ```bash
   avalanche --api-endpoint=http://localhost:9650
   ```

2. **cURL**:
   ```bash
   curl -X POST --data '{
     "jsonrpc": "2.0",
     "method": "info.isBootstrapped",
     "params": { "chain": "C" },
     "id": 1
   }' -H 'content-type:application/json' http://localhost:9650/ext/info
   ```

3. **Web3.js** (C-Chain과 상호작용):
   ```javascript
   const web3 = new Web3('http://localhost:9650/ext/bc/C/rpc');
   ```

### 스마트 계약 배포

C-Chain에 스마트 계약을 배포하기 위해 Remix IDE와 함께 사용할 수 있습니다. 자세한 내용은 `remix-ide` 디렉토리의 README를 참조하세요.

## 문제 해결

- **노드가 시작되지 않는 경우**:
  ```bash
  docker-compose logs avalanche-node1
  ```

- **노드 간 연결 문제**:
  노드 설정 파일의 `bootstrap-ips`와 `bootstrap-ids` 설정을 확인하세요.

- **데이터 초기화**:
  ```bash
  docker-compose down
  rm -rf data/*
  docker-compose up -d
  ```

## 참고 사항

- 이 설정은 개발 및 테스트 환경용으로 구성되어 있습니다.
- 프로덕션 환경에서 사용하기 전에 보안 설정을 검토하고 필요에 따라 조정하세요.
- 노드 간 통신은 TLS로 암호화되어 있지만, API 엔드포인트는 기본적으로 암호화되어 있지 않습니다.
