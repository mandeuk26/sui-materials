# Chapter 7

## 목표
1. Container View에 대해서 알아보자.

## Size 규칙
기존 UIKit에서 constraint를 사용할때는 parent를 기준으로 child의 크기를 지정했었다.
그러나 SwiftUI에 들어와서는 child의 size가 각각 있고 부모의 frame size를 기반으로 적절한 size를 정하는 방식이다.

1. 부모 뷰는 사용가능한 frame을 결정한다.
2. 부모 뷰는 이를 자식 뷰에게 제시한다.
3. 자식 뷰는 부모 뷰로부터 받은 제안을 기반으로 본인의 크기를 결정한다.
4. 부모 뷰는 자식 뷰를 포함할 수 있는 적절한 사이즈를 결정한다.

이는 일반적인 View 구조 뿐만 아니라 modifier stack에서도 동일하게 적용된다.
예를들어 다음과 같은 코드에서 frame modifier에서 size를 정한 뒤 이를 Text에게 알려 Text가 해당 Frame 속에서 적절한 size를 찾게 되어있다. 
마치 부모 자식 뷰처럼 말이다.

```swift
Text(“Test String”)
  .background(Color.red)
  .frame(width: 150, height: 50, alignment: .center)
  .minimumScaleFactor(0.5)
  .background(Color.yellow)
```

- minimumScaleFactor : 만약 Text 표시를 다 할 수 없을 때 Text Scale를 감소시킬 수 있게해주는 modifier

Text와 다르게 Image의 경우는 .resizable() Modifier를 붙여주지 않으면 부모에서 Size를 제안해도 무시하고 본인의 Size를 유지한다. 
View 중에서 일부는 Text처럼 부모 뷰에 맞춰서 변화시키는 것도 있지만 일부는 Image처럼 본인의 Size를 유지하는 것도 있다는 것을 명심하자. 
또 일부는 padding 처럼 자식 뷰의 사이즈에 단순히 wrap 하는 방식의 View도 존재한다.

## Stack Views
Container View는 다음과 같은 방법으로 Layout을 정한다.

1. 사용 가능한 영역을 확인한다.
2. 자식 뷰 중 가장 restrictive constraint를 가진 자식뷰를 찾는다. 만일 동일하다면 가장 사이즈가 작은 뷰를 찾는다.
3. 해당 뷰에게 사이즈를 제안하고 자식뷰가 사이즈를 정하면 해당 사이즈 만큼 사용 가능 영역을 줄인다.
4. 모든 자식뷰가 사이즈를 정할때까지 2-3을 반복한다.

놀랍게도 이 규칙이 적용되면 다음과 같은 View는 두개가 동일한 크기를 갖지 않게 된다.

```swift
HStack {
    Text("A great and warm welcome to Kuchi")
          .background(Color.red)
    Text("A great and warn welcome to Kuchi")
        .background(Color.red)
}
```

<img width="335" alt="스크린샷 2022-05-17 오후 8 44 42" src="https://user-images.githubusercontent.com/78075226/168815081-6622e21a-f5f1-4764-82f6-c56df33c5945.png">

만약 Layout 순서를 바꾸고 싶다면 modifier 혹은 priority를 사용해보자.
먼저 Modifier의 경우 예를들어 Image에 resizable을 붙이면 adaptive하게 변하는 것처럼 modifier를 통해서 constraint를 조절할 수 있다.

또다른 방법으로는 priority로 .layoutPriority Modifier를 사용하면 view의 priority를 정해줄 수 있다.
이 때 일반적으로 [-1, 1] 을 많이 사용하는데 Stack은 절대 값이 높을수록 먼저 실행하고 절대값이 낮을수록 나중에 실행하는 특징이 있다. 
또 만약 음수 값의 경우는 priority가 없는 view들이 모두 처리된 이후에 실행된다는 특징이 있다.

<img width="461" alt="스크린샷 2022-05-17 오후 9 00 02" src="https://user-images.githubusercontent.com/78075226/168815090-43a3d70f-2a05-4d42-a979-11cc5a928572.png">

Priority 변경은 유의할 점이 있다. 
이것은 단순히 sort order를 변경하는 것 뿐만 아니라 parent에서 size를 제안하는 방식이 변한다는 특징이 있다.
만약 동일한 priority를 가진 뷰가 여러개 있다면 Parent는 각각에 대해 균일한 영역을 제안하지만, priorirty가 다른 뷰가 존재한다면 가장 우선순위가 높은 뷰에게 size를 제안할 때 다른 뷰들을 위한 최소한의 영역을 뺀 나머지 전체를 제공한다는 특징이다.

## HStack / VStack
Content 영역 뿐만 아니라 2개의 속성이 더 있다.
- Alignment : align 속성 지정, default는 .center이다. 기본적으로 VStack은 `.center, .leading, .trailing`이 존재하지만 HStack의 경우 `.center, .bottom, .top` 외에도 `.firstTextBaseline, .lastTextBaseline`이라는 속성이 존재한다. firstTextBaseline는 가장 최상단의 Text View에 맞춰 정렬하는 기능이고 lastTextBaseline은 가장 하단의 Text View에 맞춰 정렬하는 기능이다.
- Spacing : 각 뷰들 사이의 distance 값, default는 platform-dependent한 값을 적용시킨다.

## ZStack
Priority에 영향을 받지 않는다.
가장 먼저 선언된 View가 가장 아래로 가게되는 방식으로 가장 큰 Width와 Height에 맞춰 크기가 결정된다.

#### Stack은 10개 넘어서 자식을 가질 수 없다는 것은 문서화되진않았지만 해보면 cryptic error 메시지가 뜨게된다.

## @EnvironmentObject
앞서 설명했던 environmentObject에 추가 설명을 하자면 하위뷰에 EnvironmentObject가 존재할시 .environmentObject()로 넘겨줄 필요가 없다.
왜냐하면 하위뷰에 modifier가 공통으로 적용되기 때문에 상위뷰에서 한번 넘겨주게 되면 하위뷰는 자동으로 공통된 Object를 사용하게 된다!!

## Lazy Stack
만약 TableView와 같이 많은 수의 view를 포함해야할 경우 모든 것을 메모리에 들고 잇는 것은 비효율적이다.
따라서 필요할때만 뷰를 불러오는 것이 좋다. 
이것을 해주는 것이 Lazy Stack View로 LazyVStack / LazyHStack 2가지가 존재한다.

## Section
이 때 LazyStack은 Header를 가질 수 있다. (Footer도 동일하게 할 수 있다.)
Lazy Stack 내부에서 Section을 정의해주고 생성자로 만들 때 Header View를 지정해주면 정해진 Header를 가진 하나의 Section이 만들어진다.
이 때 Header는 스크롤시 같이 이동하게 되는데 이를 상단에 고정시키고 싶다면 LazyStack 생성시 `pinnedViews` 속성에 [.sectionHeaders] 를 지정해주자.

## ForEach
SwiftUI View에서는 for-in 구문을 쓸 수 없다. 
대신 ForEach를 이용해 반복적으로 View를 만들 수 있다.
- data : 반복할 collection data structure
- id : Hashable한 KeyPath, 각각의 element가 collection에서 unique하도록 지정해야한다. `\.self` 를 이용해 element 자체를 id로 쓸 수 있다.
- content : 각각의 element가 가질 View

## ScrollView
단순히 LazyStack을 쓴다고해서 스크롤이 되지는 않는다.
만약 Scroll 기능을 넣고 싶다면 ScrollView 하위에 LazyStack을 집어넣어야한다.

