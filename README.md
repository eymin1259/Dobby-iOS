<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuhpeZ%2FbtsKqwzj7Nd%2FK5UAi4MQpy1wWa7sGndCJK%2Fimg.png">

# Dobby
- 도비는 공동생활을 하는 사람들을 위한 가사분담 및 집안일 일정관리 어플리케이션 입니다.
- [App Store(iOS)](https://apps.apple.com/kr/app/id1658783993), [App Store(WatchOS)](https://apps.apple.com/kr/app/id1658783993?platform=appleWatch)

# Updates
- v1.0.2 : 버그 픽스 및 UI 수정
- v1.0.1 : 도비 WatchOS 출시
- v0.9.2 : 버그 픽스 및 UI 수정
- v0.9.1 : 월간 집안일 조회 기능 및 매일 알람 기능 추가
- v0.8.2 : 버그 픽스 및 UI 수정
- v0.8.1 : 도비 iOS 출시

# Skills

| iOS                                                                                                                                        | WatchOS                                                                                   |
|--------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|
| - Clean Architecture, MVVM-C<br>- RxSwift, RxDataSources, RxCocoa, RxGesture, RxMoya<br>- SnapKit, UIKit<br>- Core Data<br>- CocoaPods | - Clean Architecture<br>- RxSwift<br>- SwitUI<br>- WCSession, Swinject<br>- CocoaPods |

# Developments
iOS
- Coordinator 패턴을 적용하여 ViewController로 부터 화면전환 로직 및 ViewController간의 의존성 분리
- 재사용가능한 Custom View 개발하여 일간,주간,월간 집안일 조회 UI 및 집안일 등록 모달 구현
- Kakao, Apple OAuth2.0 소셜로그인 개발 및 토큰 갱신 네트워크 모듈 개발
- 일간, 주간, 월간 집안일 조회, 생성, 수정, 삭제등 집안일 관리 기능 개발 및 앱스토어 출시

WatchOS
<br>
- Clean Architecture로 설계된 도비 iOS App의 도메인 모듈, 데이터 모듈 재사용
- 효율적인 의존성 관리를 위해 DIContainer 한 곳에서 객체간 의존성 관리
- WCSession 통신으로 iOS App과 상호간의 Oauth 토큰 업데이트 로직 개발
- 일간 집안일 조회 및 유저정보 조회 기능 개발 및 앱스토어 출시

<br>

# Clean Architecture기반 MVVM-C 패턴 어플리케이션 설계
<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fcd219u%2FbtsKoVUWSxi%2FcS3qrwchvLiosWKtk0aCPk%2Fimg.png">
<br>

- 클린아키텍처를 기반으로하여 어플리케이션을 Presentation, Domain, Data 3개의 Layer로 분리
- Presentation Layer는 화면전환, 유저의 액션 핸들링, 상태 처리를 담당하는 모듈로 Coordinator, ViewModel, ViewController들을 정의
- Domain Layer는 비즈니스 로직을 담당하는 모듈로 외부로부터 독립적이고 재사용 가능. UseCase, Entity들을 정의하고 Domain으로부터 데이터가 API인지 DB인지 의존성을 분리하기위해 Repository Interface 정의
- Data Layer에서는 데이터 처리를 담당하는 모듈로 Repositor 프로토콜에대한 구현체, DTO, Data Sources 개발
- Coordinator에서 화면전환 로직과 의존성주입을 담당함으로써 massive ViewController 문제 해결 및 viewController사이의 의존성 분리


# 재사용가능한 Custom View 개발
<img src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FBWkBy%2FbtsKpDe0thc%2F8jrj5OXzeneGF0FNqMPKp0%2Fimg.png">
<br>

- UIScrollView와 UIStackView를 활용하여 재사용 가능한 일별 집안일 리스트 View 개발 및 일간, 주간, 월간 ViewController에서는 날짜 데이터를 집안일 리스트 View에 전달만 함으로써 UI 개발
- 재사용 가능한 모달을 구현하여 viewModel과 모달의 body만 넘겨주면 모달의 애니메이션과 유저 액션 및 데이터처리가 적용된 모달 생성
