# Avalanche 프라이빗 네트워크 & 블록스카우트 익스플로러

이 프로젝트는 Avalanche 프라이빗 네트워크를 구축하고 블록스카우트 익스플로러를 연동하는 환경을 제공합니다.

## 구성요소

- Avalanche 노드 4개로 구성된 프라이빗 네트워크
- 블록스카우트 익스플로러 (프론트엔드, 백엔드, DB)
- Nginx 프록시 서버

## 시작하기

### 사전 요구사항

- Docker 및 Docker Compose 설치
- OpenSSL (인증서 생성용)
- Git

### 설치 및 실행

1. 저장소 클론

```bash
git clone https://github.com/yourusername/avax-private-network.git
cd avax-private-network
```

2. 인증서 생성

```bash
./staking-cert-gen.sh
```

## 네트워크 구성

### Avalanche 노드

- Node 1: API (9650), Staking (9651)
- Node 2: API (9652), Staking (9653)
- Node 3: API (9654), Staking (9655)
- Node 4: API (9656), Staking (9657)

모든 노드는 `172.30.0.0/24` 서브넷 내에서 통신합니다.

### 블록스카우트 서비스

- Frontend: 3000 포트
- Backend: 4000 포트
- Database: 7432 포트 (외부 접근용)
- Nginx Proxy: 4300 포트

## 환경 설정

### Genesis 파일

`avax-chain/genesis.json`에서 다음 설정을 확인할 수 있습니다:

- Network ID: 1234
- Chain ID: 43112
- 초기 토큰 할당
- 초기 검증인 설정

### 블록스카우트 설정

주요 환경 변수는 `blockscout/envs/common-blockscout.env`에서 관리됩니다:

- RPC 엔드포인트: `http://localhost:9650/ext/bc/C/rpc`
- WebSocket 엔드포인트: `ws://localhost:9650/ext/bc/C/ws`
- 데이터베이스 연결 정보
- API 설정

## 사용 방법

1. 네트워크 상태 확인

```bash
curl -X POST --data '{
    "jsonrpc":"2.0",
    "id"     :1,
    "method" :"info.isBootstrapped",
    "params": {
        "chain":"C"
    }
}' -H 'content-type:application/json;' 127.0.0.1:9650/ext/info
```

2. 노드 실행

반드시 블록스카우트 익스플로러 실행 전에 노드를 실행해야 합니다.

```bash
cd avax-chain
docker-compose up -d
```

3. 블록스카우트 익스플로러 실행

```bash
cd blockscout
docker-compose up -d
```

4. 블록스카우트 접속

```
http://localhost:4300
```
