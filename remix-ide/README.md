# Remix IDE

## 개요

이 디렉토리는 Avalanche 네트워크와 함께 사용할 수 있는 Remix IDE 환경을 제공합니다. Remix IDE는 Ethereum 스마트 계약 개발을 위한 브라우저 기반 통합 개발 환경으로, 이 설정을 통해 Avalanche 네트워크에서 스마트 계약을 개발하고 배포할 수 있습니다.

## 구성 요소

이 설정은 다음 두 가지 주요 서비스로 구성되어 있습니다:

1. **Web3Signer Proxy**: 트랜잭션 서명을 위한 서비스
2. **Remix IDE**: 스마트 계약 개발 환경

## 사전 요구 사항

- Docker 및 Docker Compose가 설치되어 있어야 합니다.
- Avalanche 네트워크가 실행 중이어야 합니다 (`avax-chain` 서비스).

## 설치 및 실행 방법

1. 이 디렉토리로 이동합니다:
   ```bash
   cd remix-ide
   ```

2. Docker Compose를 사용하여 서비스를 시작합니다:
   ```bash
   docker-compose up -d
   ```

3. 서비스가 실행되면 브라우저에서 Remix IDE에 접속할 수 있습니다.

## 설정 파일

### docker-compose.yml

이 파일은 Web3Signer Proxy와 Remix IDE 서비스를 정의합니다. Web3Signer는 포트 4500에서 실행되며, 두 서비스 모두 `avax-chain_avalanche-net` 네트워크에 연결됩니다.

### config/web3signer/web3signer.yaml

Web3Signer 서비스의 설정 파일로, 다음과 같은 주요 설정을 포함합니다:
- Ethereum 체인 ID: 43112 (Avalanche C-Chain)
- 다운스트림 HTTP 호스트 및 포트
- HTTP 리스닝 설정
- CORS 설정
- 허용된 호스트 목록
- 키 저장소 경로

### config/web3signer/keys/

이 디렉토리에는 트랜잭션 서명에 사용되는 키 파일과 관련 설정이 포함되어 있습니다:
- keystore.yaml: 키 파일 위치 및 유형 정의
- keys/: 실제 키 파일 저장
- passwords/: 키 파일 암호 저장

## 사용 방법

1. Remix IDE에 접속합니다.
2. 환경 설정에서 "Web3 Provider"를 선택하고 Avalanche 네트워크의 RPC 엔드포인트를 입력합니다.
3. 스마트 계약을 작성하고 컴파일합니다.
4. Web3Signer를 통해 트랜잭션에 서명하여 Avalanche 네트워크에 스마트 계약을 배포합니다.

## 문제 해결

- 서비스 로그 확인:
  ```bash
  docker-compose logs -f
  ```

- Web3Signer 연결 문제가 발생하면 web3signer.yaml 파일의 설정을 확인하세요.
- Avalanche 네트워크 연결 문제가 발생하면 네트워크가 실행 중인지 확인하세요.

## 참고 사항

이 설정은 개발 환경용으로 구성되어 있습니다. 프로덕션 환경에서 사용하기 전에 보안 설정을 검토하고 필요에 따라 조정하세요.
