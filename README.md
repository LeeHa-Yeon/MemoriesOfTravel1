
<hr>
<!--프로젝트 처음-->
🎥 <a href="https://www.youtube.com/watch?v=vR2c5IVgbhs"/> 유튜브로 시연영상 확인하기 </a>&nbsp

# 여기선 🛫
> 프로젝트 기간 : 2021.10.01 ~ 2021.10.30
>> 개인프로젝트 
<div align=center> 
<img width="850" alt="스크린샷 2021-11-14 오후 6 36 36" src="https://user-images.githubusercontent.com/55241258/141675599-ec58894c-33ff-4430-b2c0-9dd730ec2dee.png">
</div>
<hr>


# 목차
- 프로젝트 소개
- Skills
- 시스템 구성도
- Contributions
- 세부 구현
- 상세 화면
- 어려웠거나 아쉬웠던 점

<hr>

# 프로젝트 소개

<p>
<b>"여기선"</b>이란 여행의 기억을 선명하게라는 뜻을 줄인 말입니다.<br>
여기선은 여행 시작부터 마무리까지 모든 것을 기록하는 여행 플랫폼 앱 서비스입니다.<br>
이 서비스는 여행지를 등록한 후 해당 여행을 준비하고 관리할 수 있습니다. 
한 여행지마다 다음과 같은 기능들이 존재합니다. 준비물을 챙길 수 있는 체크리스트, 등록된 일정 확인, 그에 따른 동선확인, 가계부, 여행 앨범, 여행 리스트 등 모든 여행들은 디데이를 통해 여행 전과 후를 자동으로 구분되어져 편리하게 관리할 수 있고 시간이 지나도 나의 여행들을 되돌아보면서 추억을 상기시킬 수 있습니다.
</p>

<hr>

# Skills
- iOS Platform (macOS- Xcode), Swift, UIKit
- Firebase(storage, authentication, realtime, realtime database), OAuth 2.0
- NMapsMap, KakaoAPI, OpenWeatherAPI, PostMan, Alamofire, JSON
- COCOAPODS, FSCalendar
- Singleton Pattern, MVC Pattern
- Sketch, Lottie-ios, Github
- AwesomeUI (DropDown, SSCustomTabbar, EASegments)

<hr>

# 시스템 구성도
![image](https://user-images.githubusercontent.com/55241258/141675310-f08457d6-67e2-4a0f-ae14-426dd96ec60f.png)

<hr>

# Contributions
- MVC 디자인 패턴을 적용해 프로젝트를 설계하고 구성하였습니다.
- Singleton 패턴을 적용하여 유저, 여행 정보를 하나의 객체로 저장하여 사용하였습니다.
- Alamofire 라이브러리로 비동기적인 네트워크 통신을 구현하였습니다.
- cell을 Xib로 따로 빼서 관리하였습니다.
- NaverMap, Kakao Local API 를 이용한 장소 찾기 및 설정하였습니다.
- firebase로 데이터를 관리 및 사용하였습니다.
  - 유저 데이터 관리 및 사용
  - 여행 데이터 관리 및 사용

<hr>

# 개발 화면
<img width="656" alt="스크린샷 2021-11-15 오전 3 31 48" src="https://user-images.githubusercontent.com/55241258/141693825-7672f1df-a596-4bc8-acaa-cc36c77b08a1.png">
<img width="656" alt="스크린샷 2021-11-15 오전 3 31 58" src="https://user-images.githubusercontent.com/55241258/141693832-924eb8a4-41c4-460e-9333-dda4df73755b.png">
<img width="656" alt="스크린샷 2021-11-15 오전 3 32 10" src="https://user-images.githubusercontent.com/55241258/141693848-5dae516b-6fa0-4703-9dfd-bbbb339a8815.png">

<img width="656" alt="스크린샷 2021-11-15 오전 3 32 38" src="https://user-images.githubusercontent.com/55241258/141693867-9014704d-41ea-4b54-928a-cdf10e3deb5a.png">
<img width="581" alt="스크린샷 2021-11-15 오전 3 33 10" src="https://user-images.githubusercontent.com/55241258/141693904-74a0bc97-3148-4c2d-8be1-3889211cdef3.png">

<img width="586" alt="스크린샷 2021-11-15 오전 3 33 39" src="https://user-images.githubusercontent.com/55241258/141693929-2ffce56c-c91e-45eb-ab5e-184841d116a0.png">
<img width="737" alt="스크린샷 2021-11-15 오전 3 37 05" src="https://user-images.githubusercontent.com/55241258/141694040-b6827a25-11d8-4f35-981f-efcd462fcedc.png">
<img width="734" alt="스크린샷 2021-11-15 오전 3 37 24" src="https://user-images.githubusercontent.com/55241258/141694048-38c774e5-bb68-405f-92fb-ac40ee558fe7.png">
<img width="753" alt="스크린샷 2021-11-15 오전 3 38 55" src="https://user-images.githubusercontent.com/55241258/141694096-1f9aa8e6-7837-4804-af4f-b643b4c5400b.png">
<img width="549" alt="스크린샷 2021-11-15 오전 3 39 08" src="https://user-images.githubusercontent.com/55241258/141694103-f1efaae6-3816-4829-809c-e8f03e9533df.png">


<hr>

# 세부 구현
### **로그인, 회원가입**

- **FirebaseAuth** 로 회원 관리
- 프로필 등록 : 사진첩에서 이미지를 불러오는 **ImagePicker** 외부 패키지 사용
- textField 위 키보드 가림 현상을 Keyboard Notification, AutoLayout 을 이용하여 구현
- 모든 내용이 기입시 버튼 활성화하도록 isEnabled 이용하여 설정

### 정보 관리

- 유저와 여행에 대한 정보들을 **Firebase Database** 에 저장 및 사용
- **Singleton Pattern**을 적용하여 유저, 여행 정보를 하나의 객체로 저장하여 사용
    - 여러번 호출하지 않는 점으로 메모리를 아낄 수 있음
    - 정해진 값을 여러곳에서 공유하여 사용

### 날짜 지정

- **FSCalendar**를 이용해 선택한 "여행날짜" 셀로 표시
- 여행기간을 시각적으로 보이도록 셀 연결을 통해 구현
- Date Formatter를 이용하여 Date - String 원하는 format으로 만들어서 사용

### 여행지 검색

- 검색한 여행지만 TableView에 띄우도록 설정

### 여행 설정

- 여행 리스트를 TableView안에 CollectionView를 구현
- 여행 정보 보기
    - 여행에 대한 상세 정보
    - 동행자 추가, 삭제 구현
    - **OpenWeatherAPI**를 이용해 해당 지역 날씨 정보 표시
- 세부일정
    - Toggle를 이용하여 선택된 일정만 보여지도록 구현
    - **NaverMap**을 이용해 "나의 여행 동선" 를 마커로 표시
    - **Kakao Local API** 를 이용한 장소 찾은 후 등록
- 체크리스트
- 가계부
- 앨범

### 세부 일정 관리

- segmentControl로 일정을 날짜별, 지도 형태 중 선택
    - 날짜별로 일정 관리
        - 일정 등록, 일정 보기, 메모 추가, 일정 순서 조정, 일정 삭제 등 기능 수행
        - 직접 지도로 일정 등록
    - 지도로 동선 확인
        - 시작점은 하늘색마커, 경로는 회색마커, 도착점은 분홍색마커로 표시
        - 날짜를 선택하여 볼 수 있도록 "dropDown" 적용
        - 만약 없을 경우 알림창으로 없음을 알려줌

### 여행 체크리스트

- 체크박스를 이용하여 준비 완료 여부를 구분하도록 구현
- 준비물을 등록 부분 구현
- TableView를 Edit 설정
    - 우선순위를 지정할 수 있도록 순서조정, 스와이프하여 삭제

### 여행 가계부

- 예상경비를 등록, 예상경비와 쓴 돈으로 자동 계산하여 남은 비용을 표시
- 새 지출 등록, 해당 지출 내역 표시, 지출 상세정보 확인
- 지출 등록시 날짜 선택하는 부분에서 여행 기간 중에서만 선택할 수 있도록 설정

### 여행 앨범

- **Firebase Storage**를 이용하여 사진 관리
    - 나의 사진을 업로드, 새로고침 기능

### 마이페이지

- 나의 정보 표시, 나의 여행 횟수, 로그아웃 기능

### 기타

- 폰트 적용, 앱 아이콘 생성, 로딩화면 생성
- Cell을 xib파일을 이용하여 관리
- **Firebase**의 CRUD를 이용하여 유저 데이터 관리
- AutoLayout 적용
- AwesomeUI를 이용 : TabBarController, SegmentControl, collectionViewDelegate 적용
- 리팩토링으로 코드 개선 및 중복제거
- Git을 이용하여 버전관리

<hr>


# 어려웠거나 아쉬웠던 점

저는 모델 설계와 데이터관리를 하는 것이 어려웠습니다.

"잘못된 모델 설계"
프로젝트 도중 데이터 설계를 잘못하여 다시 설계 후 전체 대공사를 진행한 적이 있습니다. 이때 코드가 지저분하여 수정하기 어려웠습니다. 따로 폴더로 빼서 싱글턴으로 관리하였습니다. 이때 리팩토링에 대한 중요성과 가독성 좋고 유지보수를 하기 용이한 클린 코드를 지향하는 이유를 깨달았습니다.

"데이터관리"
저는 파이어베이스로 데이터를 관리 및 사용하였습니다. 이때 원하는 부분에 데이터를 가져오고 싶었지만 제가 생각했던 바와 다르게 한 템포 늦게 정보가 오는 문제가 있었습니다. 이는 비동기 통신인 점을 간과했던 문제였습니다. 저는 비동기 통신이 끝나기 전에 싱글턴을 이용해 데이터를 저장하고 화면을 전환하는 방식으로 해결했습니다.
