# Chapter 8

## 목표
1. View-Model간의 양방향 업데이트를 하는 방법에 대해 배워보자.

## MVC
기존 UIKit에서 사용하던 방식으로 Model-View-Controller로 이루어져있다.
Model의 변화를 View에게 Controller가 알려주어 혹은 반대로 알려주어 업데이트하는 방식이다.
한쪽을 바꾼다고 다른쪽이 자동으로 변하지 않고 code로 manual하게 변경해야한다.

## SwiftUI functional way
SwiftUI는 다음과 같은 특성을 만족해야한다.
- Declarative : user interface를 declare한다.
- Functional : 같은 State를 주면 항상 같은 UI를 얻는다.
- Reactive : State가 변하면 SwiftUI는 자동으로 UI를 업데이트한다.

## @State
struct에서 value를 modifying 하려면 mutable 해야한다.
하지만 body는 기본적으로 mutate 할 수 없다.
따라서 이를 해결하기 위해 State를 사용한다.

State란 값을 읽고 쓸수있는 property wrapper를 의미한다.
SwiftUI는 state로 선언한 모든 property를 관리한다.
만약 state value가 변한다면 view는 UI를 멈추고 body를 재계산한다.
State는 single source of truth로 사용해야한다.

이때 @State는 State<Value>와 무슨 차이가 있는것일까?
@State로 선언하면 complier에 의해 자동으로 State<Value> 타입으로 변경된다.
그 후 state name에 대해서 underscore버전으로 변경하여 State<Value>를 접근하게 해준다.

## @Binding
Component는 데이터를 들고있지 않는다.
대신 data에 대한 reference를 들고있어서 model이 변할때 자동적으로 업데이트가 이루어지게 해준다.
이 때 View쪽의 변화를 Model에 바로 알려주고싶다면 delegate를 쓰던 UIKit방식과는 다르게 Binding을 사용한다.
Binding이란 데이터를 저장하는 property와 data를 보여주는 view간의 양방향 커넥션으로 어딘가에 저장되어 있는 source of truth property와 연결해주는 역할을 한다.

## Single source of truth
모든 data는 하나의 entity만 소유하고있고 다른 entity는 같은 data에 접근할 수 있어야 한다. (복사가 아니라)
우리가 쓰는 State는 value type이다. 
따라서 모든 곳에서 @State 선언으로 property를 만들고 property를 넘겨주는 방식으로 구현하게 되면 각각은 copy본을 갖고있게 되는 것이기 때문에 하나의 source로 연동되지 못한다.
따라서 우리는 1개의 State만을 선언하고 다른 곳에서는 Binding을 통해 접근하게 해야한다.
