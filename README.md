# 📚 HarryPotter Series App (해리포터 책 시리즈 앱)

> 해리포터 시리즈 정보를 JSON 데이터로부터 로드하여, 시리즈별 책의 제목, 저자, 발매일, 요약, 챕터 등을 보여주는 iOS 앱입니다.
앱 실행 시 기본으로 첫 번째 책 정보가 표시됩니다. 상단 버튼을 눌러 다른 시리즈로 전환할 수 있습니다.

<br>

## ⏰ 프로젝트 일정 
- **시작일**: 2025/06/11 
- **종료일**: 2025/06/24

<br>

## 📌 주요 기능
- 시리즈별 해리포터 책 정보 탐색
- 각 책의 요약, 헌정사, 챕터 정보 확인
- 요약 내용 더 보기 / 접기 토글 기능
- JSON 기반 데이터 파싱

<br>

## 🛠 기술 스택
- Swift
- Xcode
- `UIKit`
- `SnapKit`: 오토레이아웃 코드 구성
- MVC 패턴
- `JSONDecoder`: 날짜 파싱을 위한 `dateDecodingStrategy` 사용
- `UserDefaults`: 요약 펼침 여부 저장
- iOS 16.0 이상 지원

<br>

## 📂 프로젝트 구조
```
HarryPotterSeriesApp/
├── Controller/
│   └── MainViewController.swift        # 헤더/컨텐츠 구성, 네트워크 호출과 에러 핸들링
├── View/
│   ├── MainHeaderView.swift            # 상단 제목 및 시리즈 선택 버튼
│   ├── MainContentView.swift           # 하단 책 상세 정보 (스크롤뷰)
│   └── MainContentView+Layout.swift    # 스택뷰 구성 함수들 (이미지 및 책 정보, 요약 및 헌정사, 챕터 리스트)
├── Model/
│   ├── Book.swift                      # 구조체 정의
│   └── DataService.swift               # JSON 데이터 로드
├── Resource/
│   ├── Assets
│   └── data.json
```

<br>

## 💻 실행 화면
|정상 실행|JSON 파일을 찾을 수 없을 경우|JSON 파싱 실패했을 경우|
|---|---|---|
| <img width="363" alt="스크린샷 2025-06-24 오전 10 04 32" src="https://github.com/user-attachments/assets/2f072b98-7216-4d45-bbf0-68d9846e1d7f" /> | <img width="363" alt="스크린샷 2025-06-24 오전 10 03 39" src="https://github.com/user-attachments/assets/1d8c10ed-2b94-4dfe-8bdd-d16fa20ce647" /> | <img width="363" alt="스크린샷 2025-06-24 오전 10 04 08" src="https://github.com/user-attachments/assets/c99a076b-dfb2-4d9a-870b-51481dffbb2c" /> |

<br>

## 🎯 개발 목적
- JSON 데이터 파싱 및 모델 매핑 학습
  - `Codable`, `CodingKeys`, `JSONDecoder.dateDecodingStrategy` 사용
- UIKit 기반 UI 컴포넌트 구성 능력 향상
  - `UIStackView`, `UILabel`, `UIButton`, `UIScrollView` 등의 활용
- 동적 레이아웃 구성 및 반응형 UI 설계 실습
  - `SnapKit`을 사용한 AutoLayout 설정
- 상태 관리 및 사용자 상호작용 처리 학습
  - `UserDefaults`, 버튼 클릭 이벤트, View 업데이트 흐름 설계
- 기능 단위로 뷰 구성 및 재사용성 고려한 컴포넌트화 연습
  - View를 역할별로 나누고 확장성 있게 설계

<br>

## ✨ 향후 개선 아이디어
- 챕터 선택 시 상세 내용 보여주기
- URL 링크 클릭 시 Safari로 이동
- Dark Mode 지원
- 즐겨찾기 기능 추가

<br>

## 📦 설치 및 실행 방법
1. Xcode 설치
2. 프로젝트 클론
```bash
git clone https://github.com/Pjh01/HarryPotterSeriesApp.git
```
3. Xcode에서 프로젝트 열기
4. 시뮬레이터에서 실행 및 확인
