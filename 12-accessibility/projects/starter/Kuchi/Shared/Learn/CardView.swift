/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct CardView: View {
    typealias CardDrag = (_ card: FlashCard, _ direction: DiscardedDirection) -> Void

    let dragged: CardDrag
    let flashCard: FlashCard
    @State var revealed = false
    @State var offset: CGSize = .zero
    @GestureState var isLongPressed = false
    @Binding var cardColor: Color

    init(
        _ card: FlashCard,
        cardColor: Binding<Color>,
        onDrag dragged: @escaping CardDrag = { _, _ in }
    ) {
        self.flashCard = card
        self.dragged = dragged
        self._cardColor = cardColor
    }

    func discardCard(to direction: DiscardedDirection) {
        let width: CGFloat
        switch direction {
        case .left: width = -1000
        case .right: width = 1000
        }
        offset = .init(width: width, height: 0)
        dragged(flashCard, direction)
    }

    var body: some View {
        let drag = DragGesture()
            .onChanged { offset = $0.translation }
            .onEnded {
                if $0.translation.width < -100 {
                    discardCard(to: .left)
                } else if $0.translation.width > 100 {
                    discardCard(to: .right)
                } else {
                    offset = .zero
                }
            }

        let longPress = LongPressGesture()
            .updating($isLongPressed) { value, state, _ in
                state = value
            }
            .simultaneously(with: drag)

        VStack {
            ZStack {
                Rectangle()
                    .fill(cardColor)
                    .frame(width: 320, height: 210)
                    .cornerRadius(12)
                VStack {
                    Spacer()
                    Text(flashCard.card.question)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    if self.revealed {
                        Text(flashCard.card.answer)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
            .shadow(radius: 8)
            .frame(width: 320, height: 210)
            .animation(.spring())
            .gesture(
                TapGesture()
                    .onEnded {
                        withAnimation(.easeIn) {
                            revealed.toggle()
                        }
                    }
            )
            .simultaneousGesture(longPress)
            .scaleEffect(isLongPressed ? 1.1 : 1)

            HStack {
                Button { discardCard(to: .left) } label: {
                    Image(systemName: "arrowshape.turn.up.left.circle")
                        .accessibilityLabel(Text("Swipes left"))
                }
                Spacer()
                Button { discardCard(to: .right) } label: {
                    Image(systemName: "arrowshape.turn.up.right.circle")
                        .accessibilityLabel(Text("Swipes right"))
                }
            }
            .padding(45)
            .font(.largeTitle)
        }
        .offset(offset)

    }
}

struct CardView_Previews: PreviewProvider {
    @State static var cardColor = Color.red

    static var previews: some View {
        let card = FlashCard(
            card: Challenge(
                question: "Apple",
                pronunciation: "Apple",
                answer: "Omena"
            )
        )
        return CardView(card, cardColor: $cardColor)
    }
}
