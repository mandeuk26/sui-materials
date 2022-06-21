# Chapter 16

## Modal
Bool 변수 혹은 Optional State Variable을 사용하는 2가지 방법이 존재한다.
Optional State의 경우 non-nil이 값이 되면 작동하는 방식이다.
기본적으로 Modal, Alert 등은 Hierarchy에서 가장 마지막에 정의된 것만을 작동한다.
따라서 하나의 View에 여러가지 종류의 Modal, Alert를 띄우고 싶다면 Optional State를 주로 사용하게 된다.
이 때 Optional State는 Identifiable을 채택해야한다.

기본적인 사용방법은 다음과 같다.

```swift
SomeView()
    .sheet(
        isPresented: $Binding_Bool,
        onDismiss: { 
            // Dismiss Action
        },
        content: {
            // Modal View
        }
    )
```

## Alert
Modal 형식이 아닌 경고 형식으로 창을 띄울 때 사용한다.
방법은 다음과 같다.

```swift
SomeView()
    .alert(isPresented: $Binding_Bool) {
        Alert(title: Text(“Title”), message: Text(“Message”))
    }
```

현재 SwiftUI Alert는 Text Field 지원을 하고 있지 않다.

## Action Sheet
여러가지 선택지를 줄 때 유용한 방법으로 Bool이 아닌 Optional State를 이용해 화면을 구성할 수 있다.

```swift
SomeView()
    .actionSheet(item: $Binding_Value) { value in
        ActionSheet(
            title: Text("Check In"),
            message: Text("Check in for"),
            buttons: [
                .cancel(),
                .destructive(Text("Reschedule")),
                .default(Text("Check In"))
            ]
        )
    }
```

## PopOver
화면이 작으면 자동으로 modal sheet로 대체해서 그리기 때문에 큰 화면에서만 유용하다.
만약 작은 화면에서 pop over를 쓰고자 한다면 full-screen view가 더 나은 선택지일 것이다.
다음과 같이 사용할 수 있으며 arrowEdge는 눌렀을때 화살표가 뜨는 방향이다.

```swift
Button("On-Time History") {
  showFlightHistory.toggle()
}
.popover(
  isPresented: $showFlightHistory,
  arrowEdge: .top
) {
  FlightTimeHistory(flight: self.flight)
}
```
