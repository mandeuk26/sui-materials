# Chapter 5

## Text
String을 입력으로 받아 화면에 보여주는 View. 일반적으로 사용 가능한 modifier로는 다음과 같다.

- font : 주어진 font로 변경 가능
- bold : Text bold 기능
- foregroundColor : Text color 변경
- lineLimit : 최대 라인 수, default is nil (no limit)
- multilineTextAlignment : line의 alignment(leading, center, trailing) 지정, default is .leading

## Modifier
전에 얘기했듯이 모든 modifier는 View protocol에 적용가능해서 모든 View에 적용가능한 것과 특정 type에 대한 modifier가 존재한다.

swiftui는 modifier stack을 효율적인 data 구조로 바꾸는 방법이 존재한다. 
따라서 modifier를 많이 쓰는것이 성능에 영향을 미칠까 걱정할 필요가 없다.

또한 modifier는 순서에 영향을 받는다. Padding을 적용한 뒤 Background를 칠하는 것과 Background를 칠한 뒤 Padding을 적용하는 것은 다르다는 것을 명심하자.

## Image
별다른 modifier가 없으면 자체적인 해상도와 aspect ratio를 유지한채로 그려진다. 
만약 image의 size를 바꾸고 싶다면 resize modifier를 사용해야 한다.
적용하지 않고 frame을 변경시킨다면 View의 크기 자체는 변하나 image의 크기는 원본을 그대로 유지하게 된다.

- resizable(inset:mode:) : 4방향에 대한 inset과 resizing mode를 선택하여 resizable한 view로 만든다. 이 때 inset은 주어지지 않으면 no inset이 되고 mode는 .tile(반복 배치)/.stretch(확장) 중에 .stretch가 된다.
- cornerRadius : 정해진 만큼 모서리에 radius를 준다.
- overlay : 현재 View위에 특정 layer를 그린다.
- clipShape : Image를 clip 시킬 shape를 지정한다.
- scaledToFit : parent 안에서 이미지가 모두 보이는 선에서 최대한 확대한다. 이 때 aspect ratio는 유지한다.
- aspectRatio : AspectRatio를 설정할 수 있다. 이 때 fit/fill을 선택해 부모 view에 어떻게 대응할 것인지 정할 수 있다. default는 1:1 이 된다.
- ignoresSafeArea : SafeArea를 무시한다.
- saturation : Color Saturation을 줄일 수 있다. 0-1 value
- blur : Blur 효과를 추가한다. 0-1 value
- opacity : 투명도 설정을 한다. 0-1 value

## Container
여러개의 View를 묶어서 표시하고 싶다면 Container를 사용해야한다.
Container에 적용된 modifier는 하위 View들에게 modifier를 적용시키는 효과가 있다.

- HStack : 수평 관계
- VStack : 수직 관계
- ZStack : Z축 상에 여러 View를 겹쳐 놓고싶을때 사용

## Label
Text와 Image를 Hstack으로 묶을 필요없이 사용 가능한 View이다. Title과 Icon 2가지 매개변수를 받아서 View를 그린다. 총 3가지 style이 존재하며, 만약 3개로 모자라다면 직접 LabelStyle을 만들 수 있다. LabelStyle을 상속받은 후 makeBody 함수를 정의해주면 된다. 이 때 configuration에는 매개변수로 받은 Title과 Icon이 존재한다.

- DefaultLabelStyle : no style, 그저 Title 과 Icon을 순차적으로 보여줌
- IconOnlyLabelStyle : icon만 표시
- TitleOnlyLabelStyle : Title만 표시

```swift
struct CustomLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
    }
}

Label()
    .labelStyle(CustomLabelStyle())
```
