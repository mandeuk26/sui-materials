# Chapter12
## Accessibility 고려 요소
- Understandable : 각 element가 적절한 정보를 제공해야한다.
- Interactable : 각 요소가 적절한 기본 액션을 하도록 설정해야한다.
- Navigable : 순서를 묶고 바꾸는 등의 작업으로 정보를 제공하는 속도를 올려야한다.

## Accessibility by default
SwiftUI는 default로 accessibility element를 정의해준다. 
따라서 유저는 별다른 작업 없이 기본적인 정보를 제공받을 수 있다. 

## Accessibility Attributes
모든 accessible UI는 다음 두개의 attribute를 갖는다.
- Frame : element location and size in CGRect
- Label : element의 label

UI는 다음 중에서 1개 혹은 그 이상의 attribute를 갖는다.
- Traits : type 또는 state를 설명, `accessibility(addTraits:)` 또는 `accessibility(removeTraits:)`를 통해 추가/삭제 가능, VoiceOver는 자동적으로 읽어주기 때문에 label에 trait를 포함하지 말아야한다.
- Value : content가 변할 수 있다면 value를 갖는다. `accessibilityValue(_:)`를 통해 value를 만들어 줄 수 있으며 대표적으로 slider에서 유의미하게 사용할 수 있다.
- Hint : voiceOver가 label을 읽은 후 유저가 아무것도 하지 않으면 hint를 읽는다. `accessibilityHint(_:)`를 통해 정의해줄 수 있다. 유저가 해당 element와 interact하면 무엇이 일어나는지 설명해줘야한다.
- identifier : UITest에 사용되는 attribute, label이 존재하지 않거나 너무 길거나 애매모호할 때 사용한다.

## Accessibility Modifier
- accessibilityHidden : 특정 element의 accessibility를 끄고싶을때 사용
- accessibilityElement : Container의 children을 묶거나 하고싶을때 사용
- accessibilitySortPriority : 기본적으로 좌측상단부터 읽는 것이 기본 룰이다. 만약 읽는 순서를 바꾸고 싶다면 sort priority를 조절해 사용해야한다. default는 0으로 적용되어있다.
- accessibilityInvertColors : 화면의 색상을 반전시키는 옵션이다. 그러나 모든 색상을 반전시키기때문에 만약 invert를 원하지 않는 element가 있다면 `accessibilityIgnoresInvertColors`를 맞춰주어야한다.
- colorSchemeContrast : 컬러와 text 스타일을 바꿔주는 옵션이다. 기본적으로 컬러 비율은 7:1 혹은 그 이상을 하도록 신경써야한다.
- accessibilityReduceTransparency : 투명도와 blur 효과를 조절할 수 있다. 이 옵션이 적용되면 모든 alpha 값이 1로 설정되어야한다.
- accessibilityReduceMotion : 몇몇 애니메이션을 삭제 혹은 속도 감소를 일으키는 효과가 있다.
- legibilityWeight : 모든 글씨를 bold체로 보여준다.
- UIAccessibility.isOnOffSwitchLabelsEnabled : On/off toggle을 0과 1로 보여주는 옵션에 대응할지 선택하는 modifier, 만약 custom toggle의 디자인이 망가진다면 재 디자인을 해야한다.
- Button Shapes : 사용 가능한 버튼을 underline blue text로 표시해주는 기능, 마찬가지로 custom button의 디자인이 망가진다면 redesign 하는걸 고려해야한다. (별도 관련 modifier가 없다)
- UIAccessibility.isGrayscaleEnabled : Gray scale로 바꿔줄때 대응할지 정하는 modifier
- accessibilityDifferentiateWithoutColor : color를 정보로 사용하는 UI item에 대해서 다른 정보를 제공해주는 기능에 대한 modifier, 언제나 shape 혹은 additional text로 color 외의 정보를 제공해주는 방법을 고려해주자.

## Gestures
Accessibility를 적용하면 많은 gesture가 먹통이 된다.
이럴경우 accessibility를 위한 button을 추가하는 등의 작업으로 대응할 수 있다.

## Alert
기본적으로 SwiftUI alert에서는 accessibility modifier를 적용할 수 없다.
따라서 유저는 Modal 과 같은 방식으로 다른 view를 이용해야한다.

## Dark Mode
기본적으로 몇몇 컬러들은 darkmode를 자동적으로 지원한다.
예를들어 systemBlue, label, systemFill, systemBackground 같은 것들은 다크모드에 맞춰 본인의 컬러를 조절한다.

## Text Font
마찬가지로 정확한 size를 지정하는 것이 아닌, font(.headline) 과 같은 방식으로 지정하게 되면
Larger Text에 대응해 화면의 font를 조절해준다.

## Environment
몇몇 accessibility는 environment를 이용해 접근할 수 있다.
@Environment(\.sizeCategory) -> Accessibility의 Larger Text에 대응
