
<hr>
<!--프로젝트 처음-->


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

# Skills
- iOS Platform (macOS- Xcode), Swift, UIKit
- Firebase(storage, authentication, realtime, realtime database), OAuth 2.0
- NMapsMap, KakaoAPI, OpenWeatherAPI, PostMan, Alamofire, JSON
- COCOAPODS, FSCalendar
- Singleton Pattern, MVC Pattern
- Sketch, Lottie-ios, Github
- AwesomeUI (DropDown, SSCustomTabbar, EASegments)

# 시스템 구성도
![image](https://user-images.githubusercontent.com/55241258/141675310-f08457d6-67e2-4a0f-ae14-426dd96ec60f.png)

# Contributions
- MVC 디자인 패턴을 적용해 프로젝트를 설계하고 구성하였습니다.
- Singleton 패턴을 적용하여 유저, 여행 정보를 하나의 객체로 저장하여 사용하였습니다.
- Alamofire 라이브러리로 비동기적인 네트워크 통신을 구현하였습니다.
- cell을 Xib로 따로 빼서 관리하였습니다.
- NaverMap, Kakao Local API 를 이용한 장소 찾기 및 설정하였습니다.
- firebase로 데이터를 관리 및 사용하였습니다.
  - 유저 데이터 관리 및 사용
  - 여행 데이터 관리 및 사용

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
- 세부일정
    - Toggle를 이용하여 선택된 일정만 보여지도록 구현
    - **NaverMap**을 이용해 "나의 여행 동선" 를 마커로 표시
    - **Kakao Local API** 를 이용한 장소 찾은 후 등록
    - 날씨 API를 이용하여 날짜별로 해당 날씨 표시

### 기타

- 폰트 적용
- Cell을 xib파일을 이용하여 관리
- **Firebase**의 CRUD를 이용하여 유저 데이터 관리
