# BlockScout 블록 탐색기

## 개요

이 디렉토리는 Avalanche 네트워크를 위한 BlockScout 블록 탐색기 설정을 포함하고 있습니다. BlockScout은 이더리움 호환 블록체인을 위한 오픈 소스 블록 탐색기로, 블록체인 데이터를 검색하고 시각화하는 웹 인터페이스를 제공합니다.

## 구성 요소

이 설정은 다음과 같은 주요 구성 요소로 이루어져 있습니다:

1. **백엔드**: BlockScout 코어 서비스 (Elixir 기반)
2. **프론트엔드**: BlockScout 웹 인터페이스 (Next.js 기반)
3. **데이터베이스**: PostgreSQL 데이터베이스
4. **프록시**: Nginx 웹 서버 및 리버스 프록시

## 디렉토리 구조

```
blockscout/
├── envs/                 # 환경 변수 설정 파일
│   ├── common-blockscout.env  # 백엔드 환경 변수
│   └── common-frontend.env    # 프론트엔드 환경 변수
├── nginx/                # Nginx 설정
│   ├── proxy/            # 프록시 설정 템플릿
│   └── nginx.yml         # Nginx 서비스 정의
├── services/             # 서비스 정의 파일
│   ├── backend.yml       # 백엔드 서비스 설정
│   ├── db.yml            # 데이터베이스 서비스 설정
│   ├── frontend.yml      # 프론트엔드 서비스 설정
│   ├── blockscout-db-data/  # 데이터베이스 데이터 디렉토리
│   └── logs/             # 로그 파일 디렉토리
└── docker-compose.yml    # Docker Compose 설정 파일
```

## 사전 요구 사항

- Docker 및 Docker Compose가 설치되어 있어야 합니다.
- Avalanche 네트워크가 실행 중이어야 합니다 (`avax-chain` 서비스).
- 최소 4GB RAM과 20GB 디스크 공간을 권장합니다.

## 설치 및 실행 방법

1. 이 디렉토리로 이동합니다:
   ```bash
   cd blockscout
   ```

2. Docker Compose를 사용하여 BlockScout 서비스를 시작합니다:
   ```bash
   docker-compose up -d
   ```

3. 서비스 상태를 확인합니다:
   ```bash
   docker-compose ps
   ```

4. 서비스 로그를 확인합니다:
   ```bash
   docker-compose logs -f
   ```

## 접속 방법

BlockScout 웹 인터페이스는 다음 URL을 통해 접속할 수 있습니다:
- **블록 탐색기**: http://localhost:4300

## 주요 설정 파일

### docker-compose.yml

이 파일은 BlockScout의 모든 서비스를 정의하고 구성합니다. 주요 서비스로는 데이터베이스 초기화, 데이터베이스, 백엔드, 프론트엔드, 프록시가 있습니다. 모든 서비스는 Avalanche 네트워크와 동일한 Docker 네트워크에 연결됩니다.

### envs/common-blockscout.env

BlockScout 백엔드 서비스의 환경 변수를 정의합니다. 이 파일에는 다음과 같은 설정이 포함됩니다:
- 데이터베이스 연결 설정
- 블록체인 RPC 엔드포인트 설정
- 인덱싱 및 API 설정
- 기타 BlockScout 기능 설정

### envs/common-frontend.env

BlockScout 프론트엔드 서비스의 환경 변수를 정의합니다. 이 파일에는 다음과 같은 설정이 포함됩니다:
- API 호스트 및 프로토콜
- 네트워크 이름 및 통화 설정
- UI 테마 및 기능 설정

### nginx/proxy/proxy.conf.template

Nginx 프록시 설정 템플릿으로, 다음과 같은 설정을 포함합니다:
- 백엔드 및 프론트엔드 서비스로의 리버스 프록시 설정
- CORS 및 보안 헤더 설정
- WebSocket 연결 설정

## 기능

BlockScout은 다음과 같은 주요 기능을 제공합니다:

1. **블록 탐색**: 블록 번호, 해시, 트랜잭션 등으로 블록체인 데이터 검색
2. **트랜잭션 조회**: 트랜잭션 해시, 주소, 블록 등으로 트랜잭션 정보 조회
3. **주소 정보**: 계정 잔액, 트랜잭션 내역, 토큰 보유량 등 조회
4. **스마트 계약**: 스마트 계약 코드 확인, 검증, 상호작용
5. **토큰**: ERC-20, ERC-721, ERC-1155 등 다양한 토큰 표준 지원
6. **차트 및 통계**: 블록체인 활동에 대한 다양한 차트 및 통계 제공

## Avalanche 네트워크 연동

BlockScout은 Avalanche C-Chain과 연동되어 있으며, 다음과 같은 설정을 사용합니다:
- **RPC URL**: http://172.30.0.104:9656/ext/bc/C/rpc
- **WebSocket URL**: ws://172.30.0.104:9656/ext/bc/C/ws
- **Chain ID**: 43112 (Avalanche C-Chain)

## 문제 해결

- **데이터베이스 연결 오류**:
  ```bash
  docker-compose logs db
  ```

- **백엔드 서비스 오류**:
  ```bash
  docker-compose logs backend
  ```

- **프론트엔드 서비스 오류**:
  ```bash
  docker-compose logs frontend
  ```

- **데이터베이스 초기화**:
  ```bash
  docker-compose down
  rm -rf services/blockscout-db-data/*
  docker-compose up -d
  ```

## 참고 사항

- 이 설정은 개발 및 테스트 환경용으로 구성되어 있습니다.
- 프로덕션 환경에서 사용하기 전에 보안 설정을 검토하고 필요에 따라 조정하세요.
- BlockScout의 자세한 설정 및 사용 방법은 [공식 문서](https://docs.blockscout.com/)를 참조하세요.
