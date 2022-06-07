# Chapter 11
## 목표
1. gesture와 같은 유저 interaction을 어떻게 다루는지 배운다.

## TapGesture
탭 기능을 제공하고자 할 떄 사용한다.
`gesture` modifier를 이용하여 parameter로 넘겨줘야한다.
이 때 tap gesture는 몇번의 tap을 받아야할지를 parameter로 넘겨받을 수 있다.
만약 gesture 인식시 특별한 행동을 하게하고 싶다면 `.onEnded` modifier를 이용해 action을 정의해주면 된다.

## DragGesture
Drag 기능을 제공하고자 할 때 사용하며 tap과 동일하게 `gesture` modifier로 넘겨서 사용한다.
`onChanged`의 경우 drag가 이루어질 때마다 해 줄 action을 정의할 수 있고
`onEnded`에서 drag가 끝날 때 해 줄 action을 정의할 수 있다.

## LongPressGesture
Long press를 제공할 때 사용하며 tap과 동일하게 `gesture` modifier로 넘겨서 사용한다.
`updating` modifier를 이용해서 관리해줄 gesture state를 지정할 수 있다.

## @GestureState
gesture의 상태를 저장할 수 있는 state attribute이다. 
이 property wrapper는 @State와 다르게 gesture가 완료되었을때 초기화되는 특성이 있다.

## Combining Gestures
일부 제스쳐는 다른 제스쳐와 기본적으로 동시에 작동할 수 없는 경우가 있다. (tap과 longPress 등)
이럴 경우 다음과 같은 속성을 이용해 여러 제스쳐를 동시에 처리할 수 있게 변경해주어야 한다.
- sequenced : 제스쳐 이후에 다른 제스쳐가 올 경우
- simultaneous : 제스쳐와 다른 제스쳐가 동시에 활성화 될 때
- exclusive : 제스쳐들 간에 한번에 하나만 활성화 되야 할 때

## ScaleEffect
View의 scale을 지정해 줄 수 있는 modifier.
