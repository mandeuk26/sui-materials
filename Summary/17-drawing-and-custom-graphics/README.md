# Chapter 17

## Shape
SwiftUI에서 제공하는 Default 도형
종류로는 다음과 같이 존재한다.

- Rectangle
- Circle
- Ellipse
- Rounded Rectangle
- Capsule

이때 Shape는 fill 혹은 stroke를 사용해서 그릴 수 있는데 fill은 내부를 채울때 사용하고 stroke는 도형을 따라 선분을 그릴 때 사용한다.

## Gradient Color
단순히 Color 1개로만 색을 칠하는 것이 아니라 Gradient Color를 사용하면 점차 변하는 Color를 표현할 수 있다.
Gradient는 Color의 배열로 표현을 할 수 있으며 Gradient를 이용해서 `LinearGradient` 등에 넣어 표현하게 된다.
Gradient는 단순히 순차적으로 변하게 하고 싶다면 LinearGradient를 사용하지만 그 외의 `AngularGradient, EllipticalGradient, RadialGradient` 등을 사용할 수 있다.

## Path
기본적으로 제공해주는 Shape 도형 외에 본인이 정의한 모양을 그리고 싶을 때 사용한다.
다음과 같이 사용할 수 있으며 등장한 함수 외에도 다양한 함수로 모양을 그릴 수 있다.

- move : 정해진 위치로 옮긴다. 이 때 시작점을 옮기는 것일 뿐 path에 추가되지는 않는다.
- addArc : 호 모양의 경로를 Path에 추가한다. 중요한것은 가로축이 0이며 degree가 증가할수록 반시계 방향으로 증가한다는 것이다.
- closeSubpath : 그리는 경로를 닫아 끝내는 역할을 한다.

```swift
Path { pieChart in
    pieChart.move(to: center)
    pieChart.addArc(
        center: center,
        radius: radius,
        startAngle: .degrees(startAngle),
        endAngle: .degrees(endAngle),
        clockwise: true
    )
    pieChart.closeSubpath()
}
```

## Drawing Group
과도한 Visual의 사용은 앱의 속도를 저하시킬 가능성이 있다.
이때 Apple의 Metal을 사용하여 Visual 처리를 시킬 수 있으며 `drawingGroup()` modifier를 사용한다.
주의할 점으로는 오히려 간단한 작업을 Metal에 맡기는 것은 성능을 오히려 떨어뜨리기 때문에 적절한 사용이 필요하다는 것이다.
