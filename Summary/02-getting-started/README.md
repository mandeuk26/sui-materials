# Chapter 2
## 목표
1. UI와 Code간의 1:1 상호작용을 확인하며 View를 그려본다.
2. 재사용 가능한 View 만들기.
3. @State property
4. Alert 띄우기

## SwiftUI LifeCycle
UIKit과는 달리 더이상 AppDelegate는 없다. 
대신 App Protocol을 채택한 struct로부터 WindowGroup을 만들고 시작한다. 
@main이라는 키워드는 해당 struct가 앱의 시작지점이 됨을 의미해준다. 
따라서 해당 struct에서 생성하는 View로부터 앱이 시작된다.

<img width="324" alt="chapert2-1" src="https://user-images.githubusercontent.com/78075226/168428544-42b2f69b-a922-4d5e-bf62-bcf769bb7ad0.png">

## SwiftUI Preview
SwiftUI에서는 Preview를 제공해 빠르게 View를 확인할 수 있게 해준다.
PreviewProvider라는 protocol을 채택한 뒤 previews 라는 변수 내부에 화면에 보이게 하고싶은 View를 만들어주면 된다.
Xcode 우측 상단 Resume 버튼을 클릭하면 언제든 지정해놓은 scheme에 맞는 preview를 볼 수 있다. (`Option-Command-P`)

<img width="425" alt="chapter2-2" src="https://user-images.githubusercontent.com/78075226/168428548-e2e8b1bf-1a2c-413b-aa33-061c5d4c44e0.png">

## SwiftUI work with Preview
UIKit에서는 Storyboard를 이용하여 View를 그릴수도 있었고 ViewController를 이용해 코드로 View를 그릴 수도 있었다.
SwiftUI에서도 놀랍게도 두가지 방식을 모두 사용할 수 있다.
Preview를 이용해 Storyboard에서 수정하는 것처럼 하려면 Preview 상에서 특정 커멘드를 누르고 View를 클릭하면 된다.
혹은 특정 커멘드를 누른채로 Code상에서 해당 View의 Code를 눌러도 동일하게 동작한다.

`Command-Click`을 이용해 특정 View를 클릭해보면 여러개의 Container가 등장하고 이 중 하나를 클릭하면 실제로 코드에 반영이 된다. Container(VStack, HStack 등) 뿐만 아니라 만들어놓은 View를 하나의 SubView로 추출하고 싶다면 Extract Subview 버튼을 누르게 되면 View의 정보를 바탕으로 Struct를 생성해줄 수 있다!

`Control-Option-Click` 을 하게되면 SwiftUI inspector를 열 수 있다. 여기에서 Text라던지 Padding이라던지 여러 속성을 수정할 수 있다.

우측 상단의 + 버튼을 누르면 LIbrary에서 만들어져있는 여러 View들을 선택해 drag-drop으로 추가할 수 있다. 
이 때 기존 Container에 넣고자 할 때 위치에 따라서 동작이 바뀐다는 것을 명심해야한다. 
예를들어 단순히 존재하는 Container 내부에 추가할 수도 있지만 새로운 상위 Container를 생성해서 기존의 Container를 묶을 수도있다.
추가로 drag한 위치가 View의 위쪽이면 새로운 Library View는 기존 View의 상단에 위치하게 되고, drag 위치가 기존 View 아래쪽이라면 하단부분에 위치하게 된다.

## @State property
SwiftUI에서는 view의 @State로 지정한 property 값이 변하게 되면 UI를 업데이트 한다. 
@State property의 값이 변하면 View는 body를 다시 계산해서 새로운 UI를 만들게 된다. 

## @Binding property
state와 달리 View가 소유권을 직접적으로 갖고있는 것이 아니라 다른 곳에 선언된 State Variable을 갖고와서 mutate하고자 할 때 사용한다.
따라서 하나의 property를 여러개의 View에서 접근하고 변경해야한다면 최상단의 View에 @State property로 선언해준 후 해당 값을 하위 View에 @Binding property로 넘겨주는 것이 좋다.

## Alert
Alert의 경우 @State variable을 활용해서 구현한다.
Alert 역시 하나의 Modifier로 기존의 View에 .alert(isPresented:) 을 활용해서 alert를 설정할 수 있다.
이 때 isPresented는 @State값에 대한 @Binding을 생성해주어 Alert 내부에서 mutate 할 수 있도록 해줘야한다.
나중에 dismiss시에 넘겨준 property가 자동으로 false로 변하는 것은 이 이유이다.

만약 isPresented에 설정한 프로퍼티가 true가 된다면 Alert가 뜨게된다. 
이 때 Alert(title:message:dismissButton:)과 같은 형태로 Alert를 생성해주어야한다.

<img width="389" alt="chapter2-3" src="https://user-images.githubusercontent.com/78075226/168428549-880ec6f8-ed32-48c9-afa3-a7c1b5fed3ea.png">

