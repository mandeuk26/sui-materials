# Chapter 6

## 목표
1. TextField, Button, Stepper 등에 대해 배워보자

## TextField
User의 키보드 입력을 받는 View
- title: placeholder text
- text : Binding<String> managed property, Binding 매개변수를 넘겨 변화를 @State 변수에 반영시킨다.
- formatter : String이 아닌 Date 혹은 특정 양식의 Number를 받는 TextField일때 지정해준다.
- onEditingChanged : focus를 받으면 true, focus를 잃으면 false를 입력받는 클로저 함수
- onCommit : 유저가 commit action을 취했을때 실행하는 클로져 함수

textFieldStyle 이라는 modifier가 존재해서 textField에 특정 style을 적용할 수 있다.
- PlainTextFieldStyle
- RoundedBorderTextFieldStyle
- SquareBorderTextFieldStyle (macOS only)

만약 당신이 Custom된 TextField를 원한다면 다음 3가지 방법이 존재한다.
1. 여러 modifier를 직접 textfield에 적용시킨다.
2. 본인만의 custom TextFieldStyle을 만든 후 적용시킨다.
3. 여러 modifier를 묶어 본인만의 custom modifier를 만들어낸다.

2번의 경우 5장에서 사용하던 makeBody 함수와 형태가 다르다.
다음과 같이 정의를 해줘야한다.
```swift
struct KuchiTextStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        return configuration
            // apply your modifier
    }
}
```

3번의 경우는 다음과 같다.
```swift
struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            // Apply custom modifier to content
    }
}

ModifiedContent(
    content: TextField("Type your name...", text: $name),
    modifier: BorderedViewModifier()
)
```

그러나 일반적으로 사용하는 모습과는 좀 다르다. 따라서 다음과 같이 변형해서 사용한다. 이 기법은 TextField 만이 아니라 다른 View에도 적용시킬 수 있기 때문에 범용성이 좋다.
```swift
extension View {
    func bordered() -> some View {
        ModifiedContent(
            content: self,
            modifier: BorderedViewModifier()
        )
    }
}

TextField("Type your name...", text: $name)
    .bordered()
```


## ObservedObject
@State와 비슷한 역할을 한다. class 내부의 변화가 일어났을때 다른 객체에게 알려줄 수 있는 Object임을 나타내준다.

## EnvironmentObject
Environment 변수로 앱 전체적으로 여러 곳에서 필요할때 쓰기 위한 변수를 말한다.
주입받을때는 .environmentObject() modifier를 이용한다.

## Buttons
SwiftUI Button 은 Label이 View이기 때문에 단순히 Text, Image 뿐만 아니라 Stack이 될 수도 있고 어떤 복잡한 View든 올 수 있게 된다.
크게 Action과 Label로 구성되어 있으며 Tap Handler가 아닌 Action이라고 불리는 이유는 iOS, macOS, WatchOS를 모두 지원하기 위해 각각에 맞는 handler를 쓰는 trigger handler이기 때문이다.
이때 Label보다 Action이 먼저 오는 이유는 SwiftUI부터는 pattern이 변해서 View Declaration이 항상 마지막 parameter가 되었기 때문이다.

- disabled(Bool:) 유저 interaction이 가능한지 아닌지 설정해줄 수 있다. (아무 View나 사용 가능)

## Toggle
Boolean control을 해주는 check box 같은 친구이다.
Toggle 조절시 반영이 될 Binding bool 변수와 Label을 입력으로 받는다.

- fixedSize() : toggle로 하여금 ideal size를 유지하게 한다. 붙이지 않는다면 공간을 차지할때까지 expand한다.

## Slider
- value : Binding<V>, 변경할 값
- bounds: ClosedRange<V>, 범위
- step : There interval of each step
- onEditingChanged : editing 시작과 끝날때 해야할 클로저 함수

## Stepper
Sliding 대신 2개의 버튼으로 증감시키는 방식, slider와 매우 유사
- title : 타이틀, 주로 현재 값을 같이 표시한다.
- value : Binding<V>, 변경할 값
- bounds: ClosedRange<V>, 범위
- step : There interval of each step
- onEditingChanged : editing 시작과 끝날때 해야할 클로저 함수

## SecureField
TextField와 거의 같지만 user의 input을 숨겨주는 기능이 있음
- title : PlaceHolder 내용
- text : 변경할 String 값
- onCommit : commit action시 할 클로져
