# Chapter 3
## 목표
1. SwiftUI Modifier를 활용하여 기존 앱을 최신 디자인 트랜드인 neumorphism애 맞춰 변경하는 것을 연습해보자.

## Modifier
Modifier는 기존 view로부터 새로운 view를 만드는 method로 마치 pipeline처럼 chain을 걸어 view를 customize 할 수 있다. modifier는 일반적으로 어떤 View에든 적용 가능하지만 몇몇 modifier는 특정 Type의 View에만 적용될 수 있는 것들이 존재한다. 따라서 modifier 적용 순서에 따라 동작 여부가 달라진다던지 하기때문에 순서에 주의해야한다. 대표적으로 예를들면 Padding과 border로 순서에 따라서 padding 위에 border가 그려지기도하고 border를 그린 뒤 padding이 적용되기도 한다.

<img width="248" alt="Chapter3-1" src="https://user-images.githubusercontent.com/78075226/168436872-cecb27c3-901b-468a-b9e1-811adfa95358.png">

<img width="238" alt="Chapter3-2" src="https://user-images.githubusercontent.com/78075226/168436880-cbc3c4b0-236e-4201-bf94-8ec73816028a.png">

우측 상단의 + 버튼을 누르면 library에 존재하는 미리 만들어진 view와 modifier를 가볍게 쓸 수 있다.

- `Shadow modifier` : 
view 주위의 원하는 위치에 특정 color의 shadow를 넣을 수 있다.
이때 radius와 x, y offset을 이용해 어떻게 shadow를 넣을 지 위치를 정한다.

- `ignoresSafeArea` : 
Safe Area를 무시하게 만들 수 있다.

- `Background` : 
View의 배경을 특정 View로 설정할 수 있다.
Color와 같은 색깔을 지정할 수도, Capsule과 같은 도형을 지정할 수도 있다.

- `Font` : 
글자의 font를 변경할 수 있다. 기본적으로 있는 font를 사용할 수도 있고
사용자 정의 font를 사용할 수도 있다.
Size 및 bold 여부등도 지정 가능하다.

## Neumorphism
Neumorphism이란 새로운 스큐어모피즘으로 평평하고 간략화된 UI에 대항하여 나온 기법이다. Neumorphic UI 원소들은 background로부터 마치 나와있는 것같은 이펙트를 주어 flat 3d 효과를 나타낸다. 다음 그림을 보면 이해가 쉽다.

<img width="498" alt="Chapter3-3" src="https://user-images.githubusercontent.com/78075226/168436884-22360ef4-d282-4d79-a1e8-0e8350f36c21.png">

이를 만들기 위해서는 전반적인 버튼을 담당하는 색, 밝은 부분에 표현될 lighter color, 그림자 부분에 표현될 darker color 3가지 색이 필요하다.

## Creating Custom Button Style
ButtonStyle protocol은 ButtonStyleConfiguration을 제공해주는 protocol이다.
해당 configuration에는 2가지의 property가 존재한다.
label과 유저가 버튼을 눌렀는지 알려주는 boolean이다.

<img width="574" alt="Chapter3-4" src="https://user-images.githubusercontent.com/78075226/168436890-12132a7a-dc57-40cc-92cd-96cf2ddbb5fe.png">

makeBody 함수안에서 configuration 의 label을 이용해 최종적으로 나올 button의 모양을 결정해줄 수 있다.
이 때 유의할 점은 기존에 자연스럽게 사용하던 button 효과가 사라질 수 있다는 것이다. 
예를들어 기본 text 컬러라던지 클릭시 버튼이 깜빡거린다던지하는 효과 말이다.
이는 default로 적용되던 효과를 custom button style로 교체했기 때문에 당연한 결과이다.
만약 이를 구현해주고 싶다면 opacity 혹은 foreground color를 이용해서 교체해주자.

## Geometry Reader
다양한 화면에 대응하는 View를 만들고 싶다면 Geometry Reader를 사용해보자.
Geometry Reader는 해당 View가 그려질 Frame, Size, SafeAreaInset을 알려주는 역할을 한다.
따라서 geometry 값과 font, ratio등의 비율을 이용해서 view를 그려내는 방법을 주로 사용한다.

<img width="667" alt="Chapter3-5" src="https://user-images.githubusercontent.com/78075226/168436894-f6f975a0-a47c-439f-a2c2-97e91b362b8a.png">
