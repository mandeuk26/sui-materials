# Chapter 10
## 목표
1. List, stepper, toggle, picker에 대해 배운다
2. AppStorage에 대해 이해하고 배운다.

## List
UIKIt의 TableView와 유사한 View이다.
Section을 사용해서 영역을 구분할 수 있다.

## Stepper
Title, binding value, range를 설정해줄 수 있는 +/- 형식의 버튼이다.
Title은 기본적으로 좌측에 위치하고 있으며 range를 넘어서는 입력은 무시된다.

## Toggle
Title과 Binding Bool Value를 받아서 만드는 토글 버튼이다.
Title은 기본적으로 좌측에 위치하고 있다.

## DatePicker
날짜 선택을 해주는 View로 title과 조절을 할 Binding Date Value를 받게 되어있다.
displayedComponents 파라미터를 이용해 시간, 날짜 중 보여줄 항목을 제한할 수 있다.
default는 전부 보여주게 되어있다.

## DatePickerStyle
modifier를 이용해 DatePicker의 스타일을 변경할 수 있다.
#### iOS
- CompactDatePickerStyle : Default, 날짜와 시간으로 나뉘어진 형태
- WheelDatePickerStyle : wheel 조정으로 시간과 날짜를 조정하는 형태
- GraphicalDatePickerStyle : calendar 형태

#### Mac
- GraphicalDatePickerStyle : calendar 형태
- FieldDatePickerStyle : textField 형태로 date와 time을 입력받는 형태
- StepperFieldDatePickerStyle : Default, 위와 비슷하지만 옆쪽에 stepper가 존재해 조절할 수 있게 되어있는 형태

## Binding
평소에 쓰는 $ 형태 외에도 Binding이라는 객체를 통해서 주입해 줄 수 있다.
이 때 get/set 2가지 파라미터가 존재하고 각각 binding read와 write시 해줄 액션을 정의할 수 있다.
binding 값이 변경되었을때 특정 동작을 수행하고자 할 때 유용하게 사용할 수 있다.

## ColorPicker
DatePicker와 유사하게 Color도 피커를 통해 고를 수 있다.
Title, Binding Color Value, Alpha enable flag 를 입력받을 수 있다.
Alpha enable flag의 경우 default는 true이다.

## Picker
Color, Date와 같은 특정 값이 아닌 범용적으로 사용할 수 있는 Picker View이다.
Title, binding value, Slider Content View로 구성된다.
Picker의 스타일 종류는 매우 다양하며 다음과 같다.
- inline : list형식으로 보여준 후 선택된 것이 체크된 형태, 변경은 안되는 듯 보인다
- menu : menu가 떠서 고르는 방식
- radioGroup : mac에만 사용가능, radio button으로 표시하는 방식
- segmented : segment button style
- wheel : wheel 형식으로 돌려서 선택하는 방식
- automatic : default, pciker의 콘텐츠에 따라 보여주는 방식

일반적으로 picker를 선택해도 binding value가 변하지 않는다.
왜냐하면 단순히 content view일 뿐 값을 가지고 있는것이 아니기 때문이다.
tag modifier를 이용해서 각각의 view에 특정 value를 대입시켜주면 pick시 해당 값이 대입된다.

## Tab bar
TabView를 이용해 안에 Tab Section을 하나하나 정의한다.
Content로 받는 View들은 해당 Tab이 눌렸을 때 보여줄 화면을 결정짓는다.
이때 각각의 Content View들은 tabItem과 tag modifier를 정의해주어야하는데 tabItem modifier는 Tab Bar에 보여질 View를 정의해주는 영역이고 tag는 몇번째 section으로 쓰일지 결정해주는 modifier이다.

## @AppStorage
유저의 Setting을 저장하기 위해서는 UserDefaults를 사용해야한다.
SwiftUI에서는 UserDefault의 값을 State처럼 사용할 수 있는 new property wrapper를 소개해주었다.
@AppStorage라는 attribute로 State 혹은 Binding처럼 사용할 수 있다.
이 때 key값을 입력해주어야한다! `ex) @AppStorage("KeyString")`
초기값은 UserDefaults에 해당 Key Value가 존재하지 않으면 default로 쓰는 값이 된다.

App Storage에는 다음과 같은 type을 저장할 수 있다.
- Basic data types : Int, Double, String, Bool etc
- Composite types : Data, URL
- Any types adopting RawRepresentable

만약 UserDefaults에 저장할 수 없다면 `Shadow Property`를 쓰는 것도 한 방법이다.
예를들어 Date는 UserDefaults에 저장할 수 없지만 Double은 저장 가능하므로 Double을 중간 매개체로 사용하는 방식이다.

## @SceneStorage
만약 App이 아닌 Scene별로 Storage를 적용하고 싶을때 사용하면 유용한 @SceneStorage attribute이다.
