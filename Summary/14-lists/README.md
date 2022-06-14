# Chapter 14

## ForEach
단순히 iterator의 역할을 해서 View들을 나열해주는 역할을 한다.
따라서 묶어주는 역할이 없기 때문에 TabView 등에 사용할때 주의가 필요하다. 
(ForEach의 각 View가 Tab의 한 영역이 될 수 있다. ScrollView와 Containter를 이용해 묶어주는 편이다.)

ForEach는 unique한 identity parameter를 받아야한다.
가장 간단한 방법은 Hashable protocol을 채택한 parameter를 사용하는 것이다.
기본적으로 String과 Int 같은 Struct는 Hashable을 채택하고 있다.
혹은 UUID와 URL type을 사용하는 것도 한가지 방법이다.

id parameter를 쓰지않고 본인 스스로가 Hashble하도록 protocol을 채택할 수도 있다.
이 때는 `\.self` 와 같은 방식으로 object 자체를 id parameter로 넘겨주는 방법이다.

Swift 5.1부터는 Identifiable 이라는 protocol이 등장했다.
Hashable한 id parameter를 갖고있을 때 단순히 Identifiable protocol을 채택해주기만 하면 되는 방식이다.
이 경우 ForEach 에서 id parameter를 넘겨줄 필요가 없어진다.

```swift
class MyObejct: Identifiable {
    var id: Int
}

let myObjects: [MyObject]
ForEach(myObjects) { object in }
```

## ScrollView
주어진 direction에 대해 스크롤 기능을 제공해준다.
parameter로 dfirection을 입력받을 수 있으며 horizontal과 vertical 모두 지정 가능하다.

ScrollView를 사용할때는 VStack과 HStack을 단순히 사용하면 한번에 모든 cell을 다 그리기 때문에 LazyStack을 적절히 사용해야 한다.
Lazy의 한가지 특징은 유연하게 Cell Draw에 대처해야하기 때문에 사용 가능한 모든 영역을 차지하려 한다는 점이다.
예시로 다음 그림을 보면 VStack일때는 최소한의 영역만을 차지하려 했지만 Lazy의 경우 차지할 수 있는 영역을 모두 차지하는 것을 볼 수 있다.

<img width="421" alt="스크린샷 2022-06-14 오후 3 16 53" src="https://user-images.githubusercontent.com/78075226/173584956-4316dbb3-5bf3-42eb-96ed-ae68ce3f23e4.png">

## ScrollViewReader
iOS14, macOS Big Sur 부터는 ScrollViewReader가 등장했다.
기존 SwiftUI ScrollView에서는 scroll position을 programmatically 조정할 수 없었다.
우리는 이 Reader를 사용해 원하는 위치로 스크롤을 조정할 수 있게 되었다.
ScrollProxy를 Reader로부터 얻어낼 수 있으며 해당 변수에는 scrollTo 라는 함수가 존재해서 원하는 위치로 옮길 수 있다.
이 때 id parameter를 넘겨받는데 자식 View의 고유한 id를 찾아서 이동하게 만드는 역할을 한다.
또한 anchor를 이용해 scroll 위치를 조정할 수 있다.

<img width="571" alt="스크린샷 2022-06-14 오후 3 27 04" src="https://user-images.githubusercontent.com/78075226/173585307-74cb8f2b-bde1-442d-b922-9902d5483f1d.png">

## List
ScrollView와 Container의 결합으로 복잡하게 화면을 구성할 필요없이 SwiftUI에서는 List라는 struct를 제공해준다.
List는 ForEach와 유사하게 list로 사용할 object array를 받고 그 후 각 object별로 클로져를 이용해 Row를 만들어주는 형식으로 되어있다.
ForEach와 List의 가장 큰 차이점은 ForEach는 하나의 element에 대해 원하는 View를 몇개든 만들어줄 수 있지만 List는 하나의 Column Data당 하나의 Row를 만드는 것이라는 차이가 존재한다.
만약 Element가 Identifiable 하다면 ForEach와 마찬가지로 id paramter 없이 만들 수 있다.

```swift
List(elements) { element in
    // Set Custom Element View
}
```

- List에서도 마찬가지로 ScrollViewReader가 작동을 한다.
- iOS 기준으로 이전에 설명했듯이 Row가 NavigationLink를 포함하고 있다면 작은 > 아이콘도 자동적으로 생성이 된다는 것에 유의하자.
- LazyStack와 같이 Row는 차지할 수 있는 모든 width를 차지한다.
- SwiftUI는 list를 항상 lazy하게 render한다!

## Hierarchical List
List에는 날짜 - 도시 - 비행기 순으로 계층적으로 분류가 가능할 때 Hierarchical List를 사용해 간단히 구현할 수 있다.
구현 방법은 List에 children path parameter를 넘겨주는 것으로 element 내의 children path를 찾아 자동적으로 계층을 이루게 구현해준다.
따라서 Hierarchical List를 구성하고자 한다면 계층적인 Element를 설계하는 것이 중요하다.

```swift
struct HierarchicalRow: Identifiable {
    var label: String
    var info: Information?
    var children: [HierarchicalRow]?
    
    var id = UUID()
}
```

<img width="335" alt="스크린샷 2022-06-14 오후 9 54 06" src="https://user-images.githubusercontent.com/78075226/173587271-1164f999-57fe-4ba2-b700-65a3c508b78c.png">

## Section
List에는 그룹을 짓는 방법이 존재하고 이를 Section이라 부른다.
Section은 content, header, footer를 받아서 구성할 수 있다.
유의할 점은 content 영역의 경우 Row들을 모두 나열해주어야하기 때문에 ForEach를 사용해줄 수 있다.
사용되는 모든 Section 역시 List 내부에 나열되어야하며 이 때도 ForEach를 사용해줄 수 있다.
Section과 Hierarchical List의 차이는 다음과 같다.

<img width="361" alt="스크린샷 2022-06-14 오후 10 01 16" src="https://user-images.githubusercontent.com/78075226/173587257-e3cb9a9f-170b-44bb-9afa-38bc35363873.png">
