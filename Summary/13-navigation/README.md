# Chapter 13

## Navigation Style
SwiftUI navigation은 2개의 스타일로 구성된다.
- flat : tabView를 주로 사용, 다른 뷰들 사이를 자주 이동할 필요가 있을 때, 각 내용이 category별로 분리될 수 있을때 사용, 유저는 어떤 정보든 빠르게 접근할 수 있지만 catrgory가 많아지면 오히려 사용성을 해친다.
- hierarchical : top은 최대한 줄이고 deep한 구조를 구성, user가 layer를 옮길 필요가 많이 없을 때 유용하거나 점점 구체적인 information을 제공하고자 할 때 유용하다.

<img width="284" alt="스크린샷 2022-06-09 오후 6 21 32" src="https://user-images.githubusercontent.com/78075226/173588450-8cdc4e0e-a024-4360-85c2-325f53303fed.png">

<img width="283" alt="스크린샷 2022-06-09 오후 6 21 35" src="https://user-images.githubusercontent.com/78075226/173588465-39b3e67f-4bf5-4640-9713-656b56cf5618.png">

## Navigation View
여러 View를 Stack 형식으로 쌓는 방식을 제공해주는 View이다.
즉 Navigation Stack의 시작 포인트를 지정해주는 역할을 한다.
Navigation View를 implement하게 되면 top toolbar와 child view로부터 해당 view로 돌아올 수 있는 link를 생성해준다.
Navigation View에서는 Backward로 갈 수는 있지만 다른 children으로 jump하는 것은 불가능하다.

SwiftUI에서는 split-view interface를 지원한다.
일부 화면은 정지해있지만, 다른 화면은 stack을 기반으로 다른 화면으로 navigate 될 수 있다.

|![aaaa](https://user-images.githubusercontent.com/78075226/173593541-49655fd9-7173-47e5-822f-c8e153bedeaf.png)|![bbbb](https://user-images.githubusercontent.com/78075226/173593552-b32d4516-73bb-4854-bbf5-2d136d901bce.png)|
|---|---|

## Navigation Link
User에게 navigation stack에서 더 깊은 곳으로 이동할 수 있게 해준다.
destination을 통해 유저가 link를 클릭했을때 이동할 View를 정해줄 수 있다.

```
NavigationLink(destination: SomeView()) {
    // View to shown as link
}
```

## NavigationView 유의점
기본적으로 작은 iphone과 Apple TV, 에서는 navigation stack 사용이 기본이 된다.
그러나 큰 iPhone, iPads, mac에서는 기본적으로 split-view style의 navigation을 적용해준다.
이를 막기 위해서는 .navigationViewStyle(_:) 을 이용해서 StackNavigationViewStyle로 변경해주도록 해야한다.

<img width="899" alt="스크린샷 2022-06-09 오후 7 01 48" src="https://user-images.githubusercontent.com/78075226/173593384-cf022423-2841-42e5-bdb0-3a053bdeada8.png">

```
NavigationView {

}
.navigationViewStyle(.stack)
```

Navigation Link를 List와 같이 사용하면 > 표시의 아이콘이 각 행의 마지막에 표시가 된다.
이런 정보는 유저가 tap 했을때 더 많은 정보를 얻을 수 있음을 알려주며 자동적으로 적용되는 요소이다.

## NavigationBarTitle
Navigation View를 위한 title을 지정해 줄 수 있다.
이 때 Navigation View가 아닌 Layer가 되는 각 View에 Title을 지정해주어야 한다. (Navigation View에 modifier를 지정하면 아무것도 바뀌지 않는다.)
NavigationTitle은 기본적으로 자식에게 전달되지 않기 때문에 각 View 별로 Title을 지정해주어야한다.

만약 Preview를 사용해 Navigation에 들어갈 View를 보고자한다면 Preview에서는 해당 View가 NavigationView Stack에 포함되어있는지 알지 못한다.
따라서 preview에서는 navigation bar가 보이지 않을 수 있다.
이럴때는 preview struct에서 NavigationView를 포함하도록 변경하는 방법을 추천한다.

```swift
Struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomView()
        }
    }
}
```

SwiftUI는 아직 Navigation Title Bar의 Text style 혹은 background를 바꾸는 방법을 제공해주고 있지 않다.
Navigation Title은 다음 화면으로 이동햇을때 back button의 title로 사용된다.
그러나 그 길이가 너무 길다면 < Back 으로 변경된다.

iOS14부터는 기본적인 back 버튼을 long-press하면 hierarchy 상에서 한번에 이동할 수 있는 기능이 추가되었다.
이 떄 title을 제공하지 않았다면 blank list를 보여주게 된다.

## Toolbar
navigationBarItems는 deprecated 되고 toolbar에 통합되었다.
toolbar modifier는 위 혹은 아래쪽에 bar영역에 item을 표시하고 싶을때 사용한다.
사용 방법은 다음 그림과 같으며 placement에 주는 값에 따라 위치가 결정된다.

<img width="510" alt="스크린샷 2022-06-13 오후 7 01 14" src="https://user-images.githubusercontent.com/78075226/173593778-0be15c13-b324-4dcf-abe1-43aee324bc5c.png">

주의할 점은 navigation에만 쓰이는 것이 아니기 때문에 placement 값 중에 적절한 것을 찾아 써야한다.
SwiftUi가 적절한 위치를 찾아주는 Semantic placement가 존재하고 혹은 정확한 위치를 정해주는 Positional placement가 존재한다.
#### Semantic
- automatic
- principal
- status 
#### Positional
- navigationBarLeading
- navigationBarTrailing
- cancellationAction
- etc

## NavigationLink Programmatically
Binding Bool을 묶어서 Navigation을 Code로 동작시킬 수 있다. 
이 때 content 영역에 아무것도 넣지 않으면 화면에 보이지 않으나 code로 link동작만 하게 만들 수 있다.

```swift
NavigationLink(
    destination: FlightDetails(flight: flightInfo.flights.first!),
    isActive: $showNextFlight
) {}
```

혹은 selection 파라미터를 활용해 variable이 특정 값과 일치할 경우 link를 trigger 시킬 수 있다. 이 때 tag parameter를 활용해 특정 값을 지정해주면 된다.

```swift
NavigationLink("link test", tag: 3, selection: $SelectionInt, destination: CustomView())
// SelectionInt가 3이 되면 link 작동
```

## Navigation Data Back Up
SwiftUI에서는 Environment 를 활용해 간단히 구현할 수 있다.
이 때 NavigationView 자체에 environmentObject를 선언해줘야 view hierarchy 속에서 제대로 동작한다.
(View들이 Stack에 쌓이는 형태이지 상위 View가 하위 View를 들고있는 방식이 아님을 기억하자.)
