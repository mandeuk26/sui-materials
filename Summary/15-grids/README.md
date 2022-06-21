# Chapter 15

## Grids
초창기 SwiftUi에는 CollectionView와 같은 grid 기술이 없었다.
따라서 VStack과 HStack의 조합으로 구성하는 수 밖에 없었다.

Grid는 LazyHStack과 LazyVStack을 기반으로 동작한다.
사용방법은 LazyVGrid를 활용해서 columns로 어떻게 원소들을 배치할지 정해준 뒤 그 곳에 들어갈 Item들을 한꺼번에 넘겨주는 방식이다.
예를들어 다음과 같이 구성할 수 있다.

```swift
LazyVGrid(columns: [
    GridItem(.fixed(160)),
    GridItem(.fixed(160))
], spacing: 15) {
    FlightStatusButton(flightInfo: flightInfo)
    SearchFlightsButton(flightInfo: flightInfo)
    AwardsButton()
    LastViewedButton(
        flightInfo: flightInfo,
        appEnvironment: appEnvironment,
        showNextFlight: $showNextFlight
    )
}
```

여기서 GridItem을 fixed로 선언했는데 이 때 실제 Item 크기는 다음 원소를 위한 공간인 5pt를 뺀 155 point가 된다.
Spacing은 Row들간의 Spacing을 의미한다.
그리드는 LazyHGrid도 존재하며 이경우 지금과 반대로 동작하게 된다.

## Flexible Grids
Flexible GridItem은 주어진 영역의 최솟값과 최댓값을 통해 유연하게 View를 그릴 수 있게 해준다.

## Adaptive Grids
기존 방식은 하나의 열/행에 몇개의 원소가 들어갈지 미리 정해놓기 떄문에 만약 공간이 더 생겨도 더 많은 원소를 배치하지 않는다.
이를 해결하기 위해서 나온 것이 adaptive grid로 하나만 정의해도 채울 수 있는 한 가장 많이 원소를 채워주는 역할을 한다.

## Section
Grid에 Section을 적용시키면 자동적으로 영역을 나누어 Grid를 그리게 된다.
마찬가지로 Header, Footer를 지정해주면 각 영역의 시작과 끝에 원하는 View를 배치할 수 있다.
