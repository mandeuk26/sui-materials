# Chapter 4
## 목표
1. UITest를 SwiftUI에 추가해보자.

## Unit Test
함수가 주어진 인풋에 대해서 기대하는 아웃풋을 얻어내는지 테스트하는 방식.
Unit test가 여러개가 모여 전체적인 코드를 테스트 하는 효과를 얻어낼 수 있다.
단 Unit test 각각은 하나의 기능에만 집중해야한다.

## Integration Test
코드의 다른 부분들이 서로간에 잘 작동하는지 확인하는 테스트.
외부의 API와도 잘 동작하는지 확인하는 과정이다.

## Interface Test
UI Test라고도 불리는 테스트.
유저가 바라보는 앱의 행동을 검증하는 테스트이다.

## Debugging
기존 UIKit 과 동일하게 break point를 걸어서 디버깅 가능하다.
Preview 상에서도 Debugging이 가능한데 이 때 Live Preview 가 아닌 Debug Preview로 실행시켜주면 된다.

## UI Test
File - New - Target 에서 UI Testing Bundle을 추가한다.
기본적인 사용법은 UIKit의 Test와 동일하다.
유의할 점은 SwiftUI가 cross platform이지만 몇몇 Test 함수들의 경우 mac과 ios에 따라 지원을 할 수도 안할 수도 있기 때문에 #if #else statement를 이용해서 적절한 처리를 해줘야 한다.

만일 button을 찾고싶다면 
```swift
app.buttons[“Button Label”]
```
을 이용해서 찾을 수 있다.

만약 button이 아닌 Text가 변하는 경우는 다음과 같은 속성을 사용해서 찾을 수 있다.
```swift
Text("MyText")
    .accessibilityIndentifier("MyIdentifier")
    
let display = app.staticTexts["MyIdentifier"]
```

다음과 같은 속성들을 이용해 볼 수 있다.
- swipeLeft() : 왼쪽으로 swipe 이벤트를 보낸다. 그외에도 up, down, right가 있다.
- exists : XCUIElement가 존재하는지 확인할 수 잇다. 만약 visible 하지 않다면 false를 return한다.
- isHittable : element가 exist하고 user가 클릭할 수 잇는지를 확인한다.
- typeText() : 마치 유저가 text를 입력한 것처럼 control 해준다.
- press(forDuration:) : 정해진 시간만큼 press를 하는 것처럼 control 해준다.
- press(forDuration:thenDragTo:) : swipe 메소드는 정교한 제스쳐가 불가능하다. 만약 precise drag를 해주고 싶다면 이를 사용한다.
- waitForExistence() : element가 화면에 즉시 등장하지 않을 경우 잠시 pause를 시켜준다.
